mod cli;
mod state;
mod theme;
mod filter;
mod float;
mod hint;
mod banner;

use std::io;
use std::thread;
use std::time::Duration;

use anyhow::{anyhow, Result};
use clap::Parser;
use crossterm::{
    event::{self, Event, KeyCode, KeyEventKind},
    execute,
    terminal::{disable_raw_mode, enable_raw_mode, EnterAlternateScreen, LeaveAlternateScreen},
};
use ratatui::{
    backend::{Backend, CrosstermBackend},
    layout::{Alignment, Rect},
    style::{Color, Style, Stylize},
    text::{Line, Span, Text},
    widgets::{Block, Borders, Clear, Paragraph, Widget},
    Terminal,
};

use crate::cli::Args;
use crate::state::{AppState, Focus};
use crate::theme::Theme;

fn main() {
    let args = Args::parse();

    let theme = Theme::from_name(&args.theme);
    let validate = !args.override_validation;

    let catalog = zzyutil_core::inner::get_catalog(validate);

    let mut app = AppState::new(catalog, theme);
    app.focus = Focus::List;

    if let Err(e) = run_tui(&mut app, &args) {
        eprintln!("Error: {}", e);
        std::process::exit(1);
    }
}

fn run_tui(app: &mut AppState, args: &Args) -> Result<()> {
    enable_raw_mode().map_err(|e| anyhow!("Failed to enable raw mode: {}", e))?;
    let mut stdout = io::stdout();
    execute!(stdout, EnterAlternateScreen)
        .map_err(|e| anyhow!("Failed to enter alternate screen: {}", e))?;
    let backend = CrosstermBackend::new(stdout);
    let mut terminal = Terminal::new(backend)
        .map_err(|e| anyhow!("Failed to create terminal: {}", e))?;

    if args.mouse {
        execute!(std::io::stdout(), crossterm::event::EnableMouseCapture)
            .map_err(|e| anyhow!("Failed to enable mouse capture: {}", e))?;
    }

    let result = run_app(&mut terminal, app);

    if args.mouse {
        let _ = execute!(
            std::io::stdout(),
            crossterm::event::DisableMouseCapture
        );
    }

    let _ = disable_raw_mode();
    let _ = execute!(terminal.backend_mut(), LeaveAlternateScreen);
    let _ = terminal.show_cursor();

    result
}

fn run_app<B: Backend>(terminal: &mut Terminal<B>, app: &mut AppState) -> Result<()> {
    loop {
        if let Some(script) = app.pending_script.take() {
            if let Err(e) = execute_script(terminal, app, &script) {
                app.running_output = Some((
                    "Error".to_string(),
                    Text::from(format!("Script error: {}", e)),
                ));
                app.focus = Focus::Float;
                continue;
            }
        }

        terminal.draw(|frame| app.draw(frame))
            .map_err(|e| anyhow!("Failed to draw terminal: {}", e))?;

        if let Event::Key(key) = event::read()
            .map_err(|e| anyhow!("Failed to read event: {}", e))?
        {
            if key.kind != KeyEventKind::Press {
                continue;
            }

            match app.focus {
                Focus::TabList | Focus::List => match key.code {
                    KeyCode::Char('/') => {
                        app.focus = Focus::Search;
                        continue;
                    }
                    KeyCode::Tab => { app.next_tab(); continue; }
                    KeyCode::BackTab => { app.prev_tab(); continue; }
                    KeyCode::Char('v') | KeyCode::Char('V') => {
                        app.multi_select_mode = !app.multi_select_mode;
                        continue;
                    }
                    KeyCode::Char('i') | KeyCode::Char('I') => {
                        app.show_installed_only = !app.show_installed_only;
                        app.scroll = 0;
                        continue;
                    }
                    KeyCode::Char('q') => return Ok(()),
                    _ => {}
                },
                _ => {}
            }

            match app.focus {
                Focus::Float => match key.code {
                    KeyCode::Esc | KeyCode::Char('q') => {
                        app.description_content = None;
                        app.running_output = None;
                        app.focus = Focus::List;
                    }
                    _ => {}
                },
                Focus::Confirm => match key.code {
                    KeyCode::Char('y') | KeyCode::Char('Y') => {
                        app.confirm_yes();
                    }
                    KeyCode::Char('n') | KeyCode::Char('N') | KeyCode::Esc => {
                        app.confirm_no();
                    }
                    _ => {}
                },
                Focus::Search => match key.code {
                    KeyCode::Char(c) => {
                        app.filter.push_char(c);
                    }
                    KeyCode::Backspace => {
                        app.filter.pop_char();
                    }
                    KeyCode::Left => {
                        app.filter.move_left();
                    }
                    KeyCode::Right => {
                        app.filter.move_right();
                    }
                    KeyCode::Esc => {
                        app.filter.clear();
                        app.focus = Focus::List;
                    }
                    KeyCode::Enter => {
                        app.focus = Focus::List;
                    }
                    _ => {}
                },
                Focus::TabList => match key.code {
                    KeyCode::Char('j') | KeyCode::Down => app.next_tab(),
                    KeyCode::Char('k') | KeyCode::Up => app.prev_tab(),
                    KeyCode::Enter | KeyCode::Char('l') | KeyCode::Right => {
                        app.focus = Focus::List;
                    }
                    _ => {}
                },
                Focus::List => match key.code {
                    KeyCode::Char('j') | KeyCode::Down => {
                        let max = app.visible_entries().len();
                        app.navigate_down(max);
                    }
                    KeyCode::Char('k') | KeyCode::Up => app.navigate_up(),
                    KeyCode::Enter | KeyCode::Char('l') | KeyCode::Right => app.execute(),
                    KeyCode::Char('h') | KeyCode::Left | KeyCode::Backspace => {
                        app.go_back_or_focus_tabs();
                    }
                    KeyCode::Char('d') | KeyCode::Char('D') => app.show_description(),
                    KeyCode::Char(' ') => {
                        if app.multi_select_mode {
                            app.toggle_select();
                        }
                    }
                    KeyCode::Esc => return Ok(()),
                    _ => {}
                },
            }
        }
    }
}

fn execute_script<B: Backend>(
    terminal: &mut Terminal<B>,
    app: &mut AppState,
    script: &str,
) -> Result<()> {
    let spinner = ["⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"];
    let mut spin_idx = 0;

    let mut child = std::process::Command::new("sh")
        .arg("-c")
        .arg(script)
        .stdin(std::process::Stdio::null())
        .stdout(std::process::Stdio::piped())
        .stderr(std::process::Stdio::piped())
        .spawn()
        .map_err(|e| anyhow!("Failed to execute script: {}", e))?;

    loop {
        if let Some(status) = child.try_wait().map_err(|e| anyhow!("{}", e))? {
            let output = child.wait_with_output().map_err(|e| anyhow!("{}", e))?;

            let exit_code = status.code().unwrap_or(-1);
            let stdout_str = String::from_utf8_lossy(&output.stdout);
            let stderr_str = String::from_utf8_lossy(&output.stderr);

            let mut lines: Vec<Line> = Vec::new();

            if status.success() {
                lines.push(Line::from(vec![
                    Span::styled("  ✓ ", Style::default().fg(Color::Green).bold()),
                    Span::styled(
                        format!("Success (exit code: {})", exit_code),
                        Style::default().fg(Color::Green),
                    ),
                ]));
            } else {
                lines.push(Line::from(vec![
                    Span::styled("  ✗ ", Style::default().fg(Color::Red).bold()),
                    Span::styled(
                        format!("Failed (exit code: {})", exit_code),
                        Style::default().fg(Color::Red),
                    ),
                ]));
            }

            if !stdout_str.is_empty() {
                lines.push(Line::from(""));
                lines.push(Line::from(Span::styled(
                    "  ── stdout ──",
                    Style::default().fg(Color::DarkGray),
                )));
                for line in stdout_str.lines() {
                    lines.push(Line::from(vec![Span::raw(format!("  {}", line))]));
                }
            }

            if !stderr_str.is_empty() {
                lines.push(Line::from(""));
                lines.push(Line::from(Span::styled(
                    "  ── stderr ──",
                    Style::default().fg(Color::DarkGray),
                )));
                for line in stderr_str.lines() {
                    lines.push(Line::from(vec![Span::styled(
                        format!("  {}", line),
                        Style::default().fg(Color::Red),
                    )]));
                }
            }

            if lines.is_empty() {
                lines.push(Line::from(Span::styled(
                    "  (no output)",
                    Style::default().fg(Color::DarkGray),
                )));
            }

            let title = if status.success() { "Output" } else { "Error" };
            app.running_output = Some((title.to_string(), Text::from(lines)));
            app.focus = Focus::Float;
            app.confirm_message = None;
            app.selected.clear();
            app.multi_select_mode = false;

            break;
        }

        terminal
            .draw(|frame| {
                let area = frame.area();
                let w = area.width * 70 / 100;
                let h = area.height * 60 / 100;
                let x = area.x + (area.width - w) / 2;
                let y = area.y + (area.height - h) / 2;
                let float_area = Rect { x, y, width: w, height: h };

                Clear.render(float_area, frame.buffer_mut());

                let block = Block::default()
                    .title(Span::styled(" Running... ", app.theme.float_title_fg()).bold())
                    .title_alignment(Alignment::Center)
                    .borders(Borders::ALL)
                    .border_style(Style::default().fg(app.theme.float_border_fg()))
                    .border_type(ratatui::widgets::BorderType::Double);

                let inner = block.inner(float_area);
                block.render(float_area, frame.buffer_mut());

                let spinner_style = Style::default().fg(app.theme.tab_active_bg());
                let text = Text::from(vec![
                    Line::from(""),
                    Line::from(vec![
                        Span::styled(format!("  {} ", spinner[spin_idx]), spinner_style),
                        Span::styled("Executing command...", Style::default().fg(Color::DarkGray)),
                    ]),
                    Line::from(""),
                ]);
                let p = Paragraph::new(text);
                p.render(inner, frame.buffer_mut());
            })
            .map_err(|e| anyhow!("Failed to draw terminal: {}", e))?;

        spin_idx = (spin_idx + 1) % spinner.len();
        thread::sleep(Duration::from_millis(80));
    }

    Ok(())
}

use ratatui::{
    layout::{Alignment, Rect},
    style::{Style, Stylize},
    text::{Line, Span, Text},
    widgets::Paragraph,
    Frame,
};

use crate::theme::Theme;

pub struct Banner;

impl Banner {
    pub fn height() -> u16 {
        8
    }

    pub fn draw(frame: &mut Frame, area: Rect, theme: &Theme) {
        let fg = theme.border_fg();
        let bright = theme.title_fg();
        let dim = theme.hint_fg();
        let accent = theme.search_fg();

        let logo = vec![
            Line::from(vec![
                Span::styled("  ╔══════════════════════════════════════╗", Style::default().fg(dim)),
            ]),
            Line::from(vec![
                Span::styled("  ║", Style::default().fg(dim)),
                Span::styled(" 0", Style::default().fg(bright).bold()),
                Span::styled("x", Style::default().fg(dim)),
                Span::styled("██", Style::default().fg(fg).bold()),
                Span::styled("╗", Style::default().fg(dim)),
                Span::styled("  ZZYUTIL  ", Style::default().fg(accent).bold()),
                Span::styled("v2.1.0", Style::default().fg(dim)),
                Span::styled("                ║", Style::default().fg(dim)),
            ]),
            Line::from(vec![
                Span::styled("  ║", Style::default().fg(dim)),
                Span::styled("   ", Style::default()),
                Span::styled("╝", Style::default().fg(dim)),
                Span::styled("╚═══╝", Style::default().fg(fg)),
                Span::styled("                     ║", Style::default().fg(dim)),
            ]),
            Line::from(vec![
                Span::styled("  ║", Style::default().fg(dim)),
                Span::styled("   Made by ", Style::default().fg(fg)),
                Span::styled("0xClumzZy", Style::default().fg(accent).bold()),
                Span::styled("                        ║", Style::default().fg(dim)),
            ]),
            Line::from(vec![
                Span::styled("  ║", Style::default().fg(dim)),
                Span::styled("   ", Style::default()),
                Span::styled("@github.com/0xClumzzy", Style::default().fg(dim)),
                Span::styled("              ║", Style::default().fg(dim)),
            ]),
            Line::from(vec![
                Span::styled("  ╚══════════════════════════════════════╝", Style::default().fg(dim)),
            ]),
            Line::from(Span::styled("", Style::default())),
        ];

        let para = Paragraph::new(Text::from(logo)).alignment(Alignment::Left);
        frame.render_widget(para, area);
    }
}

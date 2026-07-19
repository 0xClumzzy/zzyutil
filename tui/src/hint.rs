use ratatui::text::Span;
use ratatui::style::{Color, Style};

use crate::theme::Theme;

#[derive(Debug, Clone)]
pub struct Shortcut {
    pub key: &'static str,
    pub action: &'static str,
}

pub fn create_shortcut_list(focus: &str, has_multi: bool) -> Vec<Shortcut> {
    match focus {
        "TabList" => vec![
            Shortcut { key: "j/k", action: "Navigate" },
            Shortcut { key: "l", action: "Focus List" },
            Shortcut { key: "/", action: "Search" },
            Shortcut { key: "i", action: "Installed" },
            Shortcut { key: "Tab", action: "Next Tab" },
            Shortcut { key: "q", action: "Quit" },
        ],
        "List" => {
            let mut shortcuts = vec![
                Shortcut { key: "j/k", action: "Navigate" },
                Shortcut { key: "l", action: "Install" },
                Shortcut { key: "h", action: "Back" },
                Shortcut { key: "/", action: "Search" },
                Shortcut { key: "d", action: "Info" },
                Shortcut { key: "i", action: "Installed" },
                Shortcut { key: "Tab", action: "Next Tab" },
                Shortcut { key: "q", action: "Quit" },
            ];
            if has_multi {
                shortcuts.insert(4, Shortcut { key: "Space", action: "Select" });
                shortcuts.insert(5, Shortcut { key: "v", action: "Multi" });
            }
            shortcuts
        }
        "Search" => vec![
            Shortcut { key: "Esc", action: "Cancel" },
            Shortcut { key: "Enter", action: "Confirm" },
        ],
        "Confirm" => vec![
            Shortcut { key: "y", action: "Yes" },
            Shortcut { key: "n", action: "No" },
        ],
        _ => vec![
            Shortcut { key: "q", action: "Quit" },
        ],
    }
}

pub fn render_shortcuts<'a>(shortcuts: &[Shortcut], theme: &Theme) -> Vec<Span<'a>> {
    let mut spans = Vec::new();
    for (i, sc) in shortcuts.iter().enumerate() {
        if i > 0 {
            spans.push(Span::styled(" │ ", Style::default().fg(Color::Rgb(60, 30, 30))));
        }
        spans.push(Span::styled(
            sc.key,
            Style::default().fg(theme.hint_key_fg()).bold(),
        ));
        spans.push(Span::styled(
            format!(" {}", sc.action),
            Style::default().fg(theme.hint_action_fg()),
        ));
    }
    spans
}

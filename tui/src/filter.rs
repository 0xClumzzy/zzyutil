use ratatui::{
    buffer::Buffer,
    layout::Rect,
    style::Style,
    text::{Line, Span},
    widgets::{Block, Borders, Paragraph, Widget},
};

use crate::theme::Theme;

#[derive(Debug, Default)]
pub struct Filter {
    pub query: String,
    pub cursor: usize,
}

impl Filter {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn push_char(&mut self, c: char) {
        self.query.insert(self.cursor, c);
        self.cursor += 1;
    }

    pub fn pop_char(&mut self) {
        if self.cursor > 0 {
            self.query.remove(self.cursor - 1);
            self.cursor -= 1;
        }
    }

    pub fn move_left(&mut self) {
        if self.cursor > 0 {
            self.cursor -= 1;
        }
    }

    pub fn move_right(&mut self) {
        if self.cursor < self.query.len() {
            self.cursor += 1;
        }
    }

    pub fn clear(&mut self) {
        self.query.clear();
        self.cursor = 0;
    }

    pub fn is_active(&self) -> bool {
        !self.query.is_empty()
    }

}

pub struct FilterWidget<'a> {
    filter: &'a Filter,
    theme: &'a Theme,
    focused: bool,
}

impl<'a> FilterWidget<'a> {
    pub fn new(filter: &'a Filter, theme: &'a Theme, focused: bool) -> Self {
        Self { filter, theme, focused }
    }
}

impl Widget for FilterWidget<'_> {
    fn render(self, area: Rect, buf: &mut Buffer) {
        let border_color = if self.focused {
            self.theme.border_focus_fg()
        } else {
            self.theme.border_fg()
        };
        let block = Block::default()
            .borders(Borders::ALL)
            .border_style(Style::default().fg(border_color))
            .title(Span::styled(
                " Search ",
                Style::default().fg(self.theme.title_fg()),
            ));

        let inner = block.inner(area);
        block.render(area, buf);

        let display = if self.filter.query.is_empty() && !self.focused {
            "Type to search...".to_string()
        } else {
            self.filter.query.clone()
        };

        let style = if self.focused {
            Style::default().fg(self.theme.search_fg())
        } else {
            Style::default().fg(self.theme.hint_fg())
        };

        let line = Line::from(display);
        Paragraph::new(line)
            .style(style)
            .render(inner, buf);

        if self.focused {
            let cursor_x = inner.x + self.filter.cursor as u16;
            if cursor_x < inner.right() {
                buf.set_style(Rect::new(cursor_x, inner.y, 1, 1), Style::default().reversed());
            }
        }
    }
}

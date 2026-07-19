use ratatui::{
    buffer::Buffer,
    layout::{Alignment, Rect},
    style::{Color, Style, Stylize},
    text::{Span, Text},
    widgets::{Block, Borders, Clear, Paragraph, Widget, Wrap},
};

pub struct Float<'a> {
    title: &'a str,
    content: Text<'a>,
    footer: Option<(&'a str, Style)>,
    width_pct: u16,
    height_pct: u16,
    border_style: Style,
    title_style: Style,
}

impl<'a> Float<'a> {
    pub fn new(title: &'a str, content: Text<'a>) -> Self {
        Self {
            title,
            content,
            footer: None,
            width_pct: 70,
            height_pct: 60,
            border_style: Style::default().fg(Color::Rgb(180, 50, 50)),
            title_style: Style::default().fg(Color::Rgb(255, 80, 80)).bold(),
        }
    }

    pub fn footer(mut self, text: &'a str, style: Style) -> Self {
        self.footer = Some((text, style));
        self
    }

    pub fn border_style(mut self, style: Style) -> Self {
        self.border_style = style;
        self
    }

    pub fn title_style(mut self, style: Style) -> Self {
        self.title_style = style;
        self
    }

    pub fn area(&self, parent: Rect) -> Rect {
        let w = parent.width * self.width_pct / 100;
        let h = parent.height * self.height_pct / 100;
        let x = parent.x + (parent.width - w) / 2;
        let y = parent.y + (parent.height - h) / 2;
        Rect { x, y, width: w, height: h }
    }
}

impl Widget for Float<'_> {
    fn render(self, area: Rect, buf: &mut Buffer) {
        let float_area = self.area(area);

        Clear.render(float_area, buf);

        let block = Block::default()
            .title(Span::styled(
                format!(" {} ", self.title),
                self.title_style,
            ))
            .title_alignment(Alignment::Center)
            .borders(Borders::ALL)
            .border_style(self.border_style)
            .border_type(ratatui::widgets::BorderType::Double);

        let inner = block.inner(float_area);
        block.render(float_area, buf);

        if let Some((footer_text, footer_style)) = self.footer {
            if inner.height > 1 {
                let footer_area = Rect {
                    x: inner.x,
                    y: inner.y + inner.height.saturating_sub(1),
                    width: inner.width,
                    height: 1,
                };
                let content_area = Rect {
                    x: inner.x,
                    y: inner.y,
                    width: inner.width,
                    height: inner.height.saturating_sub(1),
                };
                let p = Paragraph::new(self.content)
                    .wrap(Wrap { trim: false })
                    .block(Block::default());
                p.render(content_area, buf);
                let hint = Paragraph::new(Span::styled(footer_text, footer_style));
                hint.render(footer_area, buf);
            } else {
                let p = Paragraph::new(self.content)
                    .wrap(Wrap { trim: false })
                    .block(Block::default());
                p.render(inner, buf);
            }
        } else {
            let p = Paragraph::new(self.content)
                .wrap(Wrap { trim: false })
                .block(Block::default());
            p.render(inner, buf);
        }
    }
}

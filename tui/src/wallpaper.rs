use ratatui::{
    buffer::Buffer,
    layout::Rect,
    style::Color,
    widgets::Widget,
};

pub struct Wallpaper {
    pub pattern: WallpaperPattern,
    pub color: Color,
}

#[derive(Debug, Clone, Copy)]
pub enum WallpaperPattern {
    Dots,
    Lines,
    Cross,
    Diamond,
    None,
}

impl Wallpaper {
    pub fn new(pattern: WallpaperPattern, color: Color) -> Self {
        Self { pattern, color }
    }

    pub fn default_dark() -> Self {
        Self::new(WallpaperPattern::Dots, Color::Rgb(30, 30, 40))
    }

    pub fn default_cyber() -> Self {
        Self::new(WallpaperPattern::Cross, Color::Rgb(0, 40, 0))
    }
}

impl Widget for Wallpaper {
    fn render(self, area: Rect, buf: &mut Buffer) {
        match self.pattern {
            WallpaperPattern::None => {}
            WallpaperPattern::Dots => {
                for y in 0..area.height {
                    for x in 0..area.width {
                        if (x + y) % 4 == 0 {
                            if let Some(cell) = buf.cell_mut((area.x + x, area.y + y)) {
                                cell.set_char('·');
                                cell.set_fg(self.color);
                            }
                        }
                    }
                }
            }
            WallpaperPattern::Lines => {
                for y in 0..area.height {
                    for x in 0..area.width {
                        if y % 3 == 0 {
                            if let Some(cell) = buf.cell_mut((area.x + x, area.y + y)) {
                                cell.set_char('─');
                                cell.set_fg(self.color);
                            }
                        }
                    }
                }
            }
            WallpaperPattern::Cross => {
                for y in 0..area.height {
                    for x in 0..area.width {
                        if (x + y) % 6 == 0 {
                            if let Some(cell) = buf.cell_mut((area.x + x, area.y + y)) {
                                cell.set_char('+');
                                cell.set_fg(self.color);
                            }
                        }
                    }
                }
            }
            WallpaperPattern::Diamond => {
                for y in 0..area.height {
                    for x in 0..area.width {
                        if (x + y) % 8 == 0 && (x as i32 - y as i32).abs() % 4 == 0 {
                            if let Some(cell) = buf.cell_mut((area.x + x, area.y + y)) {
                                cell.set_char('◇');
                                cell.set_fg(self.color);
                            }
                        }
                    }
                }
            }
        }
    }
}

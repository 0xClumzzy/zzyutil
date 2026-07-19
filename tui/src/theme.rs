use ratatui::style::Color;

#[derive(Debug, Clone, Copy, PartialEq)]
pub enum Theme {
    Dark,
    Compatible,
    Cyber,
}

const fn rgb(r: u8, g: u8, b: u8) -> Color {
    Color::Rgb(r, g, b)
}

impl Theme {
    pub fn from_name(name: &str) -> Self {
        match name.to_lowercase().as_str() {
            "compatible" => Theme::Compatible,
            "cyber" => Theme::Cyber,
            _ => Theme::Dark,
        }
    }

    pub fn tab_active_bg(&self) -> Color {
        match self {
            Theme::Dark => rgb(180, 30, 30),
            Theme::Compatible => Color::White,
            Theme::Cyber => rgb(0, 200, 150),
        }
    }

    pub fn tab_active_fg(&self) -> Color {
        match self {
            Theme::Cyber => rgb(10, 10, 10),
            _ => Color::Black,
        }
    }

    pub fn tab_inactive_fg(&self) -> Color {
        match self {
            Theme::Dark => rgb(100, 40, 40),
            Theme::Compatible => Color::Gray,
            Theme::Cyber => rgb(0, 120, 90),
        }
    }

    pub fn selected_bg(&self) -> Color {
        match self {
            Theme::Dark => rgb(120, 25, 25),
            Theme::Compatible => Color::DarkGray,
            Theme::Cyber => rgb(0, 80, 60),
        }
    }

    pub fn selected_fg(&self) -> Color {
        match self {
            Theme::Dark => rgb(255, 200, 200),
            Theme::Compatible => Color::White,
            Theme::Cyber => rgb(200, 255, 240),
        }
    }

    pub fn directory_fg(&self) -> Color {
        match self {
            Theme::Dark => rgb(220, 60, 60),
            Theme::Compatible => Color::Yellow,
            Theme::Cyber => rgb(0, 255, 180),
        }
    }

    pub fn command_fg(&self) -> Color {
        match self {
            Theme::Dark => rgb(180, 80, 80),
            Theme::Compatible => Color::White,
            Theme::Cyber => rgb(100, 220, 200),
        }
    }

    pub fn hint_fg(&self) -> Color {
        match self {
            Theme::Dark => rgb(90, 35, 35),
            Theme::Compatible => Color::DarkGray,
            Theme::Cyber => rgb(0, 100, 75),
        }
    }

    pub fn search_fg(&self) -> Color {
        match self {
            Theme::Dark => rgb(255, 100, 100),
            Theme::Compatible => Color::Cyan,
            Theme::Cyber => rgb(0, 255, 200),
        }
    }

    pub fn border_fg(&self) -> Color {
        match self {
            Theme::Dark => rgb(140, 40, 40),
            Theme::Compatible => Color::Gray,
            Theme::Cyber => rgb(0, 150, 110),
        }
    }

    pub fn border_focus_fg(&self) -> Color {
        match self {
            Theme::Dark => rgb(220, 60, 60),
            Theme::Compatible => Color::White,
            Theme::Cyber => rgb(0, 255, 180),
        }
    }

    pub fn title_fg(&self) -> Color {
        match self {
            Theme::Dark => rgb(200, 50, 50),
            Theme::Compatible => Color::White,
            Theme::Cyber => rgb(0, 230, 170),
        }
    }

    pub fn hint_key_fg(&self) -> Color {
        match self {
            Theme::Dark => rgb(200, 80, 80),
            Theme::Compatible => Color::Yellow,
            Theme::Cyber => rgb(0, 255, 200),
        }
    }

    pub fn hint_action_fg(&self) -> Color {
        match self {
            Theme::Dark => rgb(120, 50, 50),
            Theme::Compatible => Color::Gray,
            Theme::Cyber => rgb(0, 140, 105),
        }
    }

    pub fn float_title_fg(&self) -> Color {
        match self {
            Theme::Dark => rgb(255, 80, 80),
            Theme::Compatible => Color::Cyan,
            Theme::Cyber => rgb(0, 255, 220),
        }
    }

    pub fn float_border_fg(&self) -> Color {
        match self {
            Theme::Dark => rgb(180, 50, 50),
            Theme::Compatible => Color::White,
            Theme::Cyber => rgb(0, 200, 150),
        }
    }
}

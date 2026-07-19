use ratatui::style::Color;

#[derive(Debug, Clone, Copy, PartialEq)]
pub enum Theme {
    Dark,
    Compatible,
    Cyber,
    Ocean,
    Dracula,
    Nord,
    Monokai,
    Solarized,
}

const fn rgb(r: u8, g: u8, b: u8) -> Color {
    Color::Rgb(r, g, b)
}

impl Theme {
    pub fn from_name(name: &str) -> Self {
        match name.to_lowercase().as_str() {
            "dark" => Theme::Dark,
            "cyber" => Theme::Cyber,
            "ocean" => Theme::Ocean,
            "dracula" => Theme::Dracula,
            "nord" => Theme::Nord,
            "monokai" => Theme::Monokai,
            "solarized" => Theme::Solarized,
            _ => Theme::Compatible,
        }
    }

    pub fn tab_active_bg(&self) -> Color {
        match self {
            Theme::Dark => rgb(180, 30, 30),
            Theme::Compatible => Color::White,
            Theme::Cyber => rgb(0, 200, 150),
            Theme::Ocean => rgb(0, 120, 200),
            Theme::Dracula => rgb(189, 147, 249),
            Theme::Nord => rgb(136, 192, 208),
            Theme::Monokai => rgb(248, 248, 42),
            Theme::Solarized => rgb(38, 139, 210),
        }
    }

    pub fn tab_active_fg(&self) -> Color {
        match self {
            Theme::Cyber | Theme::Monokai => rgb(10, 10, 10),
            _ => Color::Black,
        }
    }

    pub fn tab_inactive_fg(&self) -> Color {
        match self {
            Theme::Dark => rgb(100, 40, 40),
            Theme::Compatible => Color::Gray,
            Theme::Cyber => rgb(0, 120, 90),
            Theme::Ocean => rgb(60, 100, 140),
            Theme::Dracula => rgb(100, 100, 130),
            Theme::Nord => rgb(76, 86, 106),
            Theme::Monokai => rgb(150, 150, 100),
            Theme::Solarized => rgb(147, 161, 161),
        }
    }

    pub fn selected_bg(&self) -> Color {
        match self {
            Theme::Dark => rgb(120, 25, 25),
            Theme::Compatible => Color::DarkGray,
            Theme::Cyber => rgb(0, 80, 60),
            Theme::Ocean => rgb(0, 80, 140),
            Theme::Dracula => rgb(98, 114, 164),
            Theme::Nord => rgb(67, 76, 94),
            Theme::Monokai => rgb(80, 80, 60),
            Theme::Solarized => rgb(7, 54, 66),
        }
    }

    pub fn selected_fg(&self) -> Color {
        match self {
            Theme::Dark => rgb(255, 200, 200),
            Theme::Compatible => Color::White,
            Theme::Cyber => rgb(200, 255, 240),
            Theme::Ocean => rgb(200, 230, 255),
            Theme::Dracula | Theme::Monokai => rgb(248, 248, 242),
            Theme::Nord => rgb(236, 239, 244),
            Theme::Solarized => rgb(253, 246, 227),
        }
    }

    pub fn directory_fg(&self) -> Color {
        match self {
            Theme::Dark => rgb(220, 60, 60),
            Theme::Compatible => Color::Yellow,
            Theme::Cyber => rgb(0, 255, 180),
            Theme::Ocean => rgb(0, 180, 255),
            Theme::Dracula => rgb(255, 184, 108),
            Theme::Nord => rgb(163, 190, 140),
            Theme::Monokai => rgb(165, 214, 97),
            Theme::Solarized => rgb(42, 161, 152),
        }
    }

    pub fn command_fg(&self) -> Color {
        match self {
            Theme::Dark => rgb(180, 80, 80),
            Theme::Compatible => Color::White,
            Theme::Cyber => rgb(100, 220, 200),
            Theme::Ocean => rgb(150, 200, 240),
            Theme::Dracula | Theme::Monokai => rgb(248, 248, 242),
            Theme::Nord => rgb(216, 222, 233),
            Theme::Solarized => rgb(147, 161, 161),
        }
    }

    pub fn hint_fg(&self) -> Color {
        match self {
            Theme::Dark => rgb(90, 35, 35),
            Theme::Compatible => Color::DarkGray,
            Theme::Cyber => rgb(0, 100, 75),
            Theme::Ocean => rgb(60, 100, 140),
            Theme::Dracula => rgb(100, 100, 130),
            Theme::Nord => rgb(76, 86, 106),
            Theme::Monokai => rgb(120, 120, 100),
            Theme::Solarized => rgb(147, 161, 161),
        }
    }

    pub fn search_fg(&self) -> Color {
        match self {
            Theme::Dark => rgb(255, 100, 100),
            Theme::Compatible => Color::Cyan,
            Theme::Cyber => rgb(0, 255, 200),
            Theme::Ocean => rgb(0, 220, 255),
            Theme::Dracula => rgb(80, 250, 123),
            Theme::Nord => rgb(163, 190, 140),
            Theme::Monokai => rgb(166, 226, 46),
            Theme::Solarized => rgb(181, 137, 0),
        }
    }

    pub fn border_fg(&self) -> Color {
        match self {
            Theme::Dark => rgb(140, 40, 40),
            Theme::Compatible => Color::Gray,
            Theme::Cyber => rgb(0, 150, 110),
            Theme::Ocean => rgb(40, 80, 120),
            Theme::Dracula => rgb(98, 114, 164),
            Theme::Nord => rgb(59, 66, 82),
            Theme::Monokai => rgb(100, 100, 80),
            Theme::Solarized => rgb(88, 110, 117),
        }
    }

    pub fn border_focus_fg(&self) -> Color {
        match self {
            Theme::Dark => rgb(220, 60, 60),
            Theme::Compatible => Color::White,
            Theme::Cyber => rgb(0, 255, 180),
            Theme::Ocean => rgb(0, 180, 255),
            Theme::Dracula => rgb(189, 147, 249),
            Theme::Nord => rgb(136, 192, 208),
            Theme::Monokai => rgb(248, 248, 42),
            Theme::Solarized => rgb(38, 139, 210),
        }
    }

    pub fn title_fg(&self) -> Color {
        match self {
            Theme::Dark => rgb(200, 50, 50),
            Theme::Compatible => Color::White,
            Theme::Cyber => rgb(0, 230, 170),
            Theme::Ocean => rgb(0, 160, 230),
            Theme::Dracula => rgb(189, 147, 249),
            Theme::Nord => rgb(136, 192, 208),
            Theme::Monokai => rgb(248, 248, 42),
            Theme::Solarized => rgb(38, 139, 210),
        }
    }

    pub fn hint_key_fg(&self) -> Color {
        match self {
            Theme::Dark => rgb(200, 80, 80),
            Theme::Compatible => Color::Yellow,
            Theme::Cyber => rgb(0, 255, 200),
            Theme::Ocean => rgb(0, 200, 255),
            Theme::Dracula => rgb(255, 121, 198),
            Theme::Nord => rgb(191, 97, 106),
            Theme::Monokai => rgb(249, 38, 114),
            Theme::Solarized => rgb(203, 75, 22),
        }
    }

    pub fn hint_action_fg(&self) -> Color {
        match self {
            Theme::Dark => rgb(120, 50, 50),
            Theme::Compatible => Color::Gray,
            Theme::Cyber => rgb(0, 140, 105),
            Theme::Ocean => rgb(50, 90, 130),
            Theme::Dracula => rgb(100, 100, 130),
            Theme::Nord => rgb(76, 86, 106),
            Theme::Monokai => rgb(130, 130, 110),
            Theme::Solarized => rgb(147, 161, 161),
        }
    }

    pub fn float_title_fg(&self) -> Color {
        match self {
            Theme::Dark => rgb(255, 80, 80),
            Theme::Compatible => Color::Cyan,
            Theme::Cyber => rgb(0, 255, 220),
            Theme::Ocean => rgb(0, 240, 255),
            Theme::Dracula => rgb(189, 147, 249),
            Theme::Nord => rgb(136, 192, 208),
            Theme::Monokai => rgb(248, 248, 42),
            Theme::Solarized => rgb(38, 139, 210),
        }
    }

    pub fn float_border_fg(&self) -> Color {
        match self {
            Theme::Dark => rgb(180, 50, 50),
            Theme::Compatible => Color::White,
            Theme::Cyber => rgb(0, 200, 150),
            Theme::Ocean => rgb(0, 140, 210),
            Theme::Dracula => rgb(189, 147, 249),
            Theme::Nord => rgb(136, 192, 208),
            Theme::Monokai => rgb(248, 248, 42),
            Theme::Solarized => rgb(38, 139, 210),
        }
    }
}

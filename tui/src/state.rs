use std::rc::Rc;

use ratatui::{
    layout::{Constraint, Direction, Layout, Rect},
    style::{Color, Style, Stylize},
    text::{Line, Span, Text},
    widgets::{Block, Borders, List, ListItem, ListState, Paragraph, Widget},
    Frame,
};

use zzyutil_core::{Catalog, Command, ListNode};

fn is_command_installed(cmd: &Command) -> bool {
    !matches!(cmd, Command::None)
}

use crate::{
    banner::Banner,
    filter::{Filter, FilterWidget},
    float::Float,
    hint::{create_shortcut_list, render_shortcuts},
    theme::Theme,
};

#[derive(Debug, Clone, Copy, PartialEq)]
pub enum Focus {
    TabList,
    List,
    Search,
    Confirm,
    Float,
}

#[derive(Debug, Clone)]
pub(crate) struct FlatEntry {
    node_id: ego_tree::NodeId,
    node: Rc<ListNode>,
    depth: usize,
    has_children: bool,
}

pub struct AppState {
    pub catalog: Catalog,
    pub current_tab: usize,
    pub focus: Focus,
    pub visit_stack: Vec<(ego_tree::NodeId, usize)>,
    pub filter: Filter,
    pub theme: Theme,
    pub multi_select_mode: bool,
    pub selected: Vec<String>,
    pub scroll: usize,
    pub description_content: Option<String>,
    pub confirm_message: Option<String>,
    pub running_output: Option<(String, Text<'static>)>,
    pub pending_script: Option<String>,
    pub show_installed_only: bool,
}

impl AppState {
    pub fn new(catalog: Catalog, theme: Theme) -> Self {
        Self {
            catalog,
            current_tab: 0,
            focus: Focus::TabList,
            visit_stack: vec![],
            filter: Filter::new(),
            theme,
            multi_select_mode: false,
            selected: vec![],
            scroll: 0,
            description_content: None,
            confirm_message: None,
            running_output: None::<(String, Text<'static>)>,
            pending_script: None,
            show_installed_only: false,
        }
    }

    pub fn current_tree(&self) -> Option<&ego_tree::Tree<Rc<ListNode>>> {
        self.catalog.tabs.get(self.current_tab).map(|t| &t.tree)
    }

    pub fn current_node_id(&self) -> Option<ego_tree::NodeId> {
        if let Some(&(id, _)) = self.visit_stack.last() {
            Some(id)
        } else {
            self.current_tree().map(|t| t.root().id())
        }
    }

    pub fn visible_entries(&self) -> Vec<FlatEntry> {
        let tree = match self.current_tree() {
            Some(t) => t,
            None => return vec![],
        };

        let node_id = match self.current_node_id() {
            Some(id) => id,
            None => return vec![],
        };
        let node = match tree.get(node_id) {
            Some(n) => n,
            None => return vec![],
        };

        let depth = self.visit_stack.len();
        let mut entries: Vec<FlatEntry> = node
            .children()
            .map(|child| FlatEntry {
                node_id: child.id(),
                node: child.value().clone(),
                depth,
                has_children: child.has_children(),
            })
            .collect();

        if self.filter.is_active() {
            entries = self.filter_entries(tree, &entries);
        }

        if self.show_installed_only {
            entries.retain(|e| !e.has_children && is_command_installed(&e.node.command));
        }

        entries
    }

    fn filter_entries(
        &self,
        tree: &ego_tree::Tree<Rc<ListNode>>,
        _entries: &[FlatEntry],
    ) -> Vec<FlatEntry> {
        let query = self.filter.query.to_lowercase();
        let tree_root = tree.root().id();

        fn collect_matches(
            tree: &ego_tree::Tree<Rc<ListNode>>,
            id: ego_tree::NodeId,
            query: &str,
            results: &mut Vec<FlatEntry>,
            depth: usize,
        ) {
            if let Some(node) = tree.get(id) {
                let name = node.value().name.to_lowercase();
                let desc = node.value().description.to_lowercase();
                if name.contains(query) || desc.contains(query) {
                    results.push(FlatEntry {
                        node_id: node.id(),
                        node: node.value().clone(),
                        depth,
                        has_children: node.has_children(),
                    });
                }
                for child in node.children() {
                    collect_matches(tree, child.id(), query, results, depth + 1);
                }
            }
        }

        let mut results = vec![];
        collect_matches(tree, tree_root, &query, &mut results, 0);
        results
    }

    pub fn navigate_up(&mut self) {
        if self.scroll > 0 {
            self.scroll -= 1;
        }
    }

    pub fn navigate_down(&mut self, max: usize) {
        if self.scroll + 1 < max {
            self.scroll += 1;
        }
    }

    pub fn enter_directory(&mut self) {
        let entries = self.visible_entries();
        if self.scroll >= entries.len() {
            return;
        }
        let entry = &entries[self.scroll];
        if entry.has_children {
            self.visit_stack.push((entry.node_id, self.scroll));
            self.scroll = 0;
        }
    }

    pub fn at_root(&self) -> bool {
        self.visit_stack.is_empty()
    }

    pub fn go_back(&mut self) {
        if !self.visit_stack.is_empty() {
            let (_, prev_scroll) = self.visit_stack.pop().unwrap();
            self.scroll = prev_scroll;
        }
    }

    pub fn toggle_select(&mut self) {
        let entries = self.visible_entries();
        if self.scroll >= entries.len() {
            return;
        }
        let entry = &entries[self.scroll];
        let name = entry.node.name.clone();
        if let Some(pos) = self.selected.iter().position(|n| *n == name) {
            self.selected.remove(pos);
        } else {
            self.selected.push(name);
        }
    }

    fn selected_commands(&self) -> Vec<Rc<ListNode>> {
        let tree = match self.current_tree() {
            Some(t) => t,
            None => return vec![],
        };
        self.selected
            .iter()
            .filter_map(|name| {
                tree.nodes().find(|n| {
                    n.value().name == *name && !matches!(n.value().command, Command::None)
                })
            })
            .map(|n| n.value().clone())
            .collect()
    }

    pub fn show_description(&mut self) {
        let entries = self.visible_entries();
        if self.scroll >= entries.len() {
            return;
        }
        let entry = &entries[self.scroll];
        let desc = entry.node.description.clone();
        if !desc.is_empty() {
            self.description_content = Some(format!("{}\n\n{}", entry.node.name, desc));
            self.focus = Focus::Float;
        }
    }

    pub fn execute(&mut self) {
        let entries = self.visible_entries();
        if self.scroll >= entries.len() {
            return;
        }
        let entry = &entries[self.scroll];
        if matches!(entry.node.command, Command::None) {
            self.enter_directory();
            return;
        }
        if !self.multi_select_mode && self.selected.is_empty() {
            self.confirm_message = Some(format!("Install '{}'?", entry.node.name));
        } else if !self.selected.is_empty() {
            let names = self.selected.join(", ");
            self.confirm_message = Some(format!("Install: {}?", names));
        } else {
            self.confirm_message = Some(format!("Install '{}'?", entry.node.name));
        }
        self.focus = Focus::Confirm;
    }

    pub fn next_tab(&mut self) {
        if self.current_tab + 1 < self.catalog.tabs.len() {
            self.current_tab += 1;
        } else {
            self.current_tab = 0;
        }
        self.visit_stack.clear();
        self.scroll = 0;
    }

    pub fn prev_tab(&mut self) {
        if self.current_tab > 0 {
            self.current_tab -= 1;
        } else {
            self.current_tab = self.catalog.tabs.len() - 1;
        }
        self.visit_stack.clear();
        self.scroll = 0;
    }

    pub fn go_back_or_focus_tabs(&mut self) {
        if self.at_root() {
            self.focus = Focus::TabList;
        } else {
            self.go_back();
        }
    }

    pub fn confirm_yes(&mut self) {
        let cmds = if !self.selected.is_empty() {
            self.selected_commands()
        } else {
            let entries = self.visible_entries();
            if self.scroll < entries.len() {
                vec![entries[self.scroll].node.clone()]
            } else {
                vec![]
            }
        };

        let mut script = String::new();
        for cmd in &cmds {
            match &cmd.command {
                Command::Raw(raw) => {
                    script.push_str(raw);
                    script.push('\n');
                }
                Command::LocalFile {
                    executable,
                    args,
                    file,
                } => {
                    let args_str = args.join(" ");
                    script.push_str(&format!("{} {} '{}'\n", executable, args_str, file));
                }
                Command::None => {}
            }
        }

        if !script.is_empty() {
            self.pending_script = Some(script);
        } else {
            self.focus = Focus::List;
        }
    }

    pub fn confirm_no(&mut self) {
        self.confirm_message = None;
        self.focus = Focus::List;
    }

    pub fn draw(&mut self, frame: &mut Frame) {
        let area = frame.area();
        let layout = Layout::default()
            .direction(Direction::Vertical)
            .constraints([Constraint::Min(1), Constraint::Length(3)])
            .split(area);

        let main_layout = Layout::default()
            .direction(Direction::Horizontal)
            .constraints([Constraint::Percentage(30), Constraint::Percentage(70)])
            .split(layout[0]);

        let left_layout = Layout::default()
            .direction(Direction::Vertical)
            .constraints([Constraint::Length(Banner::height()), Constraint::Min(1)])
            .split(main_layout[0]);

        Banner::draw(frame, left_layout[0], &self.theme);
        self.draw_tab_list(frame, left_layout[1]);
        self.draw_right_panel(frame, main_layout[1]);
        self.draw_hints(frame, layout[1]);

        if self.focus == Focus::Confirm {
            if let Some(msg) = &self.confirm_message {
                let text = Text::from(format!(
                    "{}\n\nPress 'y' to confirm, 'n' to cancel.",
                    msg
                ));
                let float = Float::new("Confirm", text)
                    .border_style(Style::default().fg(self.theme.float_border_fg()))
                    .title_style(Style::default().fg(self.theme.float_title_fg()).bold());
                frame.render_widget(float, area);
            }
        }

        if self.focus == Focus::Float {
            if let Some(desc) = &self.description_content {
                let text = Text::from(desc.as_str());
                let float = Float::new("Description", text)
                    .border_style(Style::default().fg(self.theme.float_border_fg()))
                    .title_style(Style::default().fg(self.theme.float_title_fg()).bold());
                frame.render_widget(float, area);
            } else if let Some((title, text)) = &self.running_output {
                let float = Float::new(title, text.clone())
                    .footer("  Esc dismiss", Style::default().fg(Color::DarkGray))
                    .border_style(Style::default().fg(self.theme.float_border_fg()))
                    .title_style(Style::default().fg(self.theme.float_title_fg()).bold());
                frame.render_widget(float, area);
            }
        }
    }

    fn draw_tab_list(&self, frame: &mut Frame, area: Rect) {
        let border_color = if self.focus == Focus::TabList {
            self.theme.border_focus_fg()
        } else {
            self.theme.border_fg()
        };
        let block = Block::default()
            .borders(Borders::ALL)
            .border_style(Style::default().fg(border_color))
            .title(Span::styled(" Tabs ", Style::default().fg(self.theme.title_fg())));
        let inner = block.inner(area);
        block.render(area, frame.buffer_mut());

        let items: Vec<ListItem> = self
            .catalog
            .tabs
            .iter()
            .enumerate()
            .map(|(i, tab)| {
                let is_current = i == self.current_tab;
                let fg = if is_current {
                    self.theme.tab_active_fg()
                } else {
                    self.theme.tab_inactive_fg()
                };
                let bg = if is_current {
                    self.theme.tab_active_bg()
                } else {
                    Color::Reset
                };
                let indicator = if is_current { " ▸ " } else { "   " };
                ListItem::new(Line::from(Span::styled(
                    format!("{}{}", indicator, tab.name),
                    Style::default().fg(fg).bg(bg),
                )))
            })
            .collect();

        frame.render_widget(List::new(items).block(Block::default()), inner);
    }

    fn draw_right_panel(&self, frame: &mut Frame, area: Rect) {
        let layout = Layout::default()
            .direction(Direction::Vertical)
            .constraints([Constraint::Length(3), Constraint::Min(1)])
            .split(area);

        let search_focused = self.focus == Focus::Search;
        frame.render_widget(
            FilterWidget::new(&self.filter, &self.theme, search_focused),
            layout[0],
        );

        if self.catalog.tabs.is_empty() {
            let block = Block::default()
                .borders(Borders::ALL)
                .border_style(Style::default().fg(self.theme.border_fg()));
            let text = Paragraph::new("No tabs available")
                .style(Style::default().fg(self.theme.hint_fg()));
            frame.render_widget(text.block(block), layout[1]);
            return;
        }

        let tab_name = &self.catalog.tabs[self.current_tab].name;
        let border_color = if self.focus == Focus::List || self.focus == Focus::Search {
            self.theme.border_focus_fg()
        } else {
            self.theme.border_fg()
        };
        let block = Block::default()
            .borders(Borders::ALL)
            .border_style(Style::default().fg(border_color))
            .title(Span::styled(
                if self.show_installed_only {
                    format!(" {} [installed] ", tab_name)
                } else {
                    format!(" {} ", tab_name)
                },
                Style::default().fg(self.theme.title_fg()),
            ));
        let inner = block.inner(layout[1]);
        block.render(layout[1], frame.buffer_mut());

        let entries = self.visible_entries();
        let items: Vec<ListItem> = entries
            .iter()
            .enumerate()
            .map(|(i, entry)| {
                let indent = "  ".repeat(entry.depth);
                let prefix = if entry.has_children { ">" } else { " " };
                let checked = self.selected.contains(&entry.node.name);
                let icon = if checked {
                    " [x]"
                } else if entry.has_children {
                    " [+]"
                } else {
                    "    "
                };

                let status = if entry.has_children {
                    ""
                } else if is_command_installed(&entry.node.command) {
                    " ✓"
                } else {
                    " ✗"
                };
                let status_color = if entry.has_children || is_command_installed(&entry.node.command) {
                    self.theme.tab_active_bg()
                } else {
                    Color::Rgb(150, 50, 50)
                };

                let is_focused = self.focus == Focus::List && i == self.scroll;
                let fg = if is_focused {
                    self.theme.selected_fg()
                } else if entry.has_children {
                    self.theme.directory_fg()
                } else {
                    self.theme.command_fg()
                };
                let bg = if is_focused {
                    self.theme.selected_bg()
                } else {
                    Color::Reset
                };

                ListItem::new(Line::from(vec![
                    Span::styled(
                        format!("{}{}{} {}", indent, prefix, icon, entry.node.name),
                        Style::default().fg(fg).bg(bg),
                    ),
                    Span::styled(status, Style::default().fg(status_color)),
                ]))
            })
            .collect();

        let mut list_state = ListState::default();
        list_state.select(Some(self.scroll));
        frame.render_stateful_widget(
            List::new(items)
                .highlight_style(
                    Style::default()
                        .bg(self.theme.selected_bg())
                        .fg(self.theme.selected_fg()),
                )
                .block(Block::default()),
            inner,
            &mut list_state,
        );
    }

    fn draw_hints(&self, frame: &mut Frame, area: Rect) {
        let focus_name = match self.focus {
            Focus::TabList => "TabList",
            Focus::List => "List",
            Focus::Search => "Search",
            Focus::Confirm => "Confirm",
            Focus::Float => "Float",
        };

        let has_multi = self.multi_select_mode || !self.selected.is_empty();
        let shortcuts = create_shortcut_list(focus_name, has_multi);
        let spans = render_shortcuts(&shortcuts, &self.theme);

        let block = Block::default()
            .borders(Borders::ALL)
            .border_style(Style::default().fg(self.theme.border_fg()));
        Paragraph::new(Text::from(Line::from(spans)))
            .block(block)
            .render(area, frame.buffer_mut());
    }
}

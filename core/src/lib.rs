pub mod inner;
pub mod config;
pub mod plugins;

use std::rc::Rc;
use ego_tree::Tree;

#[derive(Debug, Clone)]
pub enum Command {
    Raw(String),
    LocalFile {
        executable: String,
        args: Vec<String>,
        file: String,
    },
    None,
}

#[derive(Debug, Clone)]
pub struct ListNode {
    pub name: String,
    pub description: String,
    pub command: Command,
    pub task_list: String,
    pub multi_select: bool,
}

#[derive(Debug, Clone)]
pub struct Tab {
    pub name: String,
    pub tree: Tree<Rc<ListNode>>,
}

#[derive(Debug, Clone)]
pub struct Catalog {
    pub tabs: Vec<Tab>,
    pub _temp_dir: std::rc::Rc<temp_dir::TempDir>,
}

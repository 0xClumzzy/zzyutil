use std::path::Path;
use std::rc::Rc;
use std::fs;

use ego_tree::Tree;
use include_dir::{include_dir, Dir};
use serde::Deserialize;
use temp_dir::TempDir;

use crate::{Catalog, Command, ListNode, Tab};

static TABS_DIR: Dir = include_dir!("$CARGO_MANIFEST_DIR/tabs");

#[derive(Deserialize)]
struct TabsConfig {
    directories: Vec<String>,
}

#[derive(Deserialize)]
struct TabDataFile {
    name: String,
    data: Vec<DataEntry>,
}

#[derive(Deserialize, Clone)]
struct DataEntry {
    name: String,
    description: Option<String>,
    script: Option<String>,
    command: Option<String>,
    task_list: Option<String>,
    multi_select: Option<bool>,
    entries: Option<Vec<DataEntry>>,
    preconditions: Option<Vec<Precondition>>,
}

#[derive(Deserialize, Clone)]
struct Precondition {
    matches: bool,
    data: String,
    values: Vec<String>,
}

fn evaluate_precondition(pc: &Precondition) -> bool {
    match pc.data.as_str() {
        "command_exists" => pc.values.iter().any(|v| which::which(v).is_ok()),
        "file_exists" => pc.values.iter().any(|v| Path::new(v).exists()),
        "environment" => pc.values.iter().any(|v| {
            let parts: Vec<&str> = v.splitn(2, '=').collect();
            if parts.len() == 2 {
                std::env::var(parts[0]).ok().as_deref() == Some(parts[1])
            } else {
                std::env::var(v).is_ok()
            }
        }),
        "containing_file" => {
            if pc.values.len() < 2 {
                return false;
            }
            let path = &pc.values[0];
            let patterns = &pc.values[1..];
            if let Ok(content) = fs::read_to_string(path) {
                patterns.iter().all(|p| content.contains(p))
            } else {
                false
            }
        }
        _ => false,
    }
}

fn entry_passes_preconditions(entry: &DataEntry) -> bool {
    if let Some(preconditions) = &entry.preconditions {
        for pc in preconditions {
            let result = evaluate_precondition(pc);
            if result != pc.matches {
                return false;
            }
        }
    }
    true
}

fn get_shebang(path: &Path) -> (String, Vec<String>) {
    if let Ok(content) = fs::read_to_string(path) {
        if let Some(line) = content.lines().next() {
            if let Some(rest) = line.strip_prefix("#!") {
                let parts: Vec<&str> = rest.trim().split_whitespace().collect();
                if let Some(exe) = parts.first() {
                    let args: Vec<String> = parts[1..].iter().map(|s| s.to_string()).collect();
                    return (exe.to_string(), args);
                }
            }
        }
    }
    ("/bin/sh".to_string(), vec!["-e".to_string()])
}

fn add_entries_to_tree(
    tree: &mut Tree<Rc<ListNode>>,
    parent: ego_tree::NodeId,
    entries: &[DataEntry],
    tab_dir: &Path,
    validate: bool,
) {
    for entry in entries {
        if !entry_passes_preconditions(entry) {
            continue;
        }

        let node = Rc::new(ListNode {
            name: entry.name.clone(),
            description: entry.description.clone().unwrap_or_default(),
            command: resolve_command(entry, tab_dir, validate),
            task_list: entry.task_list.clone().unwrap_or_default(),
            multi_select: entry.multi_select.unwrap_or(false),
        });

        if let Some(child_id) = tree.get_mut(parent).map(|mut n| n.append(node).id()) {
            if let Some(child_entries) = &entry.entries {
                add_entries_to_tree(tree, child_id, child_entries, tab_dir, validate);
            }
        }
    }
}

fn build_tree(entries: &[DataEntry], tab_dir: &Path, validate: bool) -> Tree<Rc<ListNode>> {
    let root = Rc::new(ListNode {
        name: "root".to_string(),
        description: String::new(),
        command: Command::None,
        task_list: String::new(),
        multi_select: false,
    });
    let mut tree = Tree::new(root);
    let root_id = tree.root().id();
    add_entries_to_tree(&mut tree, root_id, entries, tab_dir, validate);
    tree
}

fn resolve_command(entry: &DataEntry, tab_dir: &Path, validate: bool) -> Command {
    if let Some(cmd) = &entry.command {
        return Command::Raw(cmd.clone());
    }

    if let Some(script) = &entry.script {
        let script_path = tab_dir.join(script);
        let (exe, args) = get_shebang(&script_path);

        if validate && which::which(&exe).is_err() {
            return Command::None;
        }

        return Command::LocalFile {
            executable: exe,
            args,
            file: script_path.to_string_lossy().to_string(),
        };
    }

    Command::None
}

pub fn get_catalog(validate: bool) -> Catalog {
    match try_get_catalog(validate) {
        Ok(catalog) => catalog,
        Err(e) => {
            eprintln!("Warning: Failed to load catalog: {}", e);
            eprintln!("Using empty catalog.");
            let temp_dir = Rc::new(TempDir::new().expect("failed to create temp dir"));
            Catalog {
                tabs: Vec::new(),
                _temp_dir: temp_dir,
            }
        }
    }
}

fn try_get_catalog(validate: bool) -> Result<Catalog, String> {
    let temp_dir = Rc::new(
        TempDir::new().map_err(|e| format!("Failed to create temp directory: {}", e))?,
    );
    let tabs_root = temp_dir.path().join("tabs");
    extract_dir(&TABS_DIR, &tabs_root)?;

    let tabs_config_path = tabs_root.join("tabs.toml");
    let config_content = fs::read_to_string(&tabs_config_path)
        .map_err(|e| format!("Failed to read tabs.toml: {}", e))?;
    let tabs_config: TabsConfig = toml::from_str(&config_content)
        .map_err(|e| format!("Failed to parse tabs.toml: {}", e))?;

    let mut tabs = Vec::new();

    for dir_name in &tabs_config.directories {
        let tab_dir = tabs_root.join(dir_name);
        let tab_data_path = tab_dir.join("tab_data.toml");

        if !tab_data_path.exists() {
            continue;
        }

        let content = match fs::read_to_string(&tab_data_path) {
            Ok(c) => c,
            Err(e) => {
                eprintln!("Warning: Failed to read {}/tab_data.toml: {}", dir_name, e);
                continue;
            }
        };

        let tab_data: TabDataFile = match toml::from_str(&content) {
            Ok(t) => t,
            Err(e) => {
                eprintln!("Warning: Failed to parse {}/tab_data.toml: {}", dir_name, e);
                continue;
            }
        };

        let tree = build_tree(&tab_data.data, &tab_dir, validate);

        tabs.push(Tab {
            name: tab_data.name,
            tree,
        });
    }

    Ok(Catalog {
        tabs,
        _temp_dir: temp_dir,
    })
}

fn extract_dir(dir: &Dir, dest: &Path) -> Result<(), String> {
    fs::create_dir_all(dest)
        .map_err(|e| format!("Failed to create directory {}: {}", dest.display(), e))?;

    let prefix = dir.path();

    for entry in dir.files() {
        let relative = entry.path();
        let relative = relative.strip_prefix(prefix).unwrap_or(relative);
        let dest_path = dest.join(relative);
        if let Some(parent) = dest_path.parent() {
            fs::create_dir_all(parent)
                .map_err(|e| format!("Failed to create parent directory: {}", e))?;
        }
        let contents = entry.contents();
        fs::write(&dest_path, contents)
            .map_err(|e| format!("Failed to write file {}: {}", dest_path.display(), e))?;
    }

    for subdir in dir.dirs() {
        let relative = subdir.path();
        let relative = relative.strip_prefix(prefix).unwrap_or(relative);
        let dest_path = dest.join(relative);
        fs::create_dir_all(&dest_path)
            .map_err(|e| format!("Failed to create subdirectory: {}", e))?;
        extract_dir(subdir, &dest_path)?;
    }

    Ok(())
}

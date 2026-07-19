use std::collections::HashMap;
use std::fs;
use std::path::PathBuf;
use serde::{Deserialize, Serialize};

use crate::Tab;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Plugin {
    pub name: String,
    pub version: Option<String>,
    pub description: Option<String>,
    pub author: Option<String>,
    pub tabs: Vec<PluginTab>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PluginTab {
    pub name: String,
    pub categories: Vec<PluginCategory>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PluginCategory {
    pub name: String,
    pub description: Option<String>,
    pub tools: Vec<PluginTool>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PluginTool {
    pub name: String,
    pub description: Option<String>,
    pub command: Option<String>,
    pub script: Option<String>,
    pub task_list: Option<String>,
    pub multi_select: Option<bool>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PluginsConfig {
    pub plugins: HashMap<String, PluginEntry>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct PluginEntry {
    pub path: String,
    pub enabled: bool,
}

impl Default for PluginsConfig {
    fn default() -> Self {
        Self {
            plugins: HashMap::new(),
        }
    }
}

impl PluginsConfig {
    pub fn plugins_dir() -> PathBuf {
        let home = std::env::var("HOME").unwrap_or_else(|_| ".".to_string());
        PathBuf::from(home).join(".config").join("zzyutil").join("plugins")
    }

    fn config_path() -> PathBuf {
        Self::plugins_dir().join("plugins.toml")
    }

    pub fn load() -> Self {
        let path = Self::config_path();
        if !path.exists() {
            return Self::default();
        }
        let content = match fs::read_to_string(&path) {
            Ok(c) => c,
            Err(_) => return Self::default(),
        };
        toml::from_str(&content).unwrap_or_default()
    }

    pub fn save(&self) -> Result<(), String> {
        let dir = Self::plugins_dir();
        fs::create_dir_all(&dir)
            .map_err(|e| format!("Failed to create plugins directory: {}", e))?;
        let content = toml::to_string_pretty(self)
            .map_err(|e| format!("Failed to serialize plugins config: {}", e))?;
        fs::write(Self::config_path(), content)
            .map_err(|e| format!("Failed to write plugins config: {}", e))?;
        Ok(())
    }

    pub fn register_plugin(&mut self, name: String, path: String) -> Result<(), String> {
        self.plugins.insert(name, PluginEntry {
            path,
            enabled: true,
        });
        self.save()
    }

    pub fn unregister_plugin(&mut self, name: &str) -> Result<(), String> {
        self.plugins.remove(name);
        self.save()
    }

    pub fn enable_plugin(&mut self, name: &str) -> Result<(), String> {
        if let Some(entry) = self.plugins.get_mut(name) {
            entry.enabled = true;
            self.save()
        } else {
            Err(format!("Plugin '{}' not found", name))
        }
    }

    pub fn disable_plugin(&mut self, name: &str) -> Result<(), String> {
        if let Some(entry) = self.plugins.get_mut(name) {
            entry.enabled = false;
            self.save()
        } else {
            Err(format!("Plugin '{}' not found", name))
        }
    }

    pub fn list_plugins(&self) -> Vec<(&str, &PluginEntry)> {
        self.plugins.iter().map(|(k, v)| (k.as_str(), v)).collect()
    }

    pub fn load_plugin(&self, name: &str) -> Result<Plugin, String> {
        let entry = self.plugins.get(name)
            .ok_or_else(|| format!("Plugin '{}' not found", name))?;
        
        if !entry.enabled {
            return Err(format!("Plugin '{}' is disabled", name));
        }

        let path = PathBuf::from(&entry.path);
        if !path.exists() {
            return Err(format!("Plugin path '{}' does not exist", entry.path));
        }

        let content = fs::read_to_string(&path)
            .map_err(|e| format!("Failed to read plugin file: {}", e))?;
        
        let plugin: Plugin = toml::from_str(&content)
            .map_err(|e| format!("Failed to parse plugin file: {}", e))?;
        
        Ok(plugin)
    }

    pub fn load_all_plugins(&self) -> Vec<Plugin> {
        self.plugins.keys()
            .filter_map(|name| self.load_plugin(name).ok())
            .collect()
    }
}

pub fn merge_plugin_tabs(base_tabs: &mut Vec<Tab>, plugins: &[Plugin]) {
    for plugin in plugins {
        for plugin_tab in &plugin.tabs {
            let tree = crate::inner::build_plugin_tree(plugin_tab);
            base_tabs.push(Tab {
                name: format!("{} ({})", plugin_tab.name, plugin.name),
                tree,
            });
        }
    }
}

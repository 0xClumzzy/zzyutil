use std::collections::HashSet;
use std::fs;
use serde::Deserialize;

#[derive(Deserialize, Default)]
pub struct Config {
    pub auto_execute: Option<Vec<String>>,
    pub skip_confirmation: Option<bool>,
    pub size_bypass: Option<bool>,
}

impl Config {
    pub fn from_file(path: &str) -> Self {
        let content = match fs::read_to_string(path) {
            Ok(c) => c,
            Err(_) => return Self::default(),
        };
        toml::from_str(&content).unwrap_or_default()
    }

    pub fn auto_execute_set(&self) -> HashSet<String> {
        self.auto_execute
            .as_ref()
            .map(|v| v.iter().cloned().collect())
            .unwrap_or_default()
    }
}

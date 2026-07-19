use clap::Parser;

#[derive(Parser, Debug)]
#[command(name = "zzyutil", about = "Cybersecurity Toolbox", version)]
pub struct Args {
    #[arg(long)]
    pub config: Option<String>,

    #[arg(long, default_value = "dark", help = "Theme: dark, compatible, cyber")]
    pub theme: String,

    #[arg(long)]
    pub skip_confirmation: bool,

    #[arg(long)]
    pub override_validation: bool,

    #[arg(long)]
    pub size_bypass: bool,

    #[arg(long)]
    pub mouse: bool,
}

# Dotfiles Setup

These dotfiles target macOS. The installer bootstraps developer tooling, configures Git, generates SSH keys if needed, installs Homebrew packages and casks, applies macOS defaults, and stows the configs provided in this repo.

## Quick Start

1. Review `install.sh` to understand the changes it will make.
2. Run the installer with:

   ```bash
   sudo /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/dzej1/dotfiles/main/install.sh)"
   ```

The script prompts for your Git email, may request admin privileges for macOS defaults, and installs a variety of packages. When it finishes, the `stow` step links the `karabiner`, `neovim`, `kitty`, `zsh`, and `ssh` configs into your home directory.


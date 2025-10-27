# Dotfiles Setup

These dotfiles target macOS. The installer bootstraps developer tooling, configures Git, generates SSH keys if needed, installs Homebrew packages and casks, applies macOS defaults, and stows the configs provided in this repo.

## Quick Start

1. Review `install.sh`, the `Makefile`, and the bundle manifests in `install/` to understand the changes they will make.
2. Install Homebrew (if not already):

   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

3. Run the installer with:

   ```bash
   sudo /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/dzej1/dotfiles/main/install.sh)"
   ```

The script prompts for your Git email, may request admin privileges for macOS defaults, and installs a variety of packages. When it finishes, the `stow` step links the `karabiner`, `neovim`, `kitty`, `zsh`, and `ssh` configs into your home directory.

## Makefile Usage

The Homebrew taps, formulae, and casks are tracked with `brew bundle` manifests under `install/Brewfile` and `install/Caskfile`. To apply them (or re-run later after updating the lists), clone the repo and run:

```bash
git clone https://github.com/dzej1/dotfiles.git ~/dotfiles
cd ~/dotfiles
make brew
```

`install.sh` will automatically invoke `make brew` when the `Makefile` is available, so running the script remains the quickest way to bootstrap a new machine. Re-running `make brew` later will bring Homebrew packages back in sync with the tracked manifests.

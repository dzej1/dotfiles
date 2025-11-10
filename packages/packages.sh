#!/usr/bin/env bash
# sudo -v

# Define variables for each package manager and include the corresponding package lists
. ../scripts/functions.sh

brew_packages="Brewfile"
cask_packages="Caskfile"
node_packages="node_packages.txt"
# global_packages="bun_packages.txt" #pnpm_packages.txt is another option
# python_packages="pipx_packages.txt"
ruby_packages="ruby_packages.txt"
# rust_packages="rust_packages.txt"

# Define a function for installing packages with Homebrew
install_brew_packages() {
  if ! command -v $(which brew) &>/dev/null; then
    substep_info "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if ! command -v $(which brew) &>/dev/null; then
      error "Failed to install Homebrew. Exiting."
      exit 1
    fi
    substep_success "Homebrew installed."
  fi
  info "Installing Homebrew packages..."
  brew update
  brew upgrade
  brew bundle --file=$brew_packages
  brew bundle --file=$cask_packages
  success "Finished installing Homebrew packages."
}

install_node_packages() {
  # Install FNM
  if ! command -v fnm &>/dev/null; then
    substep_info "Installing FNM..."
    curl -fsSL https://fnm.vercel.app/install | bash
    eval "$(fnm env --use-on-cd)" # needed to install npm packages - already set for Fish
    substep_success "FNM installed."
  fi

  if ! fnm use --lts &>/dev/null; then
    info "Installing latest LTS version of Node..."
    fnm install --lts
    fnm alias lts-latest default
    fnm use default
    substep_success "Node LTS installed and set as default for FNM."
  fi

  # Install NPM packages
  info "Installing NPM packages..."
  npm install -g $(cat $node_packages)
  corepack enable
  success "All NPM global packages installed."
}
# Install global packages with Bun
# install_bun_packages() {
#   bun install -g $(cat $global_packages)
# }

# Define a function for installing packages with Python
# install_python_packages() {
#   if ! command -v $(which python) &>/dev/null; then
#     substep_info "Python not found. Installing..."
#     brew install python
#     if ! command -v $(which python) &>/dev/null; then
#       error "Failed to install Python. Exiting."
#       exit 1
#     fi
#     substep_success "Python installed."
#   fi
#   info "Installing Python packages..."
#   pip install $(cat "$python_packages")
#   success "Finished installing Python packages."
# }

install_ruby_packages() {
  # Install rbenv
  if [[ ! -x "$(which ruby)" ]] || [[ "$(which ruby)" == "/usr/bin/ruby" ]]; then
    substep_info "Installing rbenv..."
    brew install chruby ruby-install
    ruby-install ruby
    eval "$(rbenv init - zsh)"
    substep_success "ruby installed."
  fi

  # Install gems
  info "Installing Ruby gems..."
  gem install $(cat ruby_packages.txt)
  success "Ruby gems installed."
}

# Define a function for installing packages with Rust
# install_rust_packages() {
#   if ! command -v $(which rustc) &>/dev/null; then
#     substep_info "Rust not found. Installing..."
#     brew install rust rustup-init
#     rustup-init
#     if ! command -v $(which rustc) &>/dev/null; then
#       error "Failed to install Rust. Exiting."
#       exit 1
#     fi
#     substep_success "Rust installed."
#   fi
#   info "Installing Rust packages..."
#   rustup update
#   cargo install $(cat "$rust_packages")
#   success "Finished installing Rust packages."
# }

# Call each installation function
install_brew_packages
install_node_packages
install_ruby_packages

# install_python_packages
# install_rust_packages
# install_bun_packages

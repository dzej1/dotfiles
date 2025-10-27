#!/bin/bash

GIT_USERNAME="dmn"
EMAIL_FILE="$HOME/.git_user_email"
SSH_KEY_FILE="$HOME/.ssh/id_rsa"
SSH_KEY_NAME=$(basename "$SSH_KEY_FILE")

echo
echo "Configuring Git identity..."

if [[ -f "$EMAIL_FILE" ]]; then
  stored_email=$(cat "$EMAIL_FILE")
  read -p "Use stored Git email ($stored_email)? Enter 'yes' to use it, or 'no' to enter a new one: " use_stored
else
  use_stored="no"
fi

if [[ "$use_stored" == "yes" ]]; then
  GIT_USEREMAIL="$stored_email"
else
  while true; do
    echo -n "Enter your Git email: "
    stty -echo
    read GIT_USEREMAIL
    stty echo
    echo
    echo -n "Re-enter your Git email for confirmation: "
    stty -echo
    read GIT_USEREMAIL_CONFIRM
    stty echo
    echo
    if [[ -n "$GIT_USEREMAIL" && "$GIT_USEREMAIL" == "$GIT_USEREMAIL_CONFIRM" ]]; then
      echo "Emails match."
      echo "$GIT_USEREMAIL" >"$EMAIL_FILE"
      break
    else
      echo "Emails do not match or are empty. Please try again."
    fi
  done
fi

echo "Setting git user.name to $GIT_USERNAME and user.email"
git config --global user.name "$GIT_USERNAME"
git config --global user.email "$GIT_USEREMAIL"

echo
echo "Configuring SSH key..."

if [ ! -d "$HOME/.ssh" ]; then
  mkdir -p "$HOME/.ssh"
  chmod 700 "$HOME/.ssh"
fi

if [ ! -f "$SSH_KEY_FILE" ]; then
  {
    echo "# Paste your '$SSH_KEY_NAME' PRIVATE key below and save"
    echo "# Also, delete these 3 comments on the top or the key will be invalid"
    echo "# Once done modifying this file, save with :wq"
  } >"$SSH_KEY_FILE"
  vim "$SSH_KEY_FILE"
  chmod 600 "$SSH_KEY_FILE"
fi

if ! xcode-select -p &>/dev/null; then
  # In the [brew documentation](https://docs.brew.sh/Installation)
  # you can see the macOS Requirements
  echo
  echo ">>>>>>>>>>>>>>>>>>>>>>>>>>"
  echo "Installing xcode-select, this will take some time, please wait"
  echo "A popup will show up, make sure you accept it"
  xcode-select --install

  # Wait for xcode-select to be installed
  echo
  echo ">>>>>>>>>>>>>>>>>>>>>>>>>>"
  echo "Waiting for xcode-select installation to complete..."
  while ! xcode-select -p &>/dev/null; do
    sleep 20
  done
  echo
  echo "xcode-select Installed! Proceeding with Homebrew installation."
else
  echo
  echo "xcode-select is already installed! Proceeding with Homebrew installation."
fi

# Source this in case brew was installed but script needs to re-run
if [ -f ~/.zprofile ]; then
  source ~/.zprofile
fi

# Then go to the main page `https://brew.sh` to find the installation command
if ! command -v brew &>/dev/null; then
  echo
  echo ">>>>>>>>>>>>>>>>>>>>>>>>>>"
  echo "Installing brew"
  echo "Enter your password below (if required)"
  # Only install brew if not installed yet
  echo
  echo ">>>>>>>>>>>>>>>>>>>>>>>>>>"
  # Install Homebrew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo
  echo "Homebrew installed successfully."
else
  echo
  echo "Homebrew is already installed."
fi

# Wait until Homebrew is available before running brew commands
echo "Checking Homebrew availability..."
for attempt in {1..12}; do
  if command -v brew >/dev/null 2>&1; then
    echo "Homebrew detected."
    break
  fi
  echo "Homebrew not ready yet, retrying in 5 seconds... (attempt $attempt)"
  sleep 10
done

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not detected after waiting; exiting."
  exit 1
fi

# After brew is installed, notice that you need to configure your shell for
# homebrew, you can see this in your terminal output in the **Next steps** section
echo
echo ">>>>>>>>>>>>>>>>>>>>>>>>>>"
echo "Modifying .zprofile file"
CHECK_LINE='eval "$(/opt/homebrew/bin/brew shellenv)"'

# File to be checked and modified
FILE="$HOME/.zprofile"

# Check if the specific line exists in the file
if grep -Fq "$CHECK_LINE" "$FILE"; then
  echo "Content already exists in $FILE"
else
  # Append the content if it does not exist
  echo -e '\n# Configure shell for brew\n'"$CHECK_LINE" >>"$FILE"
  echo "Content added to $FILE"
fi

# After adding it to the .zprofile file, make sure to run the command
source $FILE

# Install xCode cli tools
# if [[ "$(uname)" == "Darwin" ]]; then
#   echo "macOS deteted..."
#
#   if xcode-select -p &>/dev/null; then
#     echo "Xcode already installed"
#   else
#     echo "Installing commandline tools..."
#     xcode-select --install
#   fi
# fi

# Homebrew
## Install
# echo "Installing Brew..."
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# brew analytics off

## Taps
echo "Tapping Brew..."
brew tap homebrew/cask-fonts
brew tap FelixKratz/formulae

brew tap homebrew/bundle
brew tap homebrew/services
brew tap jesseduffield/lazygit

## Formulae
echo "Installing Brew Formulae..."

## Core Utils
echo "Install gnu coreutils"
brew install coreutils

### Must Have things
brew install eza
brew install zsh-autosuggestions
brew install zsh-syntax-highlighting
brew install stow
brew install fzf
brew install git
brew install bat
brew install fd
brew install zoxide
brew install lua
brew install luajit
brew install luarocks
brew install prettier
brew install make
brew install qmk
brew install ripgrep

### Terminal
brew install git
brew install lazygit
brew install neovim
brew install tree-sitter
brew install tree
brew install borders

### dev things
brew install node
brew install nvm
# brew install sqlite

brew install bitwarden
## Casks
brew install --cask raycast
brew install --cask appcleaner
brew install --cask karabiner-elements
brew install --cask kitty
brew install --cask codex
brew install --cask orbstack
brew install --cask flux-app
brew install --cask betterdisplay
brew install --cask font-hack-nerd-font
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask font-sf-pro
brew install --cask zen-browser
# brew install --cask helium-browser
brew install --cask spotify
brew install --cask datagrip
brew install --cask vlc
# brew install --cask nikitabobko/tap/aerospace
# brew install --cask keycastr
# brew install --cask setapp

## MacOS settings
echo "Changing macOS defaults..."
defaults write com.apple.Dock autohide -bool TRUE
defaults write InitialKeyRepeat -int 20
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain _HIHideMenuBar -bool TRUE

defaults write com.apple.Dock autohide-delay -float 0.05
defaults write com.apple.dock show-recents -bool FALSE
defaults write com.apple.dock tilesize -int 36
defaults write com.apple.dock largesize -int 96
killall Dock

defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"
defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv"
defaults write com.apple.finder "ShowPathbar" -bool TRUE
defaults write com.apple.finder "ShowStatusBar" -bool TRUE
defaults write com.apple.finder "ShowRecentTags" -bool FALSE

# Disable UI sound effects
defaults write -g com.apple.sound.uiaudio.enabled -int 0
# Disable the startup chime
sudo nvram StartupMute=%01

killall Finder

sudo defaults write /Library/Preferences/com.apple.loginwindow HideUserAvatarAndName -bool TRUE

osascript -e 'tell application "System Events" to tell every desktop to set picture to "/System/Library/Desktop Pictures/Solid Colors/Black.png"'
defaults write com.apple.loginwindow DesktopPicture "/System/Library/Desktop Pictures/Solid Colors/Black.png"

csrutil status
echo "Installation complete..."

# Clone dotfiles repository
if [ ! -d "$HOME/dotfiles" ]; then
  echo "Cloning dotfiles repository..."
  git clone https://github.com/dzej1/dotfiles.git $HOME/dotfiles
fi

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
## install zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
## install zsh-syntax-highlighting
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

# export gnu coreutils to path
echo 'export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"' >>~/.zshrc

# Navigate to dotfiles directory
cd $HOME/dotfiles || exit

# Stow dotfiles packages
echo "Stowing dotfiles..."
stow -t ~ karabiner neovim kitty zsh ssh

echo "Dotfiles setup complete!"
chmod +x /reset-jb.sh

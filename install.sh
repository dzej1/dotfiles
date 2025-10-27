#!/bin/bash

GIT_USERNAME="dmn"
EMAIL_FILE="$HOME/.git_user_email"
SSH_KEY_FILE="$HOME/.ssh/id_rsa"
SSH_KEY_NAME=$(basename "$SSH_KEY_FILE")
DOTFILES_DIR="$HOME/dotfiles"

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

# Ensure Homebrew is available before continuing
if ! command -v brew &>/dev/null; then
  echo "Homebrew not detected. Please install Homebrew before running this script."
  echo 'Installation instructions:'
  echo '  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
  exit 1
fi

# Configure shell for brew
if ! grep -Fq 'eval "$(/opt/homebrew/bin/brew shellenv)"' /Users/dmn/.zprofile; then
  echo >>/Users/dmn/.zprofile
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>/Users/dmn/.zprofile
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

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

## MacOS settings
# echo "Changing macOS defaults..."
# defaults write com.apple.Dock autohide -bool TRUE
# defaults write InitialKeyRepeat -int 20
# defaults write NSGlobalDomain KeyRepeat -int 1
# defaults write NSGlobalDomain _HIHideMenuBar -bool TRUE
#
# defaults write com.apple.Dock autohide-delay -float 0.05
# defaults write com.apple.dock show-recents -bool FALSE
# defaults write com.apple.dock tilesize -int 36
# defaults write com.apple.dock largesize -int 96
#
# defaults delete com.apple.dock persistent-apps
#
# defaults write com.apple.dock persistent-apps -array \
#   '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///Applications/Zen%20Browser.app/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>' \
#   '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///System/Applications/Messages.app/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>' \
#   '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///System/Applications/Mail.app/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>' \
#   '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///System/Applications/Reminders.app/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>' \
#   '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///System/Applications/Notes.app/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>' \
#   '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///System/Applications/Podcasts.app/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>' \
#   '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///Applications/kitty.app/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>' \
#   '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///Users/dmn/Applications/DataGrip.app/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>' \
#   '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///System/Applications/System%20Settings.app/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>'
#
# killall Dock
#
# defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"
# defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv"
# defaults write com.apple.finder "ShowPathbar" -bool TRUE
# defaults write com.apple.finder "ShowStatusBar" -bool TRUE
# defaults write com.apple.finder "ShowRecentTags" -bool FALSE
#
# # Disable UI sound effects
# defaults write -g com.apple.sound.uiaudio.enabled -int 0
# # Disable the startup chime
# sudo nvram StartupMute=%01
#
# killall Finder
#
# sudo defaults write /Library/Preferences/com.apple.loginwindow HideUserAvatarAndName -bool TRUE
#
# if command -v osascript >/dev/null 2>&1; then
#   if ! osascript -e 'tell application "System Events" to tell every desktop to set picture to "/System/Library/Desktop Pictures/Solid Colors/Black.png"'; then
#     echo "Could not update desktop background via System Events. Grant Terminal automation permissions and re-run if needed."
#   fi
# else
#   echo "osascript not found; skipping desktop background update."
# fi
#
# defaults write com.apple.loginwindow DesktopPicture "/System/Library/Desktop Pictures/Solid Colors/Black.png"
#
# csrutil status
# echo "Installation complete..."

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
## install zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
## install zsh-syntax-highlighting
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

# export gnu coreutils to path
echo 'export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"' >>~/.zshrc

# Navigate to dotfiles directory
cd "$DOTFILES_DIR" || exit

# Stow dotfiles packages
echo "Stowing dotfiles..."
stow -t ~ karabiner neovim kitty zsh ssh

echo "Dotfiles setup complete!"
chmod +x /reset-jb.sh

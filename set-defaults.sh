#!/bin/bash

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

defaults delete com.apple.dock persistent-apps

defaults write com.apple.dock persistent-apps -array \
  '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///Applications/Zen%20Browser.app/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>' \
  '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///System/Applications/Messages.app/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>' \
  '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///System/Applications/Mail.app/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>' \
  '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///System/Applications/Reminders.app/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>' \
  '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///System/Applications/Notes.app/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>' \
  '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///System/Applications/Podcasts.app/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>' \
  '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///Applications/kitty.app/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>' \
  '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///Users/dmn/Applications/DataGrip.app/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>' \
  '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///System/Applications/System%20Settings.app/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>'

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

if command -v osascript >/dev/null 2>&1; then
  if ! osascript -e 'tell application "System Events" to tell every desktop to set picture to "/System/Library/Desktop Pictures/Solid Colors/Black.png"'; then
    echo "Could not update desktop background via System Events. Grant Terminal automation permissions and re-run if needed."
  fi
else
  echo "osascript not found; skipping desktop background update."
fi

defaults write com.apple.loginwindow DesktopPicture "/System/Library/Desktop Pictures/Solid Colors/Black.png"

# FIXME: CHECK: this should replace spotlight by raycast, but also change in raycast is needed
# defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>49</integer><integer>1048576</integer></array><key>type</key><string>standard</string></dict></dict>"
# killall SystemUIServer

csrutil status
echo "Installation complete..."

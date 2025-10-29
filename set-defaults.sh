#!/bin/bash

SCREENSHOTS_FOLDER="${HOME}/Screenshots"

# xattr -d com.apple.quarantine '/Applications/Zen.app/'

## MacOS settings
echo "Changing macOS defaults..."
defaults write com.apple.Dock autohide -bool TRUE
defaults write InitialKeyRepeat -int 20
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain _HIHideMenuBar -bool TRUE

defaults write com.apple.Dock autohide-delay -float 0.05
defaults write com.apple.Dock autohide-timing-fuction -float 0.05
defaults write com.apple.dock show-recents -bool FALSE
defaults write com.apple.dock tilesize -int 36
defaults write com.apple.dock largesize -int 96

defaults delete com.apple.dock persistent-apps

defaults write com.apple.dock persistent-apps -array \
  '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///Applications/Zen.app/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>' \
  '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///System/Applications/Messages.app/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>' \
  '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///System/Applications/Mail.app/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>' \
  '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///System/Applications/Reminders.app/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>' \
  '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///System/Applications/Notes.app/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>' \
  '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///System/Applications/Podcasts.app/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>' \
  '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///Applications/kitty.app/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>' \
  '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>file:///Applications/DataGrip.app/</string><key>_CFURLStringType</key><integer>15</integer></dict></dict></dict>'

defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"
defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv"
defaults write com.apple.finder "ShowPathbar" -bool TRUE
defaults write com.apple.finder "ShowStatusBar" -bool TRUE
defaults write com.apple.finder "ShowRecentTags" -bool FALSE

# Finder: disable window animations and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool TRUE

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool TRUE

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool TRUE

# Disable audio feedback when volume is changed
defaults write com.apple.sound.beep.feedback -bool FALSE

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "
sudo nvram StartupMute=%01

sudo defaults write /Library/Preferences/com.apple.loginwindow HideUserAvatarAndName -bool TRUE
defaults write com.apple.menuextra.battery ShowPercent YES

# Save screenshots to the ~/Screenshots folder
mkdir -p "${SCREENSHOTS_FOLDER}"
defaults write com.apple.screencapture location -string "${SCREENSHOTS_FOLDER}"
# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable Resume system-wide
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Disable the crash reporter
defaults write com.apple.CrashReporter DialogType -string "none"

# Disable Notification Center and remove the menu bar icon
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2>/dev/null

# Enable subpixel font rendering on non-Apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 2

osascript -e 'tell application "System Events" to tell every desktop to set picture to "/System/Library/Desktop Pictures/Solid Colors/Black.png"'
defaults write com.apple.loginwindow DesktopPicture "/System/Library/Desktop Pictures/Solid Colors/Black.png"

defaults write com.apple.menuextra.clock ShowSeconds -bool true
defaults write com.apple.Dock autohide-time-modifier -float "0.1"

# FIXME: CHECK: this should replace spotlight by raycast, but also change in raycast is needed
# defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>49</integer><integer>1048576</integer></array><key>type</key><string>standard</string></dict></dict>"
# killall SystemUIServer

csrutil status
###############################################################################
# Kill affected applications                                                  #
###############################################################################

for app in "Address Book" "Calendar" "Contacts" "Dock" "Finder" "Mail" "SystemUIServer" "iCal"; do
  killall "${app}" &>/dev/null
done
echo "Installation complete..."

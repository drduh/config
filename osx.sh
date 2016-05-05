#!/bin/bash

set -euo pipefail

mkdir ~/build ; chmod 750 ~/build
mkdir ~/config ; chmod 700 ~/config
mkdir ~/.gnupg ; chmod 700 ~/.gnupg
mkdir ~/.ssh ; chmod 700 ~/.ssh
mkdir -p ~/.vim/{backups,swaps,undo}

curl -s "https://sks-keyservers.net/sks-keyservers.netCA.pem" -o ~/.gnupg/sks-keyservers.netCA.pem

chflags nohidden ~/Library

defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain AppleICUForce12HourTime -bool false
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain KeyRepeat -int 0
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write com.apple.ActivityMonitor IconType -int 5
defaults write com.apple.ActivityMonitor ShowCategory -int 100
defaults write com.apple.appstore ShowDebugMenu -bool true
defaults write com.apple.CrashReporter DialogType none
defaults write com.apple.dashboard mcx-disabled -bool true
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true
defaults write com.apple.dock tilesize -int 36
defaults write com.apple.dock show-process-indicators -bool true
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.dock dashboard-in-overlay -bool true
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock orientation -string "left"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder DisableAllAnimations -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder QLEnableTextSelection -bool true
defaults write com.apple.finder QuitMenuItem -bool true
defaults write com.apple.menuextra.battery ShowPercent -string "YES"
defaults write com.apple.Safari ShowSidebarInTopSites -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.TextEdit RichText -int 0
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0
defaults write com.apple.screencapture disable-shadow -bool true
defaults write com.apple.screencapture location -string "${HOME}/Desktop"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

defaults write com.apple.spotlight orderedItems -array \
  '{"enabled" = 1;"name" = "APPLICATIONS";}' \
  '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
  '{"enabled" = 1;"name" = "DIRECTORIES";}' \
  '{"enabled" = 1;"name" = "PDF";}' \
  '{"enabled" = 1;"name" = "FONTS";}' \
  '{"enabled" = 0;"name" = "DOCUMENTS";}' \
  '{"enabled" = 0;"name" = "MESSAGES";}' \
  '{"enabled" = 0;"name" = "CONTACT";}' \
  '{"enabled" = 0;"name" = "EVENT_TODO";}' \
  '{"enabled" = 0;"name" = "IMAGES";}' \
  '{"enabled" = 0;"name" = "BOOKMARKS";}' \
  '{"enabled" = 0;"name" = "MUSIC";}' \
  '{"enabled" = 0;"name" = "MOVIES";}' \
  '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
  '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
  '{"enabled" = 0;"name" = "SOURCE";}' \
  '{"enabled" = 0;"name" = "MENU_DEFINITION";}' \
  '{"enabled" = 0;"name" = "MENU_OTHER";}' \
  '{"enabled" = 0;"name" = "MENU_CONVERSION";}' \
  '{"enabled" = 0;"name" = "MENU_EXPRESSION";}' \
  '{"enabled" = 0;"name" = "MENU_WEBSEARCH";}' \
  '{"enabled" = 0;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'

sudo defaults write /Library/Preferences/com.apple.alf allowsignedenabled -bool false
sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1
sudo defaults write /Library/Preferences/com.apple.alf loggingenabled -bool true
sudo defaults write /Library/Preferences/com.apple.alf stealthenabled -bool true
sudo defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool YES
sudo defaults write /Library/Preferences/com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"

sudo mdutil -i on / > /dev/null
sudo mdutil -E / > /dev/null
sudo tmutil disablelocal

sudo nvram SystemAudioVolume=" "
sudo nvram boot-args="-v"

sudo pmset -a sms 0
sudo pmset -a womp 0

killall Dock
killall Finder
killall mds
killall SystemUIServer

#!/bin/bash

set -o errtrace
set -o nounset
set -o pipefail

mkdir ~/build ; chmod 750 ~/build
mkdir ~/config ; chmod 700 ~/config
mkdir ~/.gnupg ; chmod 700 ~/.gnupg
mkdir ~/.ssh ; chmod 700 ~/.ssh
mkdir -p ~/.vim/{backups,swaps,undo}

sudo curl -s "https://sks-keyservers.net/sks-keyservers.netCA.pem" -o /etc/sks-keyservers.netCA.pem

duti -s com.apple.Safari afp
duti -s com.apple.Safari ftp
duti -s com.apple.Safari nfs
duti -s com.apple.Safari smb

touch ~/.hushlogin

chflags nohidden ~/Library

defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
defaults write NSGlobalDomain AppleICUForce12HourTime -bool false
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
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder QLEnableTextSelection -bool true
defaults write com.apple.finder QuitMenuItem -bool true

defaults write com.apple.mail-shared DisableURLLoading -bool true

defaults write com.apple.menuextra.battery ShowPercent -string "YES"

defaults write com.apple.NetworkBrowser DisableAirDrop -bool true

defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptEnabled -bool false
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari ShowSidebarInTopSites -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari WebKitOmitPDFSupport -bool true
defaults write com.apple.Safari WebKitJavaScriptEnabled -bool false

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

sudo defaults write /Library/Preferences/com.apple.Bluetooth ControllerPowerState -int 0

sudo defaults write /Library/Preferences/com.apple.mDNSResponder NoMulticastAdvertisements -bool true

sudo defaults write /Library/Preferences/com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.captive.control Active -bool false

sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"

echo "Boot into Recovery Mode (or disable SIP), unlock the disk and run:"
echo "cd /Volumes/Macintosh HD/System/Library"
echo "chmod -x ./CoreServices/mapspushd"
echo "chmod -x ./Frameworks/Security.framework/Versions/A/Resources/IDSKeychainSyncingProxy.bundle/Contents/MacOS/IDSKeychainSyncingProxy"
echo "Otherwise, these two processes go nuts and crash repeatedly with the following agents/daemons disabled."

launchctl unload -w /System/Library/LaunchAgents/com.apple.accountsd.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.AddressBook.SourceSync.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.AirPlayUIAgent.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.akd.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.askpermissiond.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.AOSPushRelay.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.bird.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.CalendarAgent.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.CallHistoryPluginHelper.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.CallHistorySyncHelper.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.cloudd.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.cloudfamilyrestrictionsd-mac.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.cloudpaird.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.cloudphotosd.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.CommCenter-osx.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.diagnostics_agent.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.findmymacmessenger.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.gamed.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.helpd.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.familycircled.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.familynotificationd.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.icloud.fmfd.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.identityservicesd.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.imagent.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.IMLoggingAgent.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.metadata.SpotlightNetHelper.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.photolibraryd.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.SafariCloudHistoryPushAgent.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.safaridavclient.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.SafariNotificationAgent.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.sharingd.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.soagent.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.suggestd.plist
launchctl unload -w /System/Library/LaunchAgents/com.apple.telephonyutilities.callservicesd.plist

sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.apsd.plist
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.awacsd.plist
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.blued.plist
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.CrashReporterSupportHelper.plist
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.diagnosticd.plist
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.GameController.gamecontrollerd.plist
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.locationd.plist
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.netbiosd.plist
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.SubmitDiagInfo.plist

sudo mdutil -i on / > /dev/null
sudo mdutil -E / > /dev/null
sudo tmutil disablelocal

sudo nvram SystemAudioVolume=" "
sudo nvram boot-args="-v"

sudo pmset -a sms 0
sudo pmset -a womp 0

sudo systemsetup -setusingnetworktime on

sudo spctl --master-enable

sudo hostname -s mac
sudo scutil --set ComputerName mac
sudo scutil --set LocalHostName mac
sudo scutil --set HostName mac
sudo sysctl kern.hostname=mac
echo "kern.hostname=mac" | sudo tee -a /etc/sysctl.conf

sudo killall Dock
sudo killall Finder
sudo killall mds
sudo killall SystemUIServer
sudo killall blued

#!/bin/bash

set -o errtrace
set -o nounset
set -o pipefail

mkdir -p ~/build ; chmod 750 ~/build
mkdir -p ~/config ; chmod 700 ~/config
mkdir -p ~/.gnupg ; chmod 700 ~/.gnupg
mkdir -p ~/.ssh ; chmod 700 ~/.ssh
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
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

defaults write com.apple.ActivityMonitor IconType -int 5
defaults write com.apple.ActivityMonitor ShowCategory -int 100

defaults write com.apple.appstore ShowDebugMenu -bool true

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

echo
echo "Important! Boot into Recovery Mode (to bypass SIP), unlock and mount the"
echo "disk, then open Terminal and run the following commands:"
echo
echo "cd /Volumes/Macintosh\ HD/System/Library"
echo "chmod -x ./CoreServices/mapspushd"
echo "chmod -x ./PrivateFrameworks/PassKitCore.framework/passd"
echo "chmod -x ./Frameworks/Security.framework/Versions/A/Resources/IDSKeychainSyncingProxy.bundle/Contents/MacOS/IDSKeychainSyncingProxy"
echo "reboot"
echo
echo "If not stopped from executing, these processes go nuts and use 100% CPU"
echo "with the following launch agents and daemons disabled."
echo

launchctl unload -w /System/Library/LaunchAgents/com.apple.accountsd.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.AddressBook.ContactsAccountsService.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.AddressBook.SourceSync.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.AirPlayUIAgent.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.akd.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.askpermissiond.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.AOSPushHeartbeat.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.AOSPushRelay.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.bird.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.CalendarAgent.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.CallHistoryPluginHelper.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.CallHistorySyncHelper.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.cloudd.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.cloudfamilyrestrictionsd-mac.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.cloudpaird.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.cloudphotosd.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.CommCenter-osx.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.diagnostics_agent.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.familycircled.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.familynotificationd.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.findmymacmessenger.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.gamed.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.helpd.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.icloud.fmfd.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.identityservicesd.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.imagent.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.IMLoggingAgent.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.mediaremoteagent.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.metadata.SpotlightNetHelper.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.photolibraryd.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.photoanalysisd.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.SafariCloudHistoryPushAgent.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.safaridavclient.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.SafariNotificationAgent.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.sharingd.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.soagent.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.SocialPushAgent.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.suggestd.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.swcd.plist 2>/dev/null
launchctl unload -w /System/Library/LaunchAgents/com.apple.telephonyutilities.callservicesd.plist 2>/dev/null

sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.apsd.plist 2>/dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.awacsd.plist 2>/dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.awdd.plist 2>/dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.CrashReporterSupportHelper.plist 2>/dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.ctkd.plist 2>/dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.diagnosticd.plist 2>/dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.findmymac.plist 2>/dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.GameController.gamecontrollerd.plist 2>/dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.icloud.findmydeviced.plist 2>/dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.locationd.plist 2>/dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.mobileassetd.plist 2>/dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.nehelper.plist 2>/dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.netbiosd.plist 2>/dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.nfcd.plist 2>/dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.nfsd.plist 2>/dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.postfix.master.plist 2>/dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.postfix.newaliases.plist 2>/dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.seld.plist 2>/dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.SubmitDiagInfo.plist 2>/dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.symptomsd.plist 2>/dev/null
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.tccd.plist 2>/dev/null

sudo pkill Dock Finder mds SystemUIServer blued

sudo mdutil -i on / > /dev/null
sudo mdutil -E / > /dev/null
sudo tmutil disablelocal

sudo nvram SystemAudioVolume=" "
sudo nvram boot-args="-v"

sudo pmset -a sms 0
sudo pmset -a womp 0

sudo systemsetup -setusingnetworktime on
sudo systemsetup -setnetworktimeserver time1.google.com

sudo spctl --master-enable && echo ; echo "Enabled SecAssessment system policy"

echo
echo -n "Enter hostname: "
read name
sudo hostname -s $name
sudo scutil --set ComputerName $name
sudo scutil --set LocalHostName $name
sudo scutil --set HostName $name
sudo sysctl kern.hostname=$name

echo "kern.hostname=$name" | sudo tee -a /etc/sysctl.conf

echo
echo "Warning: the following commands are experimental and will likely break/crash parts of the OS!"
echo "SIP must be disabled for these commands to work (it should be re-enabled after)."
echo

echo -n "Continue? (y/n) "
read a
if echo "$a" | grep -ivq "^y" ; then echo "Done" ; exit 0 ; fi

sudo chmod -x /System/Library/CoreServices/mapspushd
sudo chmod -x /System/Library/Frameworks/Security.framework/Versions/A/Resources/IDSKeychainSyncingProxy.bundle/Contents/MacOS/IDSKeychainSyncingProxy
sudo chmod -x /System/Library/PrivateFrameworks/PassKitCore.framework/passd

sudo chmod -x /System/Library/CoreServices/OSDUIHelper.app/Contents/MacOS/OSDUIHelper
sudo chmod -x /System/Library/CoreServices/PowerChime.app/Contents/MacOS/PowerChime

sudo chmod -x /System/Library/Frameworks/Security.framework/Versions/A/Resources/CloudKeychainProxy.bundle/Contents/MacOS/CloudKeychainProxy

sudo chmod -x /System/Library/PrivateFrameworks/AssistantServices.framework/assistantd
sudo chmod -x /System/Library/PrivateFrameworks/MediaRemote.framework/Support/mediaremoted

sudo chmod -x /System/Library/PrivateFrameworks/CommerceKit.framework/Versions/A/Resources/storeaccountd
sudo chmod -x /System/Library/PrivateFrameworks/GeoServices.framework/geodMachServiceBridge
sudo chmod -x /System/Library/PrivateFrameworks/MobileAccessoryUpdater.framework/Support/fud

sudo chmod -x /usr/libexec/autofsd
sudo chmod -x /usr/libexec/automountd
sudo chmod -x /usr/libexec/DuetHeuristic-BM
sudo chmod -x /usr/libexec/keyboardservicesd
sudo chmod -x /usr/libexec/languageassetd
sudo chmod -x /usr/libexec/WiFiVelocityAgent
sudo chmod -x /usr/libexec/wifivelocityd

sudo chmod -x /System/Library/Input\ Methods/EmojiFunctionRowIM.app/Contents/PlugIns/EmojiFunctionRowIM_Extension.appex/Contents/MacOS/EmojiFunctionRowIM_Extension

echo "Done"

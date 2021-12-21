#!/bin/bash
# Notice: To be sure of correct operation you must run this scipt with SUDO privilegies
# This script closes popular apps, clear all your critycal user data and shutting down your system.
# WARNING: Some data maybe lost, make sure your data is backed up before you run this script!

echo 'Killing popular processes'

echo 'Killing process: Google Chrome browser...'
pkill -9 "Google Chrome"

echo 'Killing process: Mozilla Firefox browser...'
killall 'firefox'

echo 'Killing process: Apple Safari browser...'
killall 'Safari'

echo 'Killing process: Telegram...'
killall 'Telegram'

echo 'Killing process: WhatsApp...'
killall 'WhatsApp'

echo 'Killing process: Skype...'
killall 'Skype'

echo 'Killing process: Zoom...'
killall 'zoom.us'

echo 'Killing process: Discord...'
killall 'Discord'

echo 'Killing process: Signal...'
killall 'Signal'

echo "Clearing $USER data"

# Cookies
rm -rf ~/Library/Cookies/*

# https://chromium.googlesource.com/chromium/src/+/HEAD/docs/user_data_dir.md
echo "Clearing browsers data..."

# Google Chrome
# https://chromium.googlesource.com/chromium/src/+/HEAD/docs/user_data_dir.md
# https://crunchify.com/how-to-purge-all-your-google-chrome-user-data-on-mac-os-x/

rm -rf ~/Library/Caches/Google/Chrome/*
rm -rf ~/Library/Caches/Google/Chromium/*
rm -rf ~/Library/Caches/Google/Chrome\ Beta/*
rm -rf ~/Library/Caches/Google/Chrome\ SxS/*

rm -rf "$(find "~/Library/Caches" -type d -maxdepth 1 -name "com.google.Chrome*")"

rm -rf ~/Library/Application\ Support/Google/Chrome/*
rm -rf ~/Library/Application\ Support/Google/Chromium/*
rm -rf ~/Library/Application\ Support/Google/Chrome\ Beta/*
rm -rf ~/Library/Application\ Support/Google/Chrome\ SxS/*

# Mozilla Firefox
# https://support.mozilla.org/en-US/kb/profiles-where-firefox-stores-user-data

rm -rf ~/Library/Caches/Mozilla/*
rm -rf ~/Library/Caches/Firefox/*

rm -rf ~/Library/Application\ Support/Firefox/Profiles/*

# Apple Safari
rm -rf ~/Library/Safari/Databases/*
rm -rf ~/Library/Safari/Local\ Storage/*

rm -f ~/Library/Safari/LastSession.plist
rm -f ~/Library/Safari/Bookmarks.plist
rm -f ~/Library/Safari/RecentlyClosedTabs.plist
rm -f ~/Library/Safari/SearchDescriptions.plist
rm -f ~/Library/Safari/PasswordBreachStore.plist

rm -rf ~/Library/Caches/com.apple.Safari/*

echo "Clearing messengers data..."

# Telegram
telegramfolder=$(find "~/Library/Group\ Containers" -type d -maxdepth 1 -name "*.keepcoder.Telegram")
rm -rf "$(find "${telegramfolder}" -type d -maxdepth 2 -name "account-*")"

rm -rf ~/Library/Caches/ru.keepcoder.Telegram/*

# WhatsApp
rm -rf "$(find "~/Library/Group\ Containers" -type d -maxdepth 1 -name "*.desktop.WhatsApp")"

# Skype
rm -rf ~/Library/Application\ Support/Microsoft/Skype\ for\ Desktop/Cache/*
rm -rf ~/Library/Application\ Support/Microsoft/Skype\ for\ Desktop/Code\ Cache/*
rm -rf ~/Library/Application\ Support/Microsoft/Skype\ for\ Desktop/GPU\ Cache/*
rm -rf ~/Library/Application\ Support/Microsoft/Skype\ for\ Desktop/logs/*
rm -rf ~/Library/Application\ Support/Microsoft/Skype\ for\ Desktop/blob_storage/*
rm -rf ~/Library/Application\ Support/Microsoft/Skype\ for\ Desktop/Session\ Storage/*
rm -rf ~/Library/Application\ Support/Microsoft/Skype\ for\ Desktop/Local\ Storage/*

rm -rf ~/Library/Caches/com.skype.skype/*
rm -rf ~/Library/Caches/com.skype.skype.ShipIt/*

rm -f ~/Library/Application\ Support/Microsoft/Skype\ for\ Desktop/Cookies
rm -f ~/Library/Application\ Support/Microsoft/Skype\ for\ Desktop/Cookies-journal

# Signal
rm -rf ~/Library/Application\ Support/Signal/Cache/*
rm -rf ~/Library/Application\ Support/Signal/Code\ Cache/*
rm -rf ~/Library/Application\ Support/Signal/GPUCache/*
rm -rf ~/Library/Application\ Support/Signal/logs/*
rm -rf ~/Library/Application\ Support/Signal/blob_storage/*
rm -rf ~/Library/Application\ Support/Signal/Session\ Storage/*
rm -rf ~/Library/Application\ Support/Signal/Local\ Storage/*
rm -rf ~/Library/Application\ Support/Signal/temp/*

# Discord
rm -rf ~/Library/Application\ Support/discord/Cache/*
rm -rf ~/Library/Application\ Support/discord/Code\ Cache/*
rm -rf ~/Library/Application\ Support/discord/GPUCache/*
rm -rf ~/Library/Application\ Support/discord/logs/*
rm -rf ~/Library/Application\ Support/discord/blob_storage/*
rm -rf ~/Library/Application\ Support/discord/Session\ Storage/*
rm -rf ~/Library/Application\ Support/discord/Local\ Storage/*

# Zoom
rm -rf ~/Library/Application\ Support/zoom.us/*

# [TODO]: optional
#echo "Removing popular browsers"

# [TODO]: optional
#echo "Removing popular messengers"

# Zoom
# https://itectec.com/askdifferent/macos-unable-to-completely-uninstall-zoom-meeting-app/

#{
#  rm -rf /Applications/zoom.us.app
#  rm -rf ~/Applications/zoom.us.app
#  kextunload -b zoom.us.ZoomAudioDevice
#  rm -rf /System/Library/Extensions/ZoomAudioDevice.kext
#} &> /dev/null

#{
#    rm -rf ~/Downloads/zoomusInstaller.pkg
#    rm -rf /Applications/zoom.us.app
#    rm -rf ~/Desktop/Zoom
#    rm -rf ~/Library/Application Support/zoom.us
#    rm -rf ~/Library/Caches/us.zoom.xos
#    rm -rf ~/Library/Internet Plug-Ins/ZoomUsPlugIn.plugin
#    rm -rf ~/Library/Internet\ Plug-Ins/ZoomUsPlugIn.plugin
#    rm -rf ~/Library/Logs/zoom.us
#    rm -rf ~/Library/Logs/zoominstall.log
#    rm -rf ~/Library/Preferences/ZoomChat.plist
#    rm -rf ~/Library/Preferences/us.zoom.xos.plist
#    rm -rf ~/Library/Saved Application State/us.zoom.xos.savedState
#} &> /dev/null

echo "Clearing bash..."

FILE=~/.zsh_history
if test -f "$FILE"; then
    echo "Removing $FILE..."
    rm -f $FILE
fi

FILE=~/.bash_profile
if test -f "$FILE"; then
    echo "Removing $FILE..."
    rm -f $FILE
fi

DIR=/Users/$USER/.zsh_sessions
if [ -d "$DIR" ]; then
    echo "Removing $DIR..."
    rm -rf $DIR
fi

DIR=/Users/$USER/.bash_sessions
if [ -d "$DIR" ]; then
    echo "Removing $DIR..."
    rm -rf $DIR
fi

# Clearing Recycle Bin
echo "Clearing recycle bin..."
defaults write com.apple.finder WarnOnEmptyTrash -bool false
defaults write com.apple.finder EmptyTrashSecurely -bool false
rm - rf ~/.Trash/*
defaults write com.apple.finder EmptyTrashSecurely -bool true
defaults write com.apple.finder WarnOnEmptyTrash -bool true

# This can be useful for cleaning non-SSD drives.
# SSD drives has a TRIM and a special function "garbage disposal", which cleans the drive itself for later overwriting.
# For more information see https://appleinsider.ru/mac-os-x/kak-vospolzovatsya-propavshej-funkciej-diskovoj-utility.html
# This operation is optional and may takes several minutes!
# Please correct your disk(s) name(s)!

#echo "Erasing free space on your disks..."
#diskutil secureErase freespace 2 "/Volumes/Macintosh HD"

echo "DONE, Now your MacOS now will be shutting down!"

# Shutting down the system
shutdown -h now
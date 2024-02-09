#!/bin/bash

#  __  __                      _      _    
# |  \/  | __ ___   _____ _ __(_) ___| | __
# | |\/| |/ _` \ \ / / _ \ '__| |/ __| |/ /
# | |  | | (_| |\ V /  __/ |  | | (__|   < 
# |_|  |_|\__,_| \_/ \___|_|  |_|\___|_|\_\

# Backup Script by Aditya Patil 
# Note: Provide absolute paths to the directories

# Backup folder with git initialised and remote repository setup
backup_folder="/root/.backup_config/"

# Clear buffer cache option (yes/no)
clear_buffer_option="yes"

# Function to display program generated messages
display_message() {
  echo 
  echo "$1" 
  echo
}

# Checking for .git files in the buffer directory
if [ -d $backup_folder/.git ]; then 
  display_message "[+] Git found, continuing to backup"
else 
  display_message"[-] .git file not found, exiting"
  exit 1 
fi

# Directories to backup
declare -a directories=(
  [0]="/root/.config/backup_config"
  [1]="/root/.config/suckless"
  [2]="/root/.config/cheat_sheets"
  [3]="/root/.config/custom_scripts"
  [4]="/root/.config/status_crypto_coins"
  [5]="/root/.config/rofi"
)

# Files to backup
declare -a files=(
  [0]="/root/.zshrc"
  [1]="/root/.xinitrc"
  [2]="/usr/bin/trv.sh"
  [3]="/usr/bin/webp-convert.sh"
  [4]="/usr/bin/docker_blast.sh"
  [5]="/usr/bin/wifi-dmenu.sh"
  [6]="/etc/xdg/picom.conf"
  [7]="/usr/bin/trv.sh"
)

# Function to find and delete .git files in the given directory
delete_git_directories() {
  find "$1" -type d -name ".git" -exec rm -rf {} + 
}

# Copying directories to the backup buffer directory
for directory in ${directories[@]}; do 
  cp -r "$directory" /root/.backup_config/
done

# Removing .git files from the directories in the backup budder directory
for directory in ${directories[@]}; do 
  delete_git_directories "$directory"
done

# Copying files to the backup buffer directory
for file in ${files[@]}; do 
  cp "$file" /root/.backup_config/
done

# Pushing to the Remote Git Repository
cd "$backup_folder" 
git add .
git commit -m "Latest Backup"
git push git-server main 

# Deleting buffer directory cache
if [ "$clear_buffer_option" == "yes" ]; then 
  display_message "[+] Deleting Cache .... "
  rm -rf "$backup_folder"/*
  display_message "[+] Cache Cleared"
fi

display_message "[+] Exiting Backup Phase"

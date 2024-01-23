#!/bin/bash

#  __  __                      _      _    
# |  \/  | __ ___   _____ _ __(_) ___| | __
# | |\/| |/ _` \ \ / / _ \ '__| |/ __| |/ /
# | |  | | (_| |\ V /  __/ |  | | (__|   < 
# |_|  |_|\__,_| \_/ \___|_|  |_|\___|_|\_\
 
current_dir="$(pwd)"
while true; do
  selected_file=$(find "$current_dir" -maxdepth 1 -type f | dmenu -l 10 -p "Open file:")

  if [ -n "$selected_file" ]; then
    if [ -d "$selected_file" ]; then
      current_dir="$selected_file"
    else
      rifle "$selected_file"
      break
    fi 
  fi
done

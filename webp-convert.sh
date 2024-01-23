#!/bin/bash 

#  __  __                      _      _    
# |  \/  | __ ___   _____ _ __(_) ___| | __
# | |\/| |/ _` \ \ / / _ \ '__| |/ __| |/ /
# | |  | | (_| |\ V /  __/ |  | | (__|   < 
# |_|  |_|\__,_| \_/ \___|_|  |_|\___|_|\_\
 
if [ -d "$1" ]; then 
  for file in "$1"/*; do 
    if file --mime-type "$file" | grep -q "image"; then
      cwebp "$file" -o "${file%.*}.webp"
      echo "[+] Converted $file to ${file%.*}.webp"
    else 
      echo "[-] Skipping file: $file"
    fi
  done
else
  file=$1
  cwebp "$file" -o "${file%.*}.webp"
fi
echo "Conversion Completed"

#!/bin/bash 

#  __  __                      _      _    
# |  \/  | __ ___   _____ _ __(_) ___| | __
# | |\/| |/ _` \ \ / / _ \ '__| |/ __| |/ /
# | |  | | (_| |\ V /  __/ |  | | (__|   < 
# |_|  |_|\__,_| \_/ \___|_|  |_|\___|_|\_\

delete_git_directories() {
  find "$1" -type d -name ".git" -exec rm -rf {} + 
}

if [ -z "$1" ]; then 
  echo "[*] Usage: $0 <directory>"
  exit 1
fi 

if [ ! -d "$1" ]; then 
  echo "[-] Error: '$1' is not a directory."
  exit 1 
fi 

echo "[!] Are you sure (yes/no): " 
read confirmation

if [ "$confirmation" = "yes" ]; then
  delete_git_directories "$1"
else 
  echo "[*] Quiting the prorgam"
  exit 0
fi 

echo "[+] Finished deleting .git directories in $1."

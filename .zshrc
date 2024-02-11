# Custom config

#  __  __                      _      _    
# |  \/  | __ ___   _____ _ __(_) ___| | __
# | |\/| |/ _` \ \ / / _ \ '__| |/ __| |/ /
# | |  | | (_| |\ V /  __/ |  | | (__|   < 
# |_|  |_|\__,_| \_/ \___|_|  |_|\___|_|\_\

# Custom ZSH Configuration by Aditya Patil

source /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.zsh
autoload -U compinit; compinit

eval "$(starship init zsh)"
alias f="ranger"
alias qp="python3 $HOME/.custom_config/banner.py"
alias qr="$HOME/.custom_config/rust_banner"
alias c="clear"
alias e="exit"
alias nv="nvim"
alias nf="neofetch"
alias cf="cpufetch"
alias ff="fzf"
alias dps="docker ps -a"
alias :q="exit"
alias fedit="cat << EOF > $1"     # Fast edit with cat and EOF
alias ss="tty-clock -Ssc"
alias cm="cmatrix"
alias untar="tar xvf"
alias fx="firefox >/dev/null 2>&1 &"
alias piconf="nv /etc/xdg/picom.conf"
alias spotify="spotify-launcher >/dev/null 2>&1 &"
alias cheat="bash ~/.config/cheat_sheets/cheat.sh"
alias xss_payloads="cat ~/.config/cheat_sheets/xss_vectors.txt | fzf"
alias driver_finder="find -type d -name linux-6.6.10 | cd - | find -type f -name Makefile | xargs grep '$1'"
alias backup_config="~/.config/backup_config/backup_config.sh"
alias audio-control="pavucontrol"
alias headset="bluetoothctl connect $(cat ~/.headset_mac)"

# tmux commands 
alias tns="tmux new -s"   # tmux new session
alias tas="tmux a -t"     # tmux attach to target session
alias tls="tmux ls"       # tmux list sessions
alias tks="tmux kill-session -t" # tmux kill target session

# Commands replacement 
alias ls="lsd"
alias cat="bat"
alias la="lsd -la"
# Commands replacement ends

pi () {
  pacman -S python-"$1"
}

#dmenu config

dop() {
  file=$(ls -a | dmenu -l 10)
  nvim $file
}

wall() {
  confirm="no"
  while [ "$confirm" = "no" ]; do 
    selected_wallpaper=$(ls /root/.wallpapers/ | dmenu -l 40 -p "Select image:")
    sxiv "/root/.wallpapers/$selected_wallpaper"
    confirm=$(echo "yes\nno" | dmenu -l 2)
    if [ "$confirm" = "yes" ]; then 
      feh --bg-center "/root/.wallpapers/$selected_wallpaper"
      echo "$selected_wallpaper" > ~/.wallpaper_env
      break
    fi 
  done
}

wall_auto() {
  
  if [ $# -eq 0 ]; then 
    echo "Usage: $0 <interval>" 
  else  
    while true; do
      for file in ~/.wallpapers/*; do
        feh --bg-scale "$file"
        sleep "$1" 
      done
    done &
  fi

}

#dmenu config end 

autoremix() {
  remixd -s ./$1 -u https://remix.ethereum.org
}

fv() {                  # open files in nvim with fuzzy finder                  
  open_loc=$(fzf)
  nvim $open_loc
}

backup() {              # Create Backup of the file
  if [ -f "$1.bak" ]; then
    echo "File: $1 backup already exists, update the backup: [y/n]: "
    read -r backup_option
    if [ "$backup_option" = "y" ]; then
      rm "$1.bak"
      cp "$1" "$1.bak"
      echo "Backup File: $1.bak created successfully!"
    fi
  else
    cp "$1" "$1.bak"
    echo "Backup File: $1.bak created sucessfully!"
  fi
}

blast_k3s() {
  exec /usr/local/bin/k3s-killall.sh
}

# Delete with backup of file
newrm() {
  cp $1 $HOME/.deleted_files
  rm $1
  echo "File: $1 deleted, restore with restore <file> command"
}

restore() {
  cp $HOME/.deleted_files/$1 .
  rm $HOME/.deleted_files/$1
  echo "File: $1 restored sucessfully!"
}

empty_trash() {
  rm $HOME/.deleted_files/*
  echo "Deleted files backup cleared sucessfully"
}

b64() {
  echo "$1" | base64 -d && echo ""
}

fb() {
  ~/.local/bin/feroxbuster --url $1 -w ~/SecLists/Discovery/Web-Content/common.txt
}

# End of Delete with backup of file

# Git Modifications 
alias gadd="git add ."
alias gcom="git commit -m"
alias gpush="git push"
alias grem="git remote add origin " # remote repository link with .git ending
alias gmain="git push -u origin main"
alias gstatus="git status"
alias glog="git log | nv" 
alias gclone="git clone"
alias gcheckout="git checkout"

gauto() {       # Takes 1 arguement: commit message 
  git add . 
  git commit -m $1
  git push
}

ginit() {       # Takes 1 arguement: remote repository link with .git ending
  git init
  git add .
  git commit -m "initial commit"
  git branch -M main
  git remote add origin $1
  git push -u origin main
}

# Git Aliases End 
export VISUAL=nvim
export EDITOR=nvim

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#!/bin/sh

bash ~/.config/status_crypto_coins/status_crypto.sh &

cpu_usage() {
  echo "CPU: "$[100-$(vmstat 1 2|tail -1|awk '{print $15}')]"%"
}

mem_usage() {
  free | awk '/Mem/ {printf("MEM: %.2f%\n", $3/$2*100)}'
}

network_info() {
  for interface in /sys/class/net/*; do
      if [ -d "$interface" ]; then
          interface_name=$(basename "$interface")
          operstate=$(cat "$interface/operstate")

          if [ "$operstate" = "up" ]; then
              # ip_address=$(ip -4 -o address show dev "$interface_name" | awk '{print $4}')
              echo "$interface_name | "
          fi
      fi
  done
}

bluetooth_devices() {
  echo " $(bluetoothctl info | grep -E 'Name: .*' -o | cut -d ':' -f2- | cut -d ' ' -f2-) |"
}

status_monitor() {
  xsetroot -name "$(cat ~/.config/status_crypto_coins/status_crypto.txt) | $(mem_usage) | $(cpu_usage) |$(bluetooth_devices) $(network_info)$(date '+%a %b %d %H:%M') | $(whoami)"
}

status_bar_info() {
  while true; do
    status_monitor
    sleep 1  
  done
}

wallpaper_setup() {
  wallpaper_env=$(cat ~/.wallpaper_env)
  feh --bg-scale ~/.wallpapers/"$wallpaper_env"
}

wallpaper_setup

picom &

status_bar_info &

while type dwm >/dev/null; do dwm && continue || break; done

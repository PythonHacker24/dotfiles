#!/bin/bash

#  __  __                      _      _    
# |  \/  | __ ___   _____ _ __(_) ___| | __
# | |\/| |/ _` \ \ / / _ \ '__| |/ __| |/ /
# | |  | | (_| |\ V /  __/ |  | | (__|   < 
# |_|  |_|\__,_| \_/ \___|_|  |_|\___|_|\_\
 
interfaces=$(nmcli device | awk '$2=="wifi" {print $1}')

selected_interface=$(echo "$interfaces" | dmenu -p "Select a network interface:" -l 10)

wifi_list=$(nmcli device wifi list ifname "$selected_interface" | awk '{print $2}')

selected_network=$(echo "$wifi_list" | dmenu -p "Select a Wi-Fi network:" -l 10)

password=$(echo "" | dmenu -p "Enter the Wi-Fi password:")

nmcli device wifi connect "$selected_network" password "$password"

echo "Connecting to $selected_network..."

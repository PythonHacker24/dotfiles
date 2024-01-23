#!/bin/bash

#  __  __                      _      _    
# |  \/  | __ ___   _____ _ __(_) ___| | __
# | |\/| |/ _` \ \ / / _ \ '__| |/ __| |/ /
# | |  | | (_| |\ V /  __/ |  | | (__|   < 
# |_|  |_|\__,_| \_/ \___|_|  |_|\___|_|\_\
 
for i in `find /sys/ -name modalias -exec cat {} \;`; do 
  /sbin/modprobe --config /dev/null --show-depends $i ;
done | rev | cut -f 1 -d '/' | rev | sort -u 

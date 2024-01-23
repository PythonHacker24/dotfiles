#!/bin/bash

#  __  __                      _      _    
# |  \/  | __ ___   _____ _ __(_) ___| | __
# | |\/| |/ _` \ \ / / _ \ '__| |/ __| |/ /
# | |  | | (_| |\ V /  __/ |  | | (__|   < 
# |_|  |_|\__,_| \_/ \___|_|  |_|\___|_|\_\
 
echo "[*] Stopping all Docker Processes"
docker stop $(docker ps -a -q)
echo "[*] Removing all Docker Processes"
docker rm $(docker ps -a -q)
echo "[*] Removing all Docker Images"
docker rmi $(docker images -q)
echo "[*] Removing all Docker Volumes"
docker volume rm $(docker volume ls -q)
echo "[*] Removing all Docker Networks"
docker network rm $(docker network ls -q)
echo "[*] Docker System Prune All"
docker system prune -a
echo "[*] Docker System Prune All Forced Volumes"
docker system prune --all --force --volumes

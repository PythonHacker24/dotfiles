#  __  __                      _      _    
# |  \/  | __ ___   _____ _ __(_) ___| | __
# | |\/| |/ _` \ \ / / _ \ '__| |/ __| |/ /
# | |  | | (_| |\ V /  __/ |  | | (__|   < 
# |_|  |_|\__,_| \_/ \___|_|  |_|\___|_|\_\
# 
# Qemu Wizard by Aditya Patil

# This scripts creates virtual machines with Qemu on the go.
# Motivation: To create virtual machines fast for creating libraries of qemu virtual machines and organising them. 
# For creating use and delete virtual machines and using them as sandbox for various purposes like Malware Analysis.

# configuration 
virtual_machines="/root/virtual_machines"
echo 

# check for virtual_machines directory 
if [ -d $virtual_machines ]; then 
  echo "[+] Virtual Machine File found: $virtual_machines"
else 
  echo
  echo "[+] Directory not configured. Create Default Directory? ($HOME/virtual_machines) (yes/no)"
  read directory_option
  if [ "$directory_option" == "yes" ]; then 
    echo
    echo "[+] Creating New Directory for Virtual Machine .... "
    mkdir $HOME/virtual_machines
  else
    echo
    echo "[-] Cannot Proceed without Directory"
    exit 1
  fi
fi

echo 
echo "[1] New Virtual Machine"
echo "[2] Boot Existing Virtual Machine"
echo

echo "Select Option: "
read option

if [[ $option -eq 1 ]]; then
  echo "[+] Enter the ISO Absolute File Path"
  read iso_file
  
  echo 
  echo "[+] Virtual Machine Name"
  read virtual_machine_name
  
  echo 
  echo "[+] Enter the Disk Size"
  read disk_size

  echo 
  echo "[+] Creating Disk Image .... "
  qemu-img create -f qcow2 "$virtual_machines/$virtual_machine_name.img" "$disk_size"

  echo 
  echo "[+] Enter the Memory Size"
  read mem_size

  qemu-system-x86_64 -m "$mem_size" -hda "$virtual_machines/$virtual_machine_name.img" -cdrom "$iso_file"
  
  if [ -e "$virtual_machines/$virtual_machine_name.img" ]; then
    echo 
    echo "[+] Virtual Machine Disk Setup Successful"
  else 
    echo 
    echo "[+] Disk Allocation went wrong"
    exit 1 
  fi 

  exit 0

elif [[ "$option" == "2" ]]; then
  echo 
  echo "Booting Exisitng Virtual Machine .... "
  
  for file in "$virtual_machines"/*; do 
    if [ -f "$file" ]; then 
      filename=$(basename "$file")
      machine_name="${filename%.img}"
      echo " - $machine_name"
    fi
  done
  
  echo 
  echo "[+] Enter the Virtual Machine Name"
  read machine_option

  echo 
  echo "[+] Enter the Memory Size"
  read mem_size
  echo 

  qemu-system-x86_64 -hda "$virtual_machines/$machine_option.img" -m "$mem_size"
  
fi


#!/bin/bash

# --- uConsole Overclocking Script ---
# This script modifies the config.txt to add overclocking settings.
# Use at your own risk.

# Location of the config.txt file
CONFIG_FILE="/boot/firmware/config.txt"

# Settings to add for CM4 overclock
OC_SETTINGS="
[pi4]
over_voltage=6
arm_freq=2000
gpu_freq=750

[all]
gpu_mem=256
"

# --- Script Execution ---

echo "This script will apply overclocking settings for your uConsole CM4."
echo "Warning: Overclocking can increase temperatures and cause system instability."
echo "Do you want to continue? (yes/no)"
read -r user_response

if [[ "$user_response" =~ ^([yY][eE][sS]|[yY])$ ]]
then
     if [ -w "$CONFIG_FILE" ]
     then
         echo "Backing up original config.txt to $CONFIG_FILE.bak..."
         sudo cp "$CONFIG_FILE" "$CONFIG_FILE.bak"

         echo "Adding overclocking settings to $CONFIG_FILE..."
         # Check if [pi4] section already exists and modify or add it
         if sudo grep -q '\[pi4\]' "$CONFIG_FILE"; then
             # Append settings to the existing [pi4] block
             sudo sed -i '/\[pi4\]/a arm_freq=2000\ngpu_freq=750\nover_voltage=6' "$CONFIG_FILE"
         else
             # Add [pi4] block to the end of the file
             echo -e "\n[pi4]\narm_freq=2000\ngpu_freq=750\nover_voltage=6" | sudo tee -a "$CONFIG_FILE" > /dev/null
         fi

         # Handle gpu_mem in [all] section
         if sudo grep -q '\[all\]' "$CONFIG_FILE"; then
             sudo sed -i '/\[all\]/a gpu_mem=256' "$CONFIG_FILE"
         else
             echo -e "\n[all]\ngpu_mem=256" | sudo tee -a "$CONFIG_FILE" > /dev/null
         fi

         echo "Overclocking settings applied. Rebooting in 5 seconds..."
         sleep 5
         sudo reboot
     else
         echo "Error: Cannot write to $CONFIG_FILE. Run with sudo."
         exit 1
     fi
else
     echo "Overclocking aborted."
     exit 0
fi
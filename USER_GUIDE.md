# uConsole CM4 Overclocking Script – User Guide

> **Warning:**  
> Overclocking can increase heat, cause instability, and potentially damage your hardware.  
> The uConsole uses passive cooling—monitor your device carefully and start with a conservative overclock.  
> **Proceed at your own risk.**

---

## How to Use the Script

### 1. Create the Script File

Open a terminal on your uConsole and create a new file named `overclock_uconsole.sh`:
```bash
nano overclock_uconsole.sh
```

### 2. Paste the Script

Copy and paste the following code into the nano editor:

```bash
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
read -p 'Do you want to continue? (yes/no): ' user_response

if [[ "$user_response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    if [ -w "$CONFIG_FILE" ]; then
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
```

Press `Ctrl + X`, then `Y`, then `Enter` to save and exit nano.

---

### 3. Make the Script Executable

```bash
chmod +x overclock_uconsole.sh
```

---

### 4. Run the Script

```bash
sudo ./overclock_uconsole.sh
```

---

### 5. Confirm

The script will ask for confirmation. Type `yes` and press Enter to proceed.  
It will back up your original `config.txt`, apply the new settings, and reboot your uConsole.

---

## 6. Verify the New Clock Speed

After reboot, open the terminal and run:

```bash
vcgencmd measure_clock arm
```

The output should show a frequency near the `arm_freq` value you set (e.g., `frequency(48)=2000478464` for ~2 GHz).

---

## Troubleshooting

- If your uConsole fails to boot after overclocking, the settings are too aggressive.
- Remove the microSD card and insert it into another computer.
- Edit the `config.txt` file to remove or lower the overclocking values, save, and re-insert the card into your uConsole.

---

## How the Script Works

- **CONFIG_FILE:** Path to the `config.txt` file.
- **OC_SETTINGS:** Contains the overclocking parameters.
- **User Confirmation:** Prompts for input to prevent accidental overclocking.
- **Backup:** Creates a backup of the original `config.txt` as `.bak`.
- **Adding Settings:** Uses `grep`, `sed`, and `tee` to insert new settings in the correct sections.
- **Reboot:** Pauses, then reboots to apply changes.

---

**Use this guide and script with caution. Monitor your device for stability and temperature after applying changes.**
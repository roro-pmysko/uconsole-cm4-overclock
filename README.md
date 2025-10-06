# uConsole CM4 Overclocking Script
![Platform](https://img.shields.io/badge/platform-Raspberry%20Pi%20CM4-blue)

Safely overclock your Clockwork uConsole (Raspberry Pi CM4) with this automated Bash script.  
Includes backup, safety checks, and easy verification steps.

## Table of Contents
- [Features](#features)
- [Usage](#usage)
- [Setup Checklist](#setup-checklist)
- [Warnings](#warnings)
- [How to Check Overclocking Status in Terminal](#how-to-check-overclocking-status-in-terminal)
- [Requirements](#requirements)
- [License](#license)

## Features

- Backs up your original `config.txt`
- Adds recommended overclocking settings for CM4
- Optionally increases GPU memory allocation
- Prompts for confirmation before making changes

## Usage

```bash
chmod +x overclock.sh
sudo ./overclock.sh


Follow the prompts to confirm overclocking.

Setup Checklist
 Download and save overclock.sh
 Make the script executable (chmod +x overclock.sh)
 Run the script with sudo (sudo ./overclock.sh)
 Confirm overclocking when prompted
 Reboot and verify settings
Warnings
Overclocking can void your warranty.
Excessive overclocking may cause hardware damage, data corruption, or shorten the lifespan of your device.
Monitor system temperature and stability after applying changes.
If your system fails to boot, restore the backup config.txt.bak from recovery mode.
How to Check Overclocking Status in Terminal
After rebooting, you can verify the new clock speeds:

# Check CPU frequency
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq

# Check config.txt settings
grep -E 'arm_freq|gpu_freq|over_voltage|gpu_mem' /boot/firmware/config.txt

# Check system info
vcgencmd measure_clock arm
vcgencmd measure_clock core
vcgencmd measure_volts
vcgencmd get_mem gpu

If the values match your intended settings, overclocking was successful.

Requirements
Raspberry Pi CM4 (Clockwork uConsole)
Raspberry Pi OS or compatible Linux
Bash shell
License
MIT License

If the values match your intended settings, overclocking was successful.

Requirements
Raspberry Pi CM4 (Clockwork uConsole)
Raspberry Pi OS or compatible Linux
Bash shell
License
MIT License


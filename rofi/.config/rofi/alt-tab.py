#!/usr/bin/env python3

import json
import subprocess
import os
import math

# Configuration
home = os.environ.get("HOME")
thumb_dir = f"{home}/.cache/alttab"
rofi_override_1 = ""
rofi_override_2 = ""

# Get window information
hyprctl_output = subprocess.check_output(["hyprctl", "-j", "clients"])
windows = json.loads(hyprctl_output)
windows.sort(key=lambda x: x["focusHistoryID"])

# Filter and extract relevant windows
addresses = []
titles = []
for window in windows:
    addresses.append(window["address"])
    titles.append(window["title"])

# Don't do anything if no windows
if len(addresses) == 0:
    exit

# Move current window to end
addresses = addresses[1:] + [addresses[0]]
titles = titles[1:] + [titles[0]]

# Generate thumbnails
os.makedirs(thumb_dir, exist_ok=True)
for addr in addresses:
    if addr:
        subprocess.run([
            "hyprgrim",
            "-t", "jpeg",
            "-q", "5",
            "-w", addr,
            f"{thumb_dir}/{addr}.jpg"
        ])

# Prepare rofi input
rofi_input = []
for i, addr in enumerate(addresses):
    rofi_input.append(f"{titles[i]}\0icon\x1f{thumb_dir}/{addr}.jpg")

# Get rofi overrides
cols = min(len(addresses), 6)
rows = math.ceil(len(addresses) / 6)
rofi_override_1 = "listview { columns: " + str(cols) + "; lines: " + str(rows) + "; }"
width = min(95, int(95 / 6 * len(addresses)))
rofi_override_2 = "window { width: " + str(width) + "%; }"

# Run rofi
rofi_command = [
    "rofi",
    "-x11",
    "-dmenu",
    "-format", "i", # Rofi will output the selected index
    "-theme", f"{home}/.config/rofi/generic-selector.rasi",
    "-theme-str", rofi_override_1,
    "-theme-str", rofi_override_2
]

# Get selection
rofi_process = subprocess.Popen(
    rofi_command,
    stdin=subprocess.PIPE,
    stdout=subprocess.PIPE,
    text=True
)
i = rofi_process.communicate(input="\n".join(rofi_input))[0].strip()

address = addresses[int(i)]
subprocess.run([
    "hyprctl", "dispatch",
    "focuswindow", f"address:{address}"
])

subprocess.run([
    "hyprctl", "dispatch",
    "submap", "reset"
])


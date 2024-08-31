#!/bin/bash

# Enable Double-Click script
# Made by RDProject Development Team
# For personal use

# Start script
sudo mkdir -p /etc/libinput
sudo tee /etc/libinput/local-overrides.quirks >/dev/null <<ENDHERE
[Never Debounce]
MatchUdevType=mouse
ModelBouncingKeys=1
ENDHERE

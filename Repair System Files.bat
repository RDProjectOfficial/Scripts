# Repair System Files script
# Made by RDProject Development Team
# For personal use

# Start script
@echo off
sfc /scannow
DISM /Online /Cleanup-Image /RestoreHealth
echo "System Files were repaired (if there weren't any console errors). Have a nice day!"
pause

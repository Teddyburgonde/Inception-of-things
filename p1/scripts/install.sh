#!/bin/bash
set -e

# Install Vagrant
echo -e "Vagrant install\n"

if [ "$EUID" -ne 0 ]; then
  exec sudo "$0" "$@"
fi


wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vagrant


# Install Virtual box 

echo -e "Virtual box install\n"
sudo apt install curl wget gnupg2 lsb-release -y
curl -fsSL https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/vbox.gpg
curl -fsSL https://www.virtualbox.org/download/oracle_vbox.asc | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/oracle_vbox.gpg
echo "deb [arch=amd64] http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
sudo apt update
sudo apt install linux-headers-$(uname -r) dkms -y
sudo apt install virtualbox-7.0 -y


trap 'echo -e "\n\e[31;1m❌ Installation failed!\e[0m\n"' ERR
trap 'echo -e "\n\e[32;1m✅ Installation completed successfully! 🎉\e[0m\n"' EXIT
#!/bin/bash

set -e

# Update system packages
sudo apt update -y && sudo apt upgrade -y

# Install Git
sudo apt install -y git

git --version

# Install OpenSSH Server
sudo apt install -y openssh-server
sudo systemctl enable ssh
sudo systemctl start ssh
sudo ufw allow ssh

# Install Python
sudo apt install -y python3 python3-pip
python3 --version
pip3 --version

# Cleanup
sudo apt autoremove -y
sudo apt clean

echo "Installation of Git, OpenSSH Server, and Python is complete!"
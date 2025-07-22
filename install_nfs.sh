#!/usr/bin/env bash
#######################################################################
#Developed by : Dmitri Donskoy
#Purpose : Install and create nfs-share
#Date : 22.07.2025
#Version : 0.0.1
# set -x
set -o errexit
set -o nounset
set -o pipefail
#######################################################################

# Check if user is root
if [[ "$EUID" -ne 0 ]]; then
    echo "Please run as root"
    exit
fi

# Global variables
NFS_DIR="/tmp/share1"
INDEX_FILE="$NFS_DIR/index.html"

# Install NFS server
sudo apt update
sudo apt install -y nfs-kernel-server

# Create shared folder & index.html
sudo mkdir -p "$NFS_DIR"
echo "NFS StorageClass To Container" | sudo tee "$INDEX_FILE" > /dev/null

# Set permissions
sudo chown $USER:$USER "$NFS_DIR"
sudo chmod 775 "$NFS_DIR"

# Export NFS share
NFS_VALUE="$NFS_DIR 192.168.55.240 (rw,sync,no_subtree_check,no_root_squash)"
if ! grep -Fxq "$NFS_VALUE" /etc/exports; then
  echo "$NFS_VALUE" | sudo tee -a /etc/exports > /dev/null
fi

# Restart NFS services
sudo exportfs -a
sudo systemctl restart nfs-kernel-server



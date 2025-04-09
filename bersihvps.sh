#!/bin/bash

echo "=== Membersihkan sistem VPS ==="
sudo apt update && sudo apt upgrade -y
sudo apt autoremove -y
sudo apt clean
sudo journalctl --vacuum-time=2d

echo "=== Membersihkan Docker ==="
docker stop $(docker ps -aq) 2>/dev/null
docker rm $(docker ps -aq) 2>/dev/null
docker image prune -a -f
docker volume prune -f
docker network prune -f
docker system prune -a --volumes -f

echo "=== Membersihkan cache dan file sementara ==="
# Hapus cache pengguna
rm -rf ~/.cache/*

# Hapus file sementara di /tmp (dengan hak sudo)
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*

echo "=== Pembersihan selesai ==="
df -h

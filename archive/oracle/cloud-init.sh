#!/bin/bash
set -eux

# Adiciona swap de 3GB para compensar o 1GB de RAM fixo do E2.1.Micro
# RAM(1GB) + Swap(3GB) = 4GB de memória virtual total
if [ ! -f /swapfile ]; then
  sudo fallocate -l 3G /swapfile
  sudo chmod 600 /swapfile
  sudo mkswap /swapfile
  sudo swapon /swapfile
  echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
fi

# Desabilita plugins lentos e configura timeout para não travar o boot
sudo dnf -y \
  --disableplugin=fastestmirror \
  --disableplugin=langpacks \
  --setopt=timeout=30 \
  --setopt=retries=3 \
  update

sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Instala Docker CE
sudo dnf -y \
  --disableplugin=fastestmirror \
  --disableplugin=langpacks \
  install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl enable --now docker

sudo usermod -aG docker opc

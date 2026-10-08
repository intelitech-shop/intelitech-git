#!/bin/bash
set -eux

# Desabilita plugins lentos e configura timeout para não travar o boot
sudo dnf -y \
  --disableplugin=fastestmirror \
  --disableplugin=langpacks \
  --setopt=timeout=30 \
  --setopt=retries=3 \
  update

# Instala Docker
sudo dnf -y install docker
sudo systemctl enable --now docker

sudo usermod -aG docker opc

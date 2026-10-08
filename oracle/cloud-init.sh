#!/bin/bash
set -eux

# Atualiza o SO e instala Docker (exemplo)
sudo dnf update -y
sudo dnf install -y docker
sudo systemctl enable --now docker
sudo usermod -aG docker $(whoami)

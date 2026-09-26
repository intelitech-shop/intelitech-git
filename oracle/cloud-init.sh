#!/bin/bash

set -eux

dnf update -y
dnf install -y docker git curl

systemctl enable --now docker

usermod -aG docker opc

mkdir -p /opt/myapp
cd /opt/myapp

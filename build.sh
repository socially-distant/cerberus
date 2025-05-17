#!/bin/bash

set -ouex pipefail

MAJOR_VERSION_NUMBER="$(sh -c '. /usr/lib/os-release ; echo $VERSION_ID | cut -d'.' -f1')"
export MAJOR_VERSION_NUMBER

dnf install -y tmux alacritty fastfetch fish

dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
dnf install -y tailscale

dnf copr enable lilay/topgrade
dnf install -y topgrade

systemctl enable podman.socket

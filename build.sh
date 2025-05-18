#!/bin/bash

set -ouex pipefail

MAJOR_VERSION_NUMBER="$(sh -c '. /usr/lib/os-release ; echo $VERSION_ID | cut -d'.' -f1')"
export MAJOR_VERSION_NUMBER

dnf install -y tmux \
        alacritty \
        fastfetch \
        fish \
        podman-docker \
        edk2-ovmf \
        qemu \
        libvirt \
        virt-manager \

dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo
dnf install -y tailscale

dnf copr enable -y lilay/topgrade
dnf install -y topgrade

rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h\n" | tee -a /etc/yum.repos.d/vscodium.repo
dnf install -y codium

systemctl enable podman.socket

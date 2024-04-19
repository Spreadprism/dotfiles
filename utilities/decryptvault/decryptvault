#!/bin/zsh

op read op://Private/ArchLinuxLaptop/password | sudo -S -p "" echo Opening Vault
op read op://Private/Vault/password | sudo cryptsetup luksOpen /dev/nvme0n1p1 Vault
udisksctl mount -b /dev/disk/by-label/Vault

#!/bin/zsh

udisksctl unmount -b /dev/disk/by-label/Vault
udisksctl lock -b /dev/nvme0n1p1

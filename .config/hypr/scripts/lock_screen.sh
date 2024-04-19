#! /bin/bash

# Lock the screen if 1Password is running
~/.config/hypr/scripts/crypt_vault.zsh
1password --lock
hyprlock && ~/.config/hypr/scripts/unlocked_screen.zsh

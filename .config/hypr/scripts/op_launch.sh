#!/bin/zsh

# I need to find a way to do ! if
if $(hyprctl clients -j | grep -q "\"class\": \"1Password\""); then
  hyprctl dispatch togglespecialworkspace 1password
else
  hyprctl dispatch exec 1password
  hyprctl dispatch togglespecialworkspace 1password
fi

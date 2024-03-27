#!/bin/zsh

# if grep returns nothing we need to init the program
if $(hyprctl clients -j | grep -q "\"class\": \"1Password\""); then
  hyprctl dispatch togglespecialworkspace 1password
else
  hyprctl dispatch exec 1password
fi

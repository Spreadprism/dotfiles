#!/bin/zsh

# if grep returns nothing we need to init the program
if $(hyprctl clients -j | grep -q "\"class\": \"thunderbird\""); then
  hyprctl dispatch togglespecialworkspace mail
else
  hyprctl dispatch exec thunderbird
  hyprctl dispatch togglespecialworkspace mail
fi

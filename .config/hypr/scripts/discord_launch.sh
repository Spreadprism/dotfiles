#!/bin/zsh

# if grep returns nothing we need to init the program
if $(hyprctl clients -j | grep -q "\"class\": \"discord\""); then
  hyprctl dispatch togglespecialworkspace discord
else
  hyprctl dispatch exec discord
fi

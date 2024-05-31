#!/bin/zsh

# if grep returns nothing we need to init the program
if $(hyprctl clients -j | grep -q "\"class\": \"betterbird\""); then
  hyprctl dispatch togglespecialworkspace mail
else
  hyprctl dispatch exec MOZ_ENABLE_WAYLAND=1 betterbird
  hyprctl dispatch togglespecialworkspace mail
fi

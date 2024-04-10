#!/bin/zsh

cmd=$1
workspace=$2

hyprctl dispatch exec $cmd

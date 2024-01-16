#!/bin/zsh

env_dir=$HOME/miniconda3/envs/
current_directory_name="${PWD##*/}"

if [ -d "$env_dir/$current_directory_name"_env ]; then
  exit 0
elif [ -d "$env_dir/$current_directory_name" ]; then
  exit 0
fi

exit 1

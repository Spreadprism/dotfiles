#!/bin/zsh


# INFO: Activate conda environment if it exists
envs=$(conda env list | awk '{print $1}' | grep -v '^#')
if [[ $envs == *"$current_directory_name"* ]]; then
    conda activate "$current_directory_name"
fi

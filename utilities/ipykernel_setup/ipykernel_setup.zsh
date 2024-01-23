#!/bin/zsh

# make sure we are in a conda environment
if [ -z "$CONDA_DEFAULT_ENV" ]; then
    echo "You must activate a conda environment before running this script"
    exit 1
fi

pip install ipykernel
python -m ipykernel install --user --name "$CONDA_DEFAULT_ENV" 

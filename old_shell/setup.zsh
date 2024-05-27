#!/bin/zsh

PRIVATE_CONFIG_FILE="private.zsh"

# Verify if private_config.zsh exists
if [ ! -f $PRIVATE_CONFIG_FILE ]; then
  touch $PRIVATE_CONFIG_FILE
fi
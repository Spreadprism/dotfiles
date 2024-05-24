DIRECTORY_NAME := $(notdir $(CURDIR))
CONFIG_PATH := $(HOME)/.config
DOTFILE_CONFIG_PATH := $(HOME)/.dotfiles/.config/$(DIRECTORY_NAME)
new_link:
	@echo "Linking ~/.config/$(DIRECTORY_NAME)"
	@rm -rf $(CONFIG_PATH)/nvim
	@rm -rf $(CONFIG_PATH)/nvim-rocks
	@ln -s $(DOTFILE_CONFIG_PATH)/main $(CONFIG_PATH)/nvim
	@ln -s $(DOTFILE_CONFIG_PATH)/rocks $(CONFIG_PATH)/nvim-rocks
	@ln -s $(DOTFILE_CONFIG_PATH)/lazyrocks $(CONFIG_PATH)/lazyrocks

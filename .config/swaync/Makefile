DIRECTORY_NAME := $(notdir $(CURDIR))
CONFIG_PATH := $(HOME)/.config/$(DIRECTORY_NAME)
DOTFILE_CONFIG_PATH := $(HOME)/.dotfiles/.config/$(DIRECTORY_NAME)
new_link:
	@echo "Linking ~/.config/$(DIRECTORY_NAME)"
	@rm -rf $(CONFIG_PATH)
	@ln -s $(DOTFILE_CONFIG_PATH) $(CONFIG_PATH)

reload_config:
	@echo "Reloading sway config"
	@swaync-client -R
	@swaync-client -rs

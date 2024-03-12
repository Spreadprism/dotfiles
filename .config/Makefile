link_config:
	@cd dunst && make
	@cd hypr && make
	@cd git && make
	@cd kanshi && make
	@cd kitty && make
	@cd lazydocker && make
	@cd lazygit && make
	@cd nvim && make
	@cd swaylock && make
	@cd tmux && make
	@cd waybar && make
	@cd wlogout && make
	@make link_starship

link_starship:
	@echo "Linking ~/.config/starship.toml"
	@rm -f ~/.config/starship.toml
	@ln -s ~/.dotfiles/.config/starship.toml ~/.config/starship.toml

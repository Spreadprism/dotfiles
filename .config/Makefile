link_config:
	@cd dunst && make
	@cd git && make
	@cd hypr && make
	@cd kanshi && make
	@cd kitty && make
	@cd lazydocker && make
	@cd lazygit && make
	@cd nvim && make
	@cd pypoetry && make
	@cd swaylock && make
	@cd tmux && make
	@cd waybar && make
	@cd wlogout && make
	@make link_starship

link_starship:
	@echo "Linking ~/.config/starship.toml"
	@rm -f ~/.config/starship.toml
	@ln -s ~/.dotfiles/.config/starship.toml ~/.config/starship.toml

link_rope:
	@echo "Linking ~/.config/pytool.toml"
	@rm -f ~/.config/pytool.toml
	@ln -s ~/.dotfiles/.config/pytool.toml ~/.config/pytool.toml

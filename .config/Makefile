link_config:
	@cd tmux && make
	@cd nvim && make
	@cd lazygit && make
	@cd lazydocker && make
	@make link_starship

link_starship:
	@echo "Linking ~/.config/starship.toml"
	@rm -f ~/.config/starship.toml
	@ln -s ~/.dotfiles/.config/starship.toml ~/.config/starship.toml


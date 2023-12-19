
link_all:
	@echo "Linking all"
	@make build_utilities --no-print-directory # INFO: Utilities need to be built before everything else
	@make link_zsh --no-print-directory
	@make link_config --no-print-directory

link_zsh:
	@echo "Linking ~/.zshrc"
	@rm -f ~/.zshrc
	@ln -s ~/.dotfiles/.zshrc ~/.zshrc
	@rm -f ~/.zshrc_private
	@ln -s ~/.dotfiles/.zshrc_private ~/.zshrc_private

private_zsh:
	touch .zshrc_private
	chmod  +x .zshrc_private

link_config:
	@cd .config && make

link_conda:
	@echo "Linking ~/.condarc"
	@rm -f ~/.condarc
	@ln -s ~/.dotfiles/.condarc ~/.condarc

build_utilities:
	@cd utilities && make --no-print-directory

link_glaze:
	@cd .glaze-wm && make --no-print-directory

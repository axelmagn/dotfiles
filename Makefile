INSTALL_DIR:=$(HOME)
STOW_SOURCES=$(wildcard *.stow)
ARCH_PACMAN_PACKAGES=$(wildcard *.arch.pkgs)
ARCH_AUR_PACKAGES=$(wildcard *.arch.aur.pkgs)
STOW_TARGETS=$(patsubst %,%.install,$(STOW_SOURCES))
ARCH_TARGETS=$(patsubst %,%.install,$(ARCH_PACMAN_PACKAGES) $(ARCH_AUR_PACKAGES))
VIM_DIR:=$(INSTALL_DIR)/.vim/bundle
.PHONY: install uninstall arch_install

install: $(STOW_TARGETS)

uninstall:
	stow -t $(INSTALL_DIR) -D $(STOW_SOURCES)
	rm -rf $(STOW_TARGETS)

arch_install: $(ARCH_TARGETS)

vim.stow.install: vim.stow $(VIM_DIR)/Vundle.vim
	stow -t $(INSTALL_DIR) $<
	vim +PluginInstall +qall
	touch $@

$(VIM_DIR)/Vundle.vim:
	mkdir -p $(VIM_DIR)
	git clone --depth=1 https://github.com/VundleVim/Vundle.vim.git  \
		$(VIM_DIR)/Vundle.vim

%.stow.install: %.stow 
	stow -t $(INSTALL_DIR) $<
	touch $@

%.arch.pkgs.install: %.arch.pkgs
	xargs sudo pacman -Sy --needed --noconfirm < $<
	touch $@

%.arch.aur.pkgs.install: %.arch.aur.pkgs
	xargs yaourt -Sy --needed --noconfirm < $<
	touch $@

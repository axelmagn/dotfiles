INSTALL_DIR:=$(HOME)
STOW_SOURCES=$(wildcard *.stow)
STOW_TARGETS=$(patsubst %.stow,%.stow.install,$(STOW_SOURCES))
VIM_DIR:=$(INSTALL_DIR)/.vim/bundle
.PHONY: install uninstall

install: $(STOW_TARGETS)

uninstall:
	stow -t $(INSTALL_DIR) -D $(STOW_SOURCES)
	rm -rf $(STOW_TARGETS)

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

DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
HOMEBREW_PREFIX := $(shell if [ "$$(uname -m)" = "arm64" ]; then echo /opt/homebrew; else echo /usr/local; fi)
export N_PREFIX = $(HOME)/.n
PATH := $(HOMEBREW_PREFIX)/bin:$(DOTFILES_DIR)/bin:$(N_PREFIX)/bin:$(PATH)
SHELL := env PATH=$(PATH) /bin/bash
BREW ?= brew
export XDG_CONFIG_HOME = $(HOME)/.config
export STOW_DIR = $(DOTFILES_DIR)
export ACCEPT_EULA = Y

.PHONY: brew ensure-brew brew-packages cask-apps

brew: ensure-brew brew-packages cask-apps
	@echo "Homebrew taps, formulae, and casks are up to date."

ensure-brew:
	@if ! command -v $(BREW) >/dev/null 2>&1; then \
		echo "Homebrew not detected. Install it from https://brew.sh and rerun."; \
		exit 1; \
	fi
	@$(BREW) tap homebrew/bundle >/dev/null 2>&1 || true

brew-packages:
	@echo "==> Synchronizing Homebrew formulae from Brewfile"
	@$(BREW) bundle --file=$(DOTFILES_DIR)/packages/Brewfile || true

cask-apps:
	@echo "==> Synchronizing Homebrew casks from Caskfile"
	@$(BREW) bundle --file=$(DOTFILES_DIR)/packages/Caskfile || true

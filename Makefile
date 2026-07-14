.DEFAULT_GOAL := help

HOST ?= $(shell hostname -s)
USERNAME ?= $(shell id -un)
DARWIN_TARGET ?= .\#$(HOST)
HOME_TARGET ?= .\#$(USERNAME)@$(HOST)

NIX ?= nix
NIX_FLAGS ?= --extra-experimental-features "nix-command flakes"
NIX_CMD = $(NIX) $(NIX_FLAGS)

.PHONY: help install-nix install-nix-darwin bootstrap-mac \
	darwin-rebuild home-manager-switch switch \
	nix-gc flake-update flake-check

help: ## Show available targets
	@awk 'BEGIN { FS = ":.*## "; printf "Usage: make \033[36m<target>\033[0m\n\nTargets:\n" } /^[a-zA-Z0-9_-]+:.*## / { printf "  \033[36m%-22s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

install-nix: ## Install the Nix package manager
	curl --proto '=https' --tlsv1.2 --fail --silent --show-error --location \
		https://nixos.org/nix/install | sh -s -- --daemon --yes

install-nix-darwin: ## Install and activate nix-darwin
	sudo $(NIX_CMD) run nix-darwin -- switch --flake $(DARWIN_TARGET)

bootstrap-mac: ## Install Nix and nix-darwin
	$(MAKE) install-nix
	. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh; \
		$(MAKE) install-nix-darwin

darwin-rebuild: ## Activate the nix-darwin configuration
	sudo darwin-rebuild switch --flake $(DARWIN_TARGET)

home-manager-switch: ## Activate the Home Manager configuration
	home-manager switch --flake $(HOME_TARGET)

switch: ## Activate system and Home Manager configurations
	$(MAKE) darwin-rebuild
	$(MAKE) home-manager-switch

nix-gc: ## Delete old generations and collect garbage
	nix-collect-garbage --delete-old

flake-update: ## Update all flake inputs
	$(NIX_CMD) flake update

flake-check: ## Check the flake configuration
	$(NIX_CMD) flake check --show-trace

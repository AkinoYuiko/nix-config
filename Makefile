# Default entry point
.DEFAULT_GOAL := help

# Tooling
NIX ?= nix
NIXFMT ?= nixfmt
NIX_FLAGS ?= --extra-experimental-features "nix-command flakes"
NIX_CMD = $(NIX) $(NIX_FLAGS)
NIX_FILES := $(shell find . -type f -name '*.nix' \
	-not -path './.git/*' \
	-not -path './.codegraph/*' | sort)

.PHONY: help format format-check check \
	build darwin-build home-manager-build \
	install-nix install-nix-darwin bootstrap-mac \
	darwin-rebuild home-manager-switch switch \
	nix-gc flake-update flake-check

# Discovery and validation
help: ## Show available targets
	@printf 'Usage: make \033[36m<target>\033[0m\n\nTargets:\n'
	@awk 'BEGIN { FS = ":.*## " } \
		/^[a-zA-Z0-9_-]+:.*## / { \
			printf "  \033[36m%-22s\033[0m %s\n", $$1, $$2 \
		}' $(MAKEFILE_LIST)

format: ## Format all Nix files
	@printf 'Formatting Nix files...\n'
	@$(NIXFMT) $(NIX_FILES)

format-check: ## Check Nix formatting without changing files
	@printf 'Checking Nix formatting...\n'
	@$(NIXFMT) --check $(NIX_FILES)

check: ## Run all non-mutating checks
	@$(MAKE) --no-print-directory format-check
	@$(MAKE) --no-print-directory flake-check

flake-check: ## Check the flake configuration
	@printf 'Checking Flake outputs...\n'
	@$(NIX_CMD) flake check --show-trace

# Build
build: ## Build Darwin and Home Manager configurations
	@$(MAKE) --no-print-directory darwin-build
	@$(MAKE) --no-print-directory home-manager-build

darwin-build: ## Build the nix-darwin configuration
	@printf 'Building nix-darwin configuration...\n'
	@$(NIX_CMD) build --no-link '.#darwinConfigurations.moni.system'

home-manager-build: ## Build the Home Manager configuration
	@printf 'Building Home Manager configuration...\n'
	@$(NIX_CMD) build --no-link '.#homeConfigurations."momo@moni".activationPackage'

# Installation and bootstrap
install-nix: ## Install the Nix package manager
	curl --proto '=https' --tlsv1.2 --fail --silent --show-error --location \
		https://nixos.org/nix/install | sh -s -- --daemon --yes

install-nix-darwin: ## Install and activate nix-darwin
	sudo $(NIX_CMD) run nix-darwin -- switch --flake .#moni

bootstrap-mac: ## Install Nix and nix-darwin
	@$(MAKE) --no-print-directory install-nix
	@. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh; \
		$(MAKE) --no-print-directory install-nix-darwin

# Activation
# These targets change the running machine. Use them only when activation is
# explicitly requested.
darwin-rebuild: ## Activate the nix-darwin configuration
	sudo darwin-rebuild switch --flake .#moni

home-manager-switch: ## Activate the Home Manager configuration
	$(NIX_CMD) run --inputs-from . home-manager -- switch --flake .#momo@moni

switch: ## Build and activate system and Home Manager configurations
	@$(MAKE) --no-print-directory build
	@$(MAKE) --no-print-directory darwin-rebuild
	@$(MAKE) --no-print-directory home-manager-switch

# Maintenance
flake-update: ## Update all flake inputs
	$(NIX_CMD) flake update

nix-gc: ## Delete old generations and collect garbage
	nix-collect-garbage --delete-old

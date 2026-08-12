# Architecture

This repository manages the `moni` macOS host for user `momo` with nix-darwin and Home Manager.

## Structure

| Path | Responsibility | Editing guidance |
| --- | --- | --- |
| `flake.nix` | Flake entry point. Declares inputs, user config, and nix-darwin/Home Manager outputs. | Add new inputs here; keep module-specific settings out. |
| `flake.lock` | Dependency lock. Pins all Flake inputs. | Change through `make flake-update` unless a targeted lock operation is explicitly requested. |
| `modules/darwin.nix` | System module. Nix settings, users, macOS defaults, Homebrew, fonts, shells, security. | Use for settings that affect the whole macOS system. |
| `modules/home.nix` | Home module. Imports enabled program modules, declares home packages and state version. | A program module is active only when imported here. |
| `modules/programs/<program>.nix` | Program modules. One per user-level program. | Keep each program isolated; add its import to `modules/home.nix` when enabling it. |
| `modules/programs/neovim/` | Neovim sub-modules. `packages.nix` lists LSPs/formatters/tools; `plugins.nix` lists plugins. | Keep plugin declarations out of `packages.nix`. |
| `files/` | Static assets. | Reference files with Nix paths; do not generate build output here. |
| `overlays/` | Package overrides applied to the Home Manager package set. | Add overrides only when stock nixpkgs is unsuitable; keep the rationale in the file header. |

## Makefile target reference

| Command | Effect | When to use |
| --- | --- | --- |
| `make help` | Lists documented targets. | At the start of work or after changing the Makefile. |
| `make format` | Formats every Nix file with `nixfmt`. | After editing any `*.nix` file. |
| `make format-check` | Checks formatting without modifying files. | When a read-only formatting check is needed. |
| `make flake-check` | Evaluates and checks Flake outputs with traces. | For focused Flake validation. |
| `make check` | Runs formatting and Flake checks without activation. | Default final validation for configuration changes. |
| `make darwin-rebuild` | Builds and activates the nix-darwin system configuration. | Only when system activation is explicitly requested. Requires `sudo`. |
| `make home-manager-switch` | Builds and activates the Home Manager configuration. | Only when user-environment activation is explicitly requested. |
| `make switch` | Activates nix-darwin first, then Home Manager. | Preferred full rebuild when explicitly requested. Requires `sudo`. |
| `make flake-update` | Updates all Flake inputs and `flake.lock`. | Only for an explicit dependency-update request. |
| `make nix-gc` | Deletes old generations and collects garbage. | Only for an explicit cleanup request. |
| `make install-nix` | Installs Nix in daemon mode. | Bootstrap only; never run on an already managed machine without confirmation. |
| `make install-nix-darwin` | Installs and activates nix-darwin. | Bootstrap only; requires `sudo`. |
| `make bootstrap-mac` | Installs Nix and then nix-darwin. | New-machine bootstrap only and only with explicit confirmation. |



# Architecture

This repository manages the `moni` macOS host for user `momo` with nix-darwin and Home Manager.

## Structure

| Path | Responsibility | Editing guidance |
| --- | --- | --- |
| `flake.nix` | Flake entry point. Declares inputs, user config, and nix-darwin/Home Manager outputs. | Add new inputs here; keep module-specific settings out. |
| `flake.lock` | Dependency lock. Pins all Flake inputs. | — |
| `modules/darwin.nix` | System module. Nix settings, users, macOS defaults, Homebrew, fonts, shells, security. | Use for settings that affect the whole macOS system. |
| `modules/home.nix` | Home module. Imports enabled program modules, declares home packages and state version. | A program module is active only when imported here. |
| `modules/programs/<program>.nix` | Program modules. One per user-level program. | Keep each program isolated; add its import to `modules/home.nix` when enabling it. |
| `modules/programs/neovim/` | Neovim sub-modules. `packages.nix` lists LSPs/formatters/tools; `plugins.nix` lists plugins. | Keep plugin declarations out of `packages.nix`. |
| `overlays/` | Package overrides applied to the Home Manager package set. | Add overrides only when stock nixpkgs is unsuitable; keep the rationale in the file header. |




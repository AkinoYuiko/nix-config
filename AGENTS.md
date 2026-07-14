# Repository guide for agents

This repository manages the `moni` macOS host for user `momo` with
nix-darwin and Home Manager. Use the root `Makefile` as the primary command
interface so that agents and humans follow the same workflow.

## Structure

| Path | Layer | Responsibility | Editing guidance |
| --- | --- | --- | --- |
| `flake.nix` | Flake entry point | Declares inputs, users, hosts, and generates nix-darwin/Home Manager outputs. | Add hosts and users here; keep host-specific settings out of this file. |
| `flake.lock` | Dependency lock | Pins all Flake inputs. | Change through `make flake-update` unless a targeted lock operation is explicitly requested. |
| `hosts/<host>/default.nix` | Host entry point | Selects the nix-darwin modules and host platform/state version. | Keep machine-specific system settings here. Current host: `moni`. |
| `home/<user>/<host>/default.nix` | Home entry point | Selects the Home Manager modules and home state version. | Keep user-and-host-specific settings here. Current target: `momo@moni`. |
| `modules/darwin/common/default.nix` | Shared system module | Configures Nix, users, macOS defaults, system packages, fonts, shells, and security. | Use for settings that affect the whole macOS system. |
| `modules/darwin/homebrew/default.nix` | Homebrew module | Controls nix-darwin Homebrew integration and activation behavior. | Keep Homebrew lifecycle policy here. |
| `modules/home-manager/common/default.nix` | Shared home module | Imports enabled program modules and defines common Home Manager settings. | A program module is active only when imported here. |
| `modules/home-manager/programs/<program>/default.nix` | Program modules | Configures one user-level program per directory. | Keep each program isolated; add its import to the common module when enabling it. |
| `modules/home-manager/programs/neovim/packages.nix` | Neovim packages | Lists language servers, formatters, and runtime tools used by Neovim. | Keep plugin declarations out of this file. |
| `modules/home-manager/programs/neovim/plugins.nix` | Neovim plugins | Lists packaged Neovim plugins and plugin-specific configuration. | Keep external Flake inputs in `flake.nix` only when a plugin truly requires one. |
| `files/` | Static assets | Stores assets referenced by user configuration. | Reference files with Nix paths; do not generate build output here. |
| `Makefile` | Command interface | Provides formatting, validation, activation, installation, update, and maintenance commands. | Prefer adding a readable Make target over documenting a long raw command. |

## Makefile-first workflow

1. Run `make help` before choosing a command.
2. Edit the smallest appropriate module boundary.
3. Run `make format` after changing Nix files.
4. Run `make check` before reporting completion or creating commits.
5. Activate changes only when the user explicitly requests it.

If a Make target exists, use it instead of invoking its underlying command
directly. In particular, do not bypass the Makefile with raw
`darwin-rebuild`, `home-manager switch`, `nix flake check`, `nix flake
update`, or `nix-collect-garbage` commands.

## Target reference

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

## Target selection

The Makefile derives targets from the current short hostname and user:

```text
DARWIN_TARGET = .#<host>
HOME_TARGET   = .#<user>@<host>
```

Override detection when working for another declared target:

```sh
make darwin-rebuild HOST=moni
make home-manager-switch HOST=moni USERNAME=momo
make switch HOST=moni USERNAME=momo
```

The current declared outputs are `.#moni` and `.#momo@moni`.

## Safety and change boundaries

- `make format`, `make format-check`, `make flake-check`, and `make check` do
  not activate the configuration.
- `make darwin-rebuild`, `make home-manager-switch`, and `make switch` mutate
  the running machine; do not run them merely to validate edits.
- Installation, updates, garbage collection, and activation require explicit
  user intent.
- Keep system-wide configuration under `modules/darwin/` and user-level
  configuration under `modules/home-manager/`.
- Preserve `system.stateVersion` and `home.stateVersion` unless the user asks
  for a version migration.
- Do not edit `flake.lock` manually.
- After changing the Makefile, verify both `make help` and `make check`.

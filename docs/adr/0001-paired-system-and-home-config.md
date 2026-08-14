# Paired system and home configuration in one flake

This repository manages the `moni` host with nix-darwin and Home Manager in a
single flake: system and user configurations are declared together and
activated as a pair (`make switch` runs nix-darwin first, then Home Manager).
The User's identity lives once in `userConfig` and is injected into both
outputs via `specialArgs`, so changes touching both layers ship atomically
and identity is never duplicated.

## Status

accepted

## Considered options

- **nix-darwin only, no Home Manager** — rejected: user-level programs
  (neovim, git, …) belong to the user layer.
- **Separate flakes for system and user** — rejected: identity and paired
  activation would have to be duplicated or synced across repos, and a change
  touching both layers could no longer ship atomically.

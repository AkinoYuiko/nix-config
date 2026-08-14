# Repository guide for agents

nix-darwin + Home Manager flake for `momo@moni`. Use the root `Makefile` for all
operations — do not bypass it with raw `darwin-rebuild`, `home-manager switch`,
`nix flake check`, `nix flake update`, or `nix-collect-garbage`.

Full architecture reference: [`docs/architecture.md`](docs/architecture.md).

## Workflow

1. Run `make help` before choosing a command.
2. Edit the smallest appropriate module boundary.
3. Run `make format` after changing Nix files.
4. Run `make check` before reporting completion or creating commits.
5. Activate changes only when the user explicitly requests it.

## Safety

- `make format`, `make check`, and `make flake-check` do **not** activate changes.
- `make darwin-rebuild`, `make home-manager-switch`, and `make switch` mutate the running machine.
- System config: `modules/darwin.nix`. User config: `modules/home.nix` + `modules/programs/`.
- Edit `flake.lock` only through `make flake-update`.
- Preserve `system.stateVersion` and `home.stateVersion` unless the user asks for a version migration.
- After changing the Makefile, verify both `make help` and `make check`.

## Agent skills

### Issue tracker

GitHub Issues via the `gh` CLI. See `docs/agents/issue-tracker.md`.

### Triage labels

Default canonical labels (`needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`). See `docs/agents/triage-labels.md`.

### Domain docs

Single-context — one `CONTEXT.md` + `docs/adr/` at the repo root. See `docs/agents/domain.md`.


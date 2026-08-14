# Machine Configuration

This repository currently manages one macOS Host for one User. The
machine-wide System configuration and the person's Home configuration are
declared together in one place and activated as a pair.

## Language

### Configuration layers

**System configuration**:
The machine-wide configuration layer: OS settings, system packages, fonts,
shells, security, and Homebrew.
_Avoid_: Darwin configuration, macOS configuration

**Home configuration**:
The user-level configuration layer for the User on the managed Host: programs,
dotfiles, and user packages.
_Avoid_: User configuration, dotfiles

### The managed world

**Host**:
A macOS machine managed by this repository. A Host has a Platform and is
paired with the User it serves.
_Avoid_: Machine, computer, device

**User**:
The person this configuration is built for. A User carries the person's
identity (name, full name, email); the OS account is derived from the
User, never declared separately.
_Avoid_: Account, profile, username
_See_: ADR-0001 (identity declared once, injected into both layers)

**Platform**:
The architecture a Host runs on.
_Avoid_: System, architecture

**Theme**:
The shared visual identity of the machine. Program configurations take their
colors from the Theme but own their own behavior and layout.
_Avoid_: Color scheme, everforest

### Configuration units

**Program module**:
A self-contained unit that configures exactly one user program. A Program
module is active only when explicitly enabled.
_Avoid_: Config, dotfile

### Operations

**Build**:
Produce a configuration artifact without changing the running machine.
_Avoid_: Compile

**Activation**:
Apply a built configuration to the running machine.
_Avoid_: Switch, rebuild, install

**Target**:
The Host, or the User on a Host, that an operation applies to.
_Avoid_: Hostname, profile

**Bootstrap**:
First-time setup of a machine: install the package manager and bring the
machine under management.
_Avoid_: Install, setup

**State version**:
The version recorded when a configuration layer was created; it pins
backward-compatible behavior and changes only during an explicit migration.

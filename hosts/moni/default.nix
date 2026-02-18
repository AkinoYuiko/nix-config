{ darwinModules, ... }:
{
  imports = [
    "${darwinModules}/common"
  ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 6;
}

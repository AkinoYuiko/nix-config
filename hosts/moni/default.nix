{
  imports = [ ../../modules/darwin/common ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 7;
}

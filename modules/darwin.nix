{
  pkgs,
  userConfig,
  ...
}:
let
  inherit (userConfig) name;
in
{
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 7;

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    optimise.automatic = true;
  };

  users.users.${name} = {
    inherit name;
    home = "/Users/${name}";
    shell = pkgs.zsh;
  };

  security = {
    pam.services.sudo_local.touchIdAuth = true;
    sudo.extraConfig = "${name} ALL = (ALL) NOPASSWD: ALL";
  };

  system = {
    defaults.CustomUserPreferences = {
      "com.apple.AdLib".allowApplePersonalizedAdvertising = false;
      "com.apple.commerce".AutoUpdate = true;
      "com.apple.desktopservices" = {
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };
      "com.apple.SoftwareUpdate" = {
        AutomaticCheckEnabled = true;
        AutomaticDownload = 1;
        CriticalUpdateInstall = 1;
        ScheduleFrequency = 1;
      };
    };
    primaryUser = name;
  };

  environment.shells = with pkgs; [
    fish
    zsh
  ];
  environment.variables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    ZDOTDIR = "$HOME/.config/zsh";
  };

  fonts.packages = with pkgs; [
    jetbrains-mono
    lxgw-wenkai
    maple-mono.NF-CN
    smiley-sans
  ];

  programs = {
    fish.enable = true;
    zsh.enable = true;
  };

  homebrew = {
    enable = true;
    enableFishIntegration = true;
    global.brewfile = false;
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "none";
    };
  };
}

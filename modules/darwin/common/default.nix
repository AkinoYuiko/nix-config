{
  pkgs,
  userConfig,
  ...
}:
let
  inherit (userConfig) name;
in
{
  imports = [ ../homebrew ];

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

  environment = {
    shells = [ pkgs.fish ];
    systemPackages = with pkgs; [
      curl
      dig
      fd
      ffmpeg
      jq
      nixfmt
      ripgrep
      stylua
      tealdeer
      tirith
      unzip
      wget
      zoxide
    ];
  };

  fonts.packages = with pkgs; [
    jetbrains-mono
    lxgw-wenkai
    maple-mono.NF-CN
    smiley-sans
  ];

  programs.fish.enable = true;
}

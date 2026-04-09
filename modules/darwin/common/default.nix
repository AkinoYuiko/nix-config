{
  pkgs,
  userConfig,
  ...
}:
{
  # Nix settings
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
    };
    optimise.automatic = true;
  };

  # User configuration
  users.users.${userConfig.name} = {
    name = userConfig.name;
    home = "/Users/${userConfig.name}";
  };

  # Add ability to use TouchID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  # Passwordless sudo
  security.sudo.extraConfig = "${userConfig.name}    ALL = (ALL) NOPASSWD: ALL";

  # System settings
  system = {
    # activationScripts.postUserActivation.text = ''
    #   # Following line should allow us to avoid a logout/login cycle
    #   /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    # '';
    defaults = {
      CustomUserPreferences = {
        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.AdLib" = {
          allowApplePersonalizedAdvertising = false;
        };
        "com.apple.SoftwareUpdate" = {
          AutomaticCheckEnabled = true;
          # Check for software updates daily, not just once per week
          ScheduleFrequency = 1;
          # Download newly available updates in background
          AutomaticDownload = 1;
          # Install System data files & security updates
          CriticalUpdateInstall = 1;
        };
        "com.apple.commerce".AutoUpdate = true;
      };
    };
    primaryUser = userConfig.name;
  };

  environment.shells = [ pkgs.fish ];

  environment.systemPackages = with pkgs; [
    curl
    dig
    fd
    jd-diff-patch
    jq
    ripgrep
    tealdeer
    unzip
    wget
    # rust
    (fenix.complete.withComponents [
      "cargo"
      "clippy"
      "rust-analyzer"
      "rust-docs"
      "rust-src"
      "rust-std"
      "rustc"
      "rustfmt"
    ])
  ];
  fonts.packages = with pkgs; [
    maple-mono.NF-CN
    jetbrains-mono
    lxgw-wenkai
    smiley-sans
  ];

  # Enable alternative shell support in nix-darwin.
  programs.fish.enable = true;

  imports = [
    ../homebrew
  ];
}

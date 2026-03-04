{
  userConfig,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../programs/bat
    ../programs/btop
    ../programs/fastfetch
    ../programs/fzf
    ../programs/git
    ../programs/gpg
    ../programs/lazygit
    ../programs/lsd
    ../programs/neovim
    ../programs/starship
    ../programs/tirith
    ../programs/tmux
    ../programs/wezterm
    ../programs/yazi
  ];
  # Nicely reload system units when changing configs
  systemd.user.startServices = lib.mkIf (!pkgs.stdenv.hostPlatform.isDarwin) "sd-switch";
  # Home-Manager configuration for the user's home environment
  home = {
    username = userConfig.name;
    homeDirectory =
      if pkgs.stdenv.hostPlatform.isDarwin then
        "/Users/${userConfig.name}"
      else
        "/home/${userConfig.name}";
  };
  # Ensure common packages are installed
  home.packages = with pkgs; [
    keychain
    # nodejs_latest
    opencode
    pipenv
    python3
    zoxide
  ];

  everforest.enable = true;
}

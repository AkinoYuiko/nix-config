{
  lib,
  pkgs,
  userConfig,
  ...
}:
let
  inherit (userConfig) name;
  isDarwin = pkgs.stdenv.hostPlatform.isDarwin;
in
{
  imports = [
    ../programs/bat
    ../programs/btop
    ../programs/fastfetch
    ../programs/fzf
    ../programs/git
    # ../programs/gpg
    ../programs/lazygit
    ../programs/lsd
    ../programs/neovim
    ../programs/starship
    ../programs/tmux
    ../programs/yazi
  ];

  systemd.user.startServices = lib.mkIf (!isDarwin) "sd-switch";

  xdg.enable = true;

  home = {
    username = name;
    homeDirectory = "${if isDarwin then "/Users" else "/home"}/${name}";
    packages = with pkgs; [
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

  everforest = {
    enable = true;
    contrast = "hard";
  };
}

{
  pkgs,
  userConfig,
  ...
}:
let
  inherit (userConfig) name;
in
{
  imports = [
    ./programs/bat.nix
    ./programs/btop.nix
    ./programs/fastfetch.nix
    ./programs/fzf.nix
    ./programs/git.nix
    # ./programs/gpg.nix
    ./programs/lazygit.nix
    ./programs/lsd.nix
    ./programs/neovim
    ./programs/pi.nix
    ./programs/starship.nix
    ./programs/tmux.nix
    # ./programs/wezterm.nix
    ./programs/yazi.nix
  ];

  programs.home-manager.enable = true;
  home.stateVersion = "26.11";
  home = {
    username = name;
    homeDirectory = "/Users/${name}";
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

  xdg.enable = true;
}

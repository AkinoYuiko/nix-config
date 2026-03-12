{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = false;
    withPython3 = false;
    withRuby = false;
    defaultEditor = true;
    plugins = import ./plugins.nix pkgs;
    extraPackages = import ./packages.nix pkgs;
  };
}

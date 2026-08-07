{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = false;
    withPython3 = false;
    sideloadInitLua = true;
    plugins = import ./plugins.nix pkgs;
    extraPackages = import ./packages.nix pkgs;
  };
}

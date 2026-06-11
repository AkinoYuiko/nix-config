{ pkgs, inputs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = false;
    withPython3 = false;
    defaultEditor = true;
    sideloadInitLua = true;
    plugins = import ./plugins.nix { inherit pkgs inputs; };
    extraPackages = import ./packages.nix pkgs;
  };
}

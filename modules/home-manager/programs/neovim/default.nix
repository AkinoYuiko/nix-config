{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = false;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      neorg
      nvim-treesitter
    ];
    extraPackages = with pkgs; [
      fish-lsp
      nixd
      nixfmt
      nodePackages.bash-language-server
      oxfmt
      oxlint
      shellcheck
      shfmt
      stylua
      tombi
      vscode-langservers-extracted
      yaml-language-server
      # Snacks.image
      ghostscript
      imagemagick
      mermaid-cli
      tectonic
      pkgs.vimPlugins.neorg
    ];
  };
}

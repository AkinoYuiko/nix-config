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
    plugins = [
      pkgs.vimPlugins.neorg
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
      tree-sitter
      vscode-langservers-extracted
      yaml-language-server
      # Snacks.image
      ghostscript
      imagemagick
      mermaid-cli
      tectonic
    ];
  };
}

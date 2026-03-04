{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim;
    viAlias = true;
    vimAlias = true;
    withNodeJs = false;
    withPython3 = false;
    withRuby = false;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      everforest
      snacks-nvim
      mini-nvim
      nvim-autopairs
      conform-nvim
      fidget-nvim
      flash-nvim
      nvim-lspconfig
      (nvim-treesitter.withPlugins (p: [
        p.bash
        p.css
        p.diff
        p.dockerfile
        p.editorconfig
        p.fish
        p.git_config
        p.git_rebase
        p.gitattributes
        p.gitcommit
        p.gitignore
        p.go
        p.html
        p.javascript
        p.json
        p.latex
        p.lua
        p.luadoc
        p.nginx
        p.nix
        p.python
        p.regex
        p.ron
        p.rust
        p.scss
        p.ssh_config
        p.svelte
        p.toml
        p.tsx
        p.typescript
        p.typst
        p.vue
        p.yaml
        p.zig
        p.zsh
      ]))
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
    ];
  };
}

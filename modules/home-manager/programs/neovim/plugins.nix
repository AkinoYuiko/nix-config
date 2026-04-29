pkgs: with pkgs.vimPlugins; [
  everforest
  snacks-nvim
  mini-nvim
  nvim-autopairs
  conform-nvim
  # fidget-nvim
  flash-nvim
  nvim-lspconfig
  {
    plugin = blink-cmp;
    optional = true;
  }
  {
    plugin = nvim-treesitter.withAllGrammars;
    optional = true;
  }
]

pkgs: with pkgs.vimPlugins; [
  everforest
  snacks-nvim
  mini-nvim
  nvim-autopairs
  blink-cmp
  conform-nvim
  # fidget-nvim
  flash-nvim
  {
    plugin = nvim-lspconfig;
    optional = true;
  }
  {
    plugin = nvim-treesitter.withAllGrammars;
    optional = true;
  }
]

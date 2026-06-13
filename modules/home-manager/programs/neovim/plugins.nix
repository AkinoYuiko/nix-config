{ pkgs, inputs }:
let
  codex-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "codex.nvim";
    version = if inputs.codex-nvim ? shortRev then inputs.codex-nvim.shortRev else "unstable";
    src = inputs.codex-nvim;
  };
in
with pkgs.vimPlugins;
[
  everforest
  snacks-nvim
  mini-nvim
  nvim-autopairs
  conform-nvim
  fidget-nvim
  flash-nvim
  nvim-lspconfig
  # {
  #   plugin = blink-cmp;
  #   optional = true;
  # }
  {
    plugin = nvim-treesitter.withAllGrammars;
    optional = true;
  }
  {
    plugin = codex-nvim;
    type = "lua";
    config = ''
      require("codex").setup({
        keymaps = {
          toggle = "<leader>cc",
          quit = "<C-q>",
        },
        border = 'single',
        width = 0.85,
        height = 0.85,
        model = nil,
        autoinstall = false,
        panel = false,
        use_buffer = false,
      })
    '';
  }
]

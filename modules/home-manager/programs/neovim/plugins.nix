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
        keymap = {
          toggle = nil,
          quit = "<c-q>",
        },
        border = 'single',
        width = 0.85,
        height = 0.85,
        panel = true,
        use_buffer = false;
        autoinstall = false;
        model = nil;
      })
      vim.keymap.set({"n","t"},"<leader>o","<cmd>CodexToggle<cr>")
    '';
  }
]

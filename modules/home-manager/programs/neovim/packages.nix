pkgs:
with pkgs;
[
  # emmylua-ls
  lua-language-server
  fish-lsp
  nixd
  bash-language-server
  oxfmt
  oxlint
  shellcheck
  shfmt
  # stylua # remove due to cargo exists
  tombi
  vscode-langservers-extracted
  yaml-language-server
  # Snacks.image
  ghostscript
  imagemagick
  mermaid-cli
  tectonic
]

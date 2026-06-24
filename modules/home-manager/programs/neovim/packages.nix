pkgs:
let
  vscode-json-language-server-node24 = pkgs.writeShellScriptBin "vscode-json-language-server" ''
    cd "${pkgs.vscode-langservers-extracted}/lib/node_modules/vscode-langservers-extracted"
    exec ${pkgs.nodejs_24}/bin/node --input-type=commonjs -e 'process.argv = [process.argv[0], "vscode-json-language-server"].concat(process.argv.slice(1)); require("./lib/json-language-server/node/jsonServerMain.js")' -- "$@"
  '';
in
with pkgs;
[
  # emmylua-ls
  lua-language-server
  fish-lsp
  nixd
  nixfmt
  bash-language-server
  oxfmt
  oxlint
  shellcheck
  shfmt
  stylua
  tombi
  vscode-json-language-server-node24
  vscode-langservers-extracted
  yaml-language-server
  # Snacks.image
  ghostscript
  imagemagick
  mermaid-cli
  tectonic
]

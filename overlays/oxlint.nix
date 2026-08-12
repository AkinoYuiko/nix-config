# nixpkgs builds oxlint from source (pnpm + cargo over the whole oxc monorepo,
# ~500 crates), which takes hours on darwin and is not cached on
# cache.nixos.org, so every `make switch` appears to hang on it.
# Instead, use the prebuilt standalone binary published in the upstream
# GitHub release. Note: it has no `jsPlugins` support (nixpkgs's rationale
# for the from-source build), but plain linting and `--lsp` mode work.
#
# The version is pinned on purpose: bump version and hash together
# (get the hash with `nix-prefetch-url <url>`).
final: prev:
let
  inherit (final) fetchurl lib stdenv;
  version = "1.77.0";
in
{
  oxlint = stdenv.mkDerivation {
    pname = "oxlint";
    inherit version;

    src = fetchurl {
      url = "https://github.com/oxc-project/oxc/releases/download/apps_v${version}/oxlint-aarch64-apple-darwin.tar.gz";
      hash = "sha256-725r1fzzwg65+BIOVZQIolLE/6C6pK+b/xeAxFuOK/Y=";
    };

    dontUnpack = true;

    installPhase = ''
      runHook preInstall
      tar xzf $src
      install -Dm755 oxlint-aarch64-apple-darwin $out/bin/oxlint
      runHook postInstall
    '';

    meta = {
      description = "Collection of JavaScript tools written in Rust (prebuilt binary)";
      homepage = "https://github.com/oxc-project/oxc";
      license = lib.licenses.mit;
      mainProgram = "oxlint";
      platforms = lib.platforms.darwin;
    };
  };
}

{
  config,
  pkgs,
  userConfig,
  ...
}:
let
  generatedBrewfile = pkgs.writeText "Brewfile" config.homebrew.brewfile;
in
{
  homebrew = {
    enable = true;
    enableFishIntegration = true;
    global.brewfile = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };
    brews = [
      "ddns-go"
      {
        name = "nginx";
        restart_service = "changed";
      }
      "node"
      "pi-coding-agent"
      "python@3.13"
    ];
    taps = [
      # "manaflow-ai/cmux"
    ];
    casks = [
      # "codex"
      # "codex-app"
      # "wetype"
      # "cmux"
      "wetype"
    ];
    extraConfig = ''
      npm "@openai/codex"
      npm "mcporter"
    '';
  };

  system.activationScripts.linkGeneratedBrewfile.text = ''
    ln -sfn ${generatedBrewfile} /Users/${userConfig.name}/Brewfile
    chown -h ${userConfig.name}:staff /Users/${userConfig.name}/Brewfile
  '';
}

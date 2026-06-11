{
  homebrew = {
    enable = true;
    enableFishIntegration = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      # cleanup = "zap";
    };
    brews = [
      "ddns-go"
      # "git-flow"
      "nginx"
    ];
    taps = [
      # "manaflow-ai/cmux"
    ];
    casks = [
      "codex"
      # "cmux"
    ];
  };
}

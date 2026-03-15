{ ... }:
{
  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
    brews = [
      "ddns-go"
      # "git-flow"
      "nginx"
    ];
    taps = [
      "manaflow-ai/cmux"
    ];
    casks = [
      "cmux"
    ];
  };
}

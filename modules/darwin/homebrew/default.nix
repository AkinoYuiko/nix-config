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
    casks = [ ];
  };
}

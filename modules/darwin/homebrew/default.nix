{
  homebrew = {
    enable = true;
    enableFishIntegration = true;
    global.brewfile = false;
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "none";
    };
  };
}

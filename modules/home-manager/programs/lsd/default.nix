{
  programs.lsd = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      blocks = [
        "permission"
        "user"
        "size"
        "date"
        "name"
      ];
      date = "+%y-%m-%d %H:%M:%S";
      icons.when = "never";
      literal = true;
      sorting.dir-grouping = "first";
      symlink-arrow = "→";
    };
  };
}

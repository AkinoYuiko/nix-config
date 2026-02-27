{ ... }:
{
  # Install bat via home-manager module
  programs.bat = {
    enable = true;
    config = {
      pager = "less --RAW-CONTROL-CHARS --quit-if-one-screen --mouse";
      style = "plain";
      tabs = "2";
    };
  };

  # catppuccin.bat.enable = true;
}

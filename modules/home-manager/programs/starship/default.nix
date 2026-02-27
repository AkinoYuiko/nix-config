{ ... }:
{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      palette = "everforest_dark_hard";
      format = "$username$directory$git_branch$git_state$git_status$cmd_duration$line_break$python$character";
      add_newline = false;
      scan_timeout = 2000;
      username.format = "[$user]($style) ";
      directory.style = "blue";
      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](green)";
      };
      git_branch = {
        format = "[$branch]($style)";
        style = "bright-black";
      };
      git_status = {
        format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](218) ($ahead_behind$stashed)]($style)";
        style = "cyan";
        conflicted = "​";
        untracked = "​";
        modified = "​";
        staged = "​";
        renamed = "​";
        deleted = "​";
        stashed = "≡";
      };
      git_state = {
        format = "[$state( $progress_current/$progress_total)]($style)";
        style = "bright-black";
      };
      cmd_duration = {
        format = "[$duration]($style) ";
        style = "yellow";
      };
      python = {
        format = "[$virtualenv]($style) ";
        style = "bright-black";
        detect_extensions = [ ];
        detect_files = [ ];
      };
      palettes = {
        everforest_dark_hard = {
          bg0 = "#272e33";
          bg1 = "#2e383c";
          bg2 = "#374145";
          bg3 = "#414b50";
          bg4 = "#495156";

          fg = "#d3c6aa";
          fg_dim = "#9da9a0";

          red = "#e67e80";
          orange = "#e69875";
          yellow = "#dbbc7f";
          green = "#a7c080";
          aqua = "#83c092";
          blue = "#7fbbb3";
          purple = "#d699b6";
          grey = "#859289";
        };
      };
    };
  };
  # Enable catppuccin theming for starship.
  # catppuccin.starship.enable = true;
}

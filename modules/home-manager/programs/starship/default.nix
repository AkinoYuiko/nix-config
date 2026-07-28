{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";

      add_newline = false;
      format = "$directory$os$git_branch$git_status$nodejs$rust$golang$php $character";

      os = {
        disabled = false;
        style = "grey2";
        format = "[$symbol]($style) ";
        symbols = {
          Alpine = "";
          Arch = "󰣇";
          Artix = "󰣇";
          CachyOS = "󰣇";
          Debian = "";
          Macos = "";
          Ubuntu = "󰕈";
        };
      };

      directory = {
        style = "aqua";
        read_only_style = "orange";
        format = "[$path]($style)[$read_only]($read_only_style) ";
        truncation_length = 4;
        truncate_to_repo = true;
      };

      git_branch = {
        symbol = "";
        format = "[$symbol $branch](bold blue) ";
      };

      git_status = {
        format = "($ahead_behind$staged$modified$untracked$deleted$conflicted)";
        ahead = "[⇡$count ](bold green)";
        behind = "[⇣$count ](bold green)";
        diverged = "[⇡$ahead_count⇣$behind_count ](bold blue)";
        staged = "[+$count ](bold purple)";
        modified = "[●$count ](bold purple)";
        untracked = "[?$count ](bold yellow)";
        deleted = "[✘$count ](bold red)";
        conflicted = "[⚡$count ](bold red)";
      };

      nodejs = {
        symbol = "";
        format = "[$symbol $version](grey1) ";
      };

      rust = {
        symbol = "";
        format = "[$symbol $version](grey1) ";
      };

      golang = {
        symbol = "";
        format = "[$symbol $version](grey1) ";
      };

      php = {
        symbol = "";
        format = "[$symbol $version](grey1) ";
      };

      character = {
        success_symbol = "[❯](statusline2)";
        error_symbol = "[❯](statusline3)";
        vimcmd_symbol = "[❮](statusline2)";
      };
    };
  };
}

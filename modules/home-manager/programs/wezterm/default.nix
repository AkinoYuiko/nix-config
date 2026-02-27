{ ... }:
{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
      	font = wezterm.font_with_fallback({"Maple Mono","JetBrains Mono"}),
      	font_size = 14.0,
      	enable_tab_bar = false,
      	window_decorations = "RESIZE",
      	window_close_confirmation = "NeverPrompt",
      	color_scheme = "Everforest Dark Hard (Gogh)",
        -- color_scheme = "Catppuccin Mocha",
        initial_cols = 150,
        initial_rows = 40,
      	keys = {
      		{
      			key = "w",
      			mods = "CMD",
      			action = wezterm.action.CloseCurrentTab({ confirm = false }),
      		},
      	},
      }
    '';
  };
}

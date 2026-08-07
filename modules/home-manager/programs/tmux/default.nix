{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    escapeTime = 10;
    historyLimit = 10000;
    keyMode = "vi";
    mouse = true;
    sensibleOnTop = false;
    terminal = "tmux-256color";
    extraConfig = ''
      # Enable extended key reporting for modified Enter keys
      set -g extended-keys on
      set -g extended-keys-format csi-u

      # Set the prefix to `ctrl + q` instead of `ctrl + b`
      set -g prefix C-q
      unbind C-b

      # Use | and - to split a window vertically and horizontally instead of " and % respectively
      unbind '"'
      unbind %
      bind v split-window -h -c "#{pane_current_path}"
      bind s split-window -v -c "#{pane_current_path}"

      # Bind Arrow keys to resize the window
      bind -n S-Down resize-pane -D 8
      bind -n S-Up resize-pane -U 8
      bind -n S-Left resize-pane -L 8
      bind -n S-Right resize-pane -R 8

      # Rename window with prefix + r
      bind r command-prompt -I "#W" "rename-window '%%'"

      # Reload tmux config by pressing prefix + R
      bind R source-file ~/.config/tmux/tmux.conf \; display "TMUX Conf Reloaded"

      # Clear screen with prefix + l
      bind C-l send-keys 'C-l'

      # Open a project in a separate window (disabled)
      # bind-key -n C-f run-shell "tmux new-window -t 10 -n project-selector cd-to-project"

      # Enable focus-events
      set -g focus-events on

      # Smart pane switching with awareness of Vim splits
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf|atuin)(diff)?$'"
      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l' 'if-shell "[ #{window_panes} -gt 1 ]" "select-pane -R" "send-keys C-l"'

      bind-key -T copy-mode-vi 'C-h' select-pane -L
      bind-key -T copy-mode-vi 'C-j' select-pane -D
      bind-key -T copy-mode-vi 'C-k' select-pane -U
      bind-key -T copy-mode-vi 'C-l' select-pane -R

      set-option -g renumber-windows on

      # Refresh status-line time periodically
      set -g status-interval 2

      # Tmux behavior and status-line layout are owned by this personal configuration.
      # Everforest color values and color-only styles come from the theme module.
      set -as terminal-features ',xterm-256color:RGB'
      set -g status on

      set -g status-left-style none
      set -g status-left-length 60
      set -g status-left '#[fg=#{@everforest_bg_dim},bg=#{@everforest_green},bold] #S #[fg=#{@everforest_green},bg=#{@everforest_bg2},nobold]#[fg=#{@everforest_green},bg=#{@everforest_bg2},bold] #(whoami) #[fg=#{@everforest_bg2},bg=#{@everforest_bg0},nobold]'

      set -g status-right-style none
      set -g status-right-length 150
      set -g status-right '#[fg=#{@everforest_bg2}]#[fg=#{@everforest_fg},bg=#{@everforest_bg2}] %m-%d %H:%M #[fg=#{@everforest_aqua},bg=#{@everforest_bg2},bold]#[fg=#{@everforest_bg_dim},bg=#{@everforest_aqua},bold] #h '

      set -g window-status-separator '#[fg=#{@everforest_grey2},bg=#{@everforest_bg0}] '
      set -g window-status-format '#[fg=#{@everforest_grey0},bg=#{@everforest_bg0}] #I  #[fg=#{@everforest_grey0},bg=#{@everforest_bg0}]#W '
      set -g window-status-current-format '#[fg=#{@everforest_bg0},bg=#{@everforest_bg_green}]#[fg=#{@everforest_fg},bg=#{@everforest_bg_green}] #I  #[fg=#{@everforest_fg},bg=#{@everforest_bg_green},bold]#W #[fg=#{@everforest_bg_green},bg=#{@everforest_bg0},nobold]'
    '';
  };
}

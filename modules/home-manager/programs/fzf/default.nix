{
  programs.fzf = {
    enable = true;

    defaultCommand = "fd --type f --hidden --strip-cwd-prefix";
    defaultOptions = [
      "--height=60%"
      "--layout=reverse"
      "--border=rounded"
      "--prompt='  '"
      "--pointer='  '"
      "--preview-window=right:65%:wrap:border-left"
    ];

    fileWidget = {
      command = "fd --type f --hidden --strip-cwd-prefix";
      options = [
        "--preview 'bat --color=always --style=plain,numbers --line-range=:500 {}'"
      ];
    };
  };
}

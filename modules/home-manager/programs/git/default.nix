{ userConfig, ... }:
{
  # Install git via home-manager module
  programs.git = {
    enable = true;
    settings = {
      user = {
        email = userConfig.email;
        name = userConfig.fullName;
      };
      core = {
        autocrlf = "input";
      };
      init.defualtBranch = "main";
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      };
      # pull.rebase = true;
    };
    signing = {
      # key = userConfig.gitKey;
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
    };
    ignores = [
      ".DS_Store"
      "local-*"
      "local.*"
    ];
  };

  # programs.delta = {
  #   enable = true;
  #   enableGitIntegration = true;
  #   options = {
  #     keep-plus-minus-markers = true;
  #     light = false;
  #     line-numbers = true;
  #     navigate = true;
  #     width = 280;
  #   };
  # };
}

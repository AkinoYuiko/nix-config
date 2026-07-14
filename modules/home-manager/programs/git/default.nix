{
  pkgs,
  userConfig,
  ...
}:
let
  credentialHelper = [
    ""
    "!${pkgs.gh}/bin/gh auth git-credential"
  ];
in
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        inherit (userConfig) email;
        name = userConfig.fullName;
      };
      core.autocrlf = "input";
      init.defaultBranch = "main";
      credential = {
        "https://github.com".helper = credentialHelper;
        "https://gist.github.com".helper = credentialHelper;
      };
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      };
    };
    signing = {
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
    };
    ignores = [
      ".DS_Store"
      "local-*"
      "local.*"
    ];
  };
}

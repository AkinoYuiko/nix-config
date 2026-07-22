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
    };
    signing = {
      signByDefault = true;
    };
    ignores = [
      ".DS_Store"
    ];
  };
}

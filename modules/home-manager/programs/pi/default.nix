{ pkgs, ... }:
{
  home.file = {
    ".pi/agent/bin/gh".source = "${pkgs.gh}/bin/gh";
    ".pi/agent/bin/jq".source = "${pkgs.jq}/bin/jq";
    ".pi/agent/bin/rg".source = "${pkgs.ripgrep}/bin/rg";
    ".pi/agent/bin/shellcheck".source = "${pkgs.shellcheck}/bin/shellcheck";
    ".pi/agent/bin/actionlint".source = "${pkgs.actionlint}/bin/actionlint";
    ".pi/agent/bin/oxfmt".source = "${pkgs.oxfmt}/bin/oxfmt";
    ".pi/agent/bin/oxlint".source = "${pkgs.oxlint}/bin/oxlint";
  };
}

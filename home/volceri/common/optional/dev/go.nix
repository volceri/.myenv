{ pkgs, ... }:
{
  home.sessionVariables.GOPRIVATE = "git.naspersclassifieds.com";

  home.packages = [
    pkgs.golangci-lint
  ];
}

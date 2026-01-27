{ pkgs, ... }:
{
  programs.go = {
    enable = true;
    env.GOPRIVATE = [
      "git.naspersclassifieds.com"
    ];
  };

  home.packages = [
    pkgs.golangci-lint
  ];
}

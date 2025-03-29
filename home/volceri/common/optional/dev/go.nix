{ ... }: {
  programs.go = {
    enable = true;
    goPrivate = [
        "git.naspersclassifieds.com"
    ];
  };
}

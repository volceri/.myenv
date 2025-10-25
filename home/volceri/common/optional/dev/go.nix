{ ... }: {
  programs.go = {
    enable = true;
    # env.GOPRIVATE = [
    #     "git.naspersclassifieds.com"
    # ];
    goPrivate = [
        "git.naspersclassifieds.com"
    ];
  };
}

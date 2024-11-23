{ pkgs, ... }: {
  home.packages = with pkgs; [
    nerdfonts
    powerline
    fira-code
    fira-code-symbols
    fira-code-nerdfont
    font-manager
    font-awesome_5
    noto-fonts
  ];
}

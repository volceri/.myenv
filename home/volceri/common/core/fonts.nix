{ pkgs, ... }: {
  home.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.inconsolata-go
    nerd-fonts.inconsolata
    powerline
    fira-code-symbols
    font-manager
    font-awesome_5
    noto-fonts
  ];
}

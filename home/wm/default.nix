{ pkgs, ... }: {
  imports = [
    ./fonts.nix
    # ./lxqt-x11.nix
  ];

  home.packages = with pkgs; [
  ];
}

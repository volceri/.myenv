{ pkgs, ... }: {
  imports = [
    ./fonts.nix
    ./dbus.nix
    ./lxqt-x11.nix
  ];

  home.packages = with pkgs; [
  ];
}

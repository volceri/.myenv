{  pkgs, lib, ... }: {
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    niri
    xwayland-satellite
  ];

  xdg.portal = {
    enable = true;
    config = {
      niri = {
        default = lib.mkForce [ "wlr" "gtk" ];
        # Explicitly set wlr for screen capture/sharing
        "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
      };
    };
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr  # Essential for screen sharing in wlroots compositors
      xdg-desktop-portal-gtk
    ];
    xdgOpenUsePortal = true;
    wlr.enable = true;  # Explicitly enable wlr portal for wlroots compositors
  };
}
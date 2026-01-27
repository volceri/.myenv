{ pkgs, ... }:
{
  services.desktopManager.plasma6.enable = true;

  # Enable xdg-desktop-portal for Plasma/KDE
  # Required for calendar sync and other desktop integrations in Zoom
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
    config = {
      common = {
        default = [ "kde" ];
      };
    };
  };
}

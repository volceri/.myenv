{ pkgs, inputs, ... }:
let
  zoomPkgs = import inputs.nixpkgs-zoom {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };

  # Use base zoom package that auto-detects XDG portals
  # Will use KDE portal in Plasma sessions and wlr portal in Niri sessions
  # based on our xdg.portal.config settings
  zoom-with-portal = zoomPkgs.zoom-us;
in
{
  home.packages = [
    pkgs.zoom-us
  ];
}

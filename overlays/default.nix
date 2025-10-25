#
# This file defines overlays/custom modifications to upstream packages
#
{ inputs, ... }:

let
  pipewire-zoom = inputs.nixpkgs-zoom.legacyPackages.x86_64-linux.pipewire;

  # Adds my custom packages
  # FIXME: Add per-system packages
  additions =
    final: prev:
    (prev.lib.packagesFromDirectoryRecursive {
      callPackage = prev.lib.callPackageWith final;
      directory = ../pkgs/common;
    });

  linuxModifications = final: prev: prev.lib.mkIf final.stdenv.isLinux { };

  # alacrittyTheme = final: prev: {
  #   alacritty-theme2 = inputs.alacritty-theme.overlays;
  # };

  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: let ... in {
    # ...
    # });
    #    flameshot = prev.flameshot.overrideAttrs {
    #      cmakeFlags = [
    #        (prev.lib.cmakeBool "USE_WAYLAND_GRIM" true)
    #        (prev.lib.cmakeBool "USE_WAYLAND_CLIPBOARD" true)
    #      ];
    #    };
    
    #  zoom-us = (prev.zoom-us.override { pipewire = pipewire-zoom; }).overrideAttrs (old: {
    #     src = prev.fetchurl {
    #       url = "https://zoom.us/client/6.0.2.4680/zoom_x86_64.pkg.tar.xz";
    #       hash = "sha256-027oAblhH8EJWRXKIEs9upNvjsSFkA0wxK1t8m8nwj8=";
    #     };
    #   });
    #  zoom-us = (prev.zoom-us.override { pipewire = pipewire-zoom; }).overrideAttrs (old: {
    #     src = prev.fetchurl {
    #       url = "https://zoom.us/client/6.3.10.7150/zoom_x86_64.pkg.tar.xz";
    #       hash = "sha256-027oAblhH8EJWRXKIEs9upNvjsSFkA0wxK1t8m8nwj8=";
    #     };
    #   });
    #  zoom-us = (prev.zoom-us.override { pipewire = pipewire-zoom; });
    
    # Use newer GoLand from unstable while keeping everything else stable
    jetbrains = prev.jetbrains // {
      goland = final.unstable.jetbrains.goland;
      phpstorm = final.unstable.jetbrains.phpstorm;
    };
  };

  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      inherit (final) system;
      config.allowUnfree = true;
      #      overlays = [
      #     ];
    };
  };

  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      inherit (final) system;
      config.allowUnfree = true;
      #      overlays = [
      #     ];
    };
  };

in
{
  default =
    final: prev:

    (additions final prev)
    // (modifications final prev)
    // (linuxModifications final prev)
    // (stable-packages final prev)
    // (unstable-packages final prev)
    ;
}
{ config
, lib
, pkgs
, outputs
, configLib
, configVars
, ...
}: {
  imports = (configLib.scanPaths ./.) ;

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  programs = {
    home-manager.enable = true;
  };

  home = {
    stateVersion = "24.05";
  };

}

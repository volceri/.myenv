{ config
, lib
, pkgs
, outputs
, configLib
, configVars
, ...
}: {
  imports = (configLib.scanPaths ./.) ;

  programs = {
    home-manager.enable = true;
  };

  home = {
    stateVersion = "24.05";
  };

}

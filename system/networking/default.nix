{ pkgs, systemSettings, ... }: {

  networking = {
    hostName = systemSettings.hostname;
    networkmanager.enable = true;
  };

  programs.nm-applet.enable = true;
}

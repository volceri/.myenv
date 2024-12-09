{ pkgs, configVars, ... }: {

  networking = {
    hostName = configVars.systemSettings.hostname;
    networkmanager.enable = true;
  };

  programs.nm-applet.enable = true;
}

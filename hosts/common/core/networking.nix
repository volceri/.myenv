{ pkgs, configVars, ... }: {

  networking = {
    hostName = sconfigVars.systemSettings.hostname;
    networkmanager.enable = true;
  };

  programs.nm-applet.enable = true;
}

{ pkgs, configVars, ... }:
{

  imports = [
    #################### Required Configs ####################
    common/core # required

    #################### Host-specific Optional Configs ####################
    common/optional/browsers/chromium.nix
    # common/optional/desktops # default is hyprland
    # common/optional/comms
    # common/optional/helper-scripts
    # common/optional/media
    # common/optional/tools

    # common/optional/atuin.nix
    # common/optional/xdg.nix # file associations
    # common/optional/sops.nix
  ];

  home = {
    username = configVars.userSettings.username;
    homeDirectory = "/home/" + configVars.userSettings.username;
    file = { };
    sessionVariables = {
      VISUAL = "nvim";
      EDITOR = "nvim";
    };

    packages = with pkgs; [
    ];
  };
}

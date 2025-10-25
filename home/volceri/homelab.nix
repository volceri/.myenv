{ pkgs, configVars, ... }:
{

  imports = [
    #################### Required Configs ####################
    common/core # required

    #################### Host-specific Optional Configs ####################
    common/optional/editors/vscode.nix
    common/optional/editors/drawio.nix

    common/optional/cli/bat.nix
    common/optional/cli/fzf.nix
    common/optional/cli/zsh.nix
    common/optional/cli/bash.nix
    common/optional/cli/aliases.nix
#     common/optional/cli/aliases_work.nix
    common/optional/cli/starship.nix

    common/optional/terminal/kitty.nix

#     common/optional/comms/slack.nix
#     common/optional/comms/zoom.nix

    common/optional/dev/direnv.nix
    common/optional/dev/go.nix
    common/optional/dev/rust.nix
    common/optional/dev/python.nix
    common/optional/dev/postman.nix
    common/optional/dev/dbeaver.nix

    # common/optional/desktops # default is hyprland
    # common/optional/comms
    # common/optional/helper-scripts
    # common/optional/media
    # common/optional/tools

    # common/optional/atuin.nix
    # common/optional/xdg.nix # file associations
    # common/optional/sops.nix
    common/optional/stylix
  ];

  home = {
    username = configVars.userSettings.username;
    homeDirectory = "/home/" + configVars.userSettings.username;
    file = { };

    sessionVariables = {
      VISUAL = "nvim";
      EDITOR = "nvim";
      SHELL = "zsh";
      TERM = "kitty";
      TERMINAL = "kitty";
    };

    packages = with pkgs; [
      docker-compose
      lsof
      inetutils
      # notepadqq
    ];

     preferXdgDirectories = true; # whether to make programs use XDG directories whenever supported
  };

}

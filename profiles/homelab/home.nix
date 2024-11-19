{ config, pkgs, userSettings, ... }:

{
  imports = [
    ../../home/wm
    ../../home/features/shell
    ../../home/features/git/git.nix
    ../../home/features/editors/vscode.nix
  ];

  features = {
    shell = {
      fzf.enable = true;
      shellAliases.enable = true;
    };

    git = {
      git.enable = true;
    };

    editors = {
      vscode.enable = true;
    };

    # wm = {
    #   lxqt-x11.enable = true;
    # };
  };

  home.stateVersion = "24.05";
  home.username = userSettings.username;
  home.homeDirectory = "/home/" + userSettings.username;
  home.packages = (with pkgs; [ ]);
  home.file = { };
  home.sessionVariables = { };
  programs.home-manager.enable = true;
}

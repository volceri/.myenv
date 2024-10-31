{ config, pkgs, ... }:

{
    imports = [
        ../../user/shell/sh.nix     
        ../../user/app/git/git.nix # My git config
    ];
    
    programs.home-manager.enable = true;

    home.stateVersion = "24.05"; # Please read the comment before changing.
    home.username = userSettings.username;
    home.homeDirectory = "/home/"+userSettings.username;   
    home.packages = [ git ];
    home.file = {};
    home.sessionVariables = {};
}

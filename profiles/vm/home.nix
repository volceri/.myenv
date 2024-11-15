{ config, pkgs, userSettings, ... }:

{
    imports = [
        ../../user/shell/sh.nix     
        ../../user/app/git/git.nix # My git config
	../../user/app/editors/vscode.nix
    ];
    
    programs.home-manager.enable = true;

    home.stateVersion = "24.05"; # Please read the comment before changing.
    home.username = userSettings.username;
    home.homeDirectory = "/home/"+userSettings.username;   
    home.packages = (with pkgs; [ 
        git 
    ]);
    home.file = {};
    home.sessionVariables = {};
}

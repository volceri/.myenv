{ pkgs, config, lib, configVars, configLib,... }: {
    
    stylix.autoEnable = false;
    stylix.enable = true ;
    stylix.image = (configLib.relativeToRoot "assets/wallpapers/a_group_of_tall_buildings_with_clouds_in_the_sky.png");
    # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/horizon-dark.yaml";
    # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/ashes.yaml";
    # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-dark.yaml";
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/classic-dark.yaml";
    # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/circus.yaml";
    # stylix.image = "/home/volceri/Pictures/wallpapers/wallpapers/apeiros/a_group_of_tall_buildings_with_clouds_in_the_sky.png";

    stylix.targets.kitty.enable = true;
    
    #VS Code
    stylix.targets.vscode.enable = true;
    
    programs.vscode.profiles.default.userSettings = {
        "editor.fontSize" = lib.mkForce 12;
        "workbench.tree.indent" = lib.mkForce 14;
        "workbench.tree.renderIndentGuides" = lib.mkForce "always";
        "debug.console.fontSize" = lib.mkForce 12;
        "files.autoSave" = lib.mkForce "afterDelay";
        "terminal.integrated.fontSize" = lib.mkForce 12;
        "scm.inputFontSize" = lib.mkForce 12;
        "git.confirmSync" = lib.mkForce false;
    };

    stylix.targets.neovim.enable = true;
    stylix.targets.bat.enable = true;
    stylix.targets.starship.enable = true;
    stylix.targets.fzf.enable = true;    
    
    stylix.targets.btop.enable = true;

    stylix.targets.xresources.enable = true;    
    stylix.targets.kde.enable = false;
}

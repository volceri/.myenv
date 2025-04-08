{ pkgs, config,  configVars, configLib,... }: {
    
    stylix.autoEnable = false;
    stylix.enable = true ;
    # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/horizon-dark.yaml";
    # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/ashes.yaml";
    # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-dark.yaml";
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/classic-dark.yaml";
    # stylix.image = "/home/volceri/Pictures/wallpapers/wallpapers/apeiros/a_group_of_tall_buildings_with_clouds_in_the_sky.png";
    stylix.image = (configLib.relativeToRoot "assets/wallpapers/a_group_of_tall_buildings_with_clouds_in_the_sky.png");

    stylix.targets.kitty.enable = true;
    stylix.targets.vscode.enable = true;
    stylix.targets.neovim.enable = true;
    stylix.targets.bat.enable = true;
    stylix.targets.starship.enable = true;
    stylix.targets.fzf.enable = true;    
    stylix.targets.xresources.enable = true;    
    stylix.targets.kde.enable = false;
}

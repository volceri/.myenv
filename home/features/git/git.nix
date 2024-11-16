{ config, lib, userSettings, ... }: with lib;
let
  cfg = config.features.git.git;

in
{
  options.features.git.git.enable = mkEnableOption "enable git";

  config = mkIf cfg.enable {

    home.packages = with pkgs; [
      git
    ];

    programs.git.enable = true;
    programs.git.userName = userSettings.name;
    programs.git.userEmail = userSettings.email;
    programs.git.extraConfig = {
      init.defaultBranch = "main";
    };
  };
}

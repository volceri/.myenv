{ pkgs

, config
, lib
, configVars
, configLib
, inputs
, ...
}:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  # Import this user's personal/home configurations
  home-manager.users.${configVars.userSettings.username} = import (
    configLib.relativeToRoot "home/${configVars.userSettings.username}/${configVars.systemSettings.profile}.nix"
  );

  # users.mutableUsers = false;
  users.users.${configVars.userSettings.username} = {
    isNormalUser = true;
    description = configVars.userSettings.name;
    extraGroups =
      [ "wheel" "networkmanager" ]
      ++ ifTheyExist [
        "audio"
        "video"
        "docker"
        "git"
        "mysql"
        "scanner" # for print/scan"
        "lp" # for print/scan"
      ];

      packages = with pkgs; [ 
        pkgs.home-manager

      ] ++ [
#         inputs.nix-aws-okta.packages.${system}.default
      ]
      ;

      # shell = pkgs.zsh; # default shell

    # openssh.authorizedKeys.keys = lib.splitString "\n" (builtins.readFile ../../../../home/gabriel/ssh.pub);
    # hashedPasswordFile = config.sops.secrets.gabriel-password.path;
  };

}

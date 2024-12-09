{ pkgs
, config
, lib
, configVars
, ...
}:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  # users.mutableUsers = false;
  users.users.${configVars.userSettings.username} = {
    isNormalUser = true;
    description = configVars.userSettings.name;
    extraGroups =
      [ "wheel" ]
      ++ ifTheyExist [
        "audio"
        "video"
        "docker"
        "git"
        "mysql"
        "networkmanager"
        "scanner" # for print/scan"
        "lp" # for print/scan"
      ];

     packages = with pkgs; [ ];

    # openssh.authorizedKeys.keys = lib.splitString "\n" (builtins.readFile ../../../../home/gabriel/ssh.pub);
    # hashedPasswordFile = config.sops.secrets.gabriel-password.path;
  };

  # home-manager.users.gabriel = import ../../../../home/gabriel/${config.networking.hostName}.nix;
}

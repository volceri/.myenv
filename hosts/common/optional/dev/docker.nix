{ pkgs, lib, configVars, ... }:

{
  # virtualisation.docker.rootless = {
  #   enable = true;
  #   setSocketVariable = true;
  #   daemon.settings = {
  #      "dns" = ["192.168.86.1"  "8.8.8.8"  "4.4.4.4"];
  #   };
  # };


  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
    # extraOptions = 
    # ''--add-host host.docker.internal:host-gateway'';
  };

  users.users.${configVars.userSettings.username}.extraGroups = [ "docker" ];
  environment.systemPackages = with pkgs; [
    # docker
    lazydocker
  ];
}
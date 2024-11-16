{ pkgs, lib, systemSettings, userSettings, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../common
    ../../system/networking
    ../../system/ssh
    ../../system/audio/pipewire.nix
    ../../system/security/gpg.nix
  ];

  system.stateVersion = "24.05"; # Did you read the comment?

  # Bootloader.
  boot = {
    loader = {
      systemd-boot = {
        #enable = if (systemSettings.bootMode == "uefi") then true else false;
        enable = false;
      };
      efi = {
        canTouchEfiVariables = if (systemSettings.bootMode == "uefi") then true else false;
        efiSysMountPoint = systemSettings.bootMountPath; # does nothing if running bios rather than uefi
      };
      grub = {
        #enable = if (systemSettings.bootMode == "uefi") then false else true;
        enable = true;
        device = systemSettings.grubDevice;
        useOSProber = true;
      };
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "networkmanager" "wheel" ];
    uid = 1000;
    packages = with pkgs; [ ];
  };

  features = {
    audio = {
      pipewire.enable = true;
    };
  };

}

{ inputs
, lib
, configVars
, configLib
, pkgs
, ...
}:
{
  imports = lib.flatten [
    #################### Every Host Needs This ####################
    ./hardware-configuration.nix

    #################### Hardware Modules ####################

    #################### Disk Layout ####################

    #################### Misc Inputs ####################

    (map configLib.relativeToRoot [
      #################### Required Configs ####################
      "hosts/common/core"

      #################### Host-specific Optional Configs ####################
      "hosts/common/optional/services/openssh.nix" # allow remote SSH access
      "hosts/common/optional/services/xserver.nix"

      #################### Display Manager ####################
      "hosts/common/optional/lightdm.nix"

      #################### Desktop ####################
      "hosts/common/optional/lxqt.nix" #Desktop Environment
    ])
  ];

  system.stateVersion = "24.05"; # Did you read the comment?
  
  # Bootloader.
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi = {
        canTouchEfiVariables = true;
        # efiSysMountPoint = "/boot";
      };
      grub = {
        #enable = if (systemSettings.bootMode == "uefi") then false else true;
        enable = false;
        # device = "/dev/sda";
        # useOSProber = true;
      };
    };
  };

}

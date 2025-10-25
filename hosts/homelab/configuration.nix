{ inputs
, lib
, configVars
, configLib
, pkgs
, alacritty-theme
, ...
}:
{
  # HOMELAB
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
      "hosts/common/optional/services/printing.nix"
      "hosts/common/optional/services/flatpak.nix"

      #################### Display Manager ####################
      "hosts/common/optional/sddm.nix"

      #################### Desktop ####################
      "hosts/common/optional/plasma6.nix" #Desktop Environment


      #Dev
      "hosts/common/optional/dev/go.nix"
      "hosts/common/optional/dev/docker.nix"
      "hosts/common/optional/dev/mysql.nix"

      #Tools
      "hosts/common/optional/tools/kalc.nix"
      "hosts/common/optional/tools/korganizer.nix"
    ])
  ];

/*
  # Force home-manager to use global packages
  home-manager.useGlobalPkgs = true;
 */

  # If there is a conflict file that is backed up, use this extension
  home-manager.backupFileExtension = "bkp";


  programs.firefox.enable = true;

  system.stateVersion = "24.11"; # Did you read the comment?

  # Bootloader.
  boot = {
    loader = {
      systemd-boot = {
        enable = false;
      };
#       efi = {
#         canTouchEfiVariables = true;
#         #efiSysMountPoint = "/boot";
#       };
      grub = {
        enable = true;
#         efiSupport = true;
        device = "/dev/sda";
        useOSProber = true;

        extraEntries            = ''
          submenu "Power Options" {
            menuentry "Reboot" {
              reboot
            }
            menuentry "Poweroff" {
              halt
            }
            menuentry "UEFI Firmware Settings" {
              fwsetup
            }
          }
          '';
      };
    };
  };


  networking.extraHosts =
  ''
    127.0.0.1 host.docker.internal
  '';
  stylix.enable = true ;
  stylix.autoEnable = false;

  stylix.targets.grub.enable = false;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/classic-dark.yaml";
}

{ inputs
, lib
, configVars
, configLib
, pkgs
, alacritty-theme
, ...
}:
{
  # WORK
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
      "hosts/common/optional/services/appimage.nix"

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
    ])
  ];

/*
  # Force home-manager to use global packages
  home-manager.useGlobalPkgs = true;
 */
 
  # If there is a conflict file that is backed up, use this extension
  home-manager.backupFileExtension = "backup";


  programs.firefox.enable = true;

  system.stateVersion = "24.11"; # Did you read the comment?
  
  # Bootloader.
  boot = {
    loader = {
      systemd-boot = {
        enable = false;
      };
      efi = {
        canTouchEfiVariables = true;
        #efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        efiSupport = true;
        devices = [ "nodev" ];
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
    127.0.0.1 local.stg.standvirtual.com mystandvirtual.pt
    127.0.0.1 local.stg.otomoto.pl myotomoto.pl
    127.0.0.1 myautovit.ro host.docker.internal myfake-apollo.com
    192.168.86.58 lisbon
  '';


  services.fprintd = {
    enable = true;
  };

  stylix.enable = true ;
  stylix.autoEnable = false;
  
  stylix.targets.grub.enable = false;
  # stylix.image = (configLib.relativeToRoot "assets/wallpapers/a_group_of_tall_buildings_with_clouds_in_the_sky.png");

  # # stylix.autoEnable = false;
  #   # stylix.enable = true ;
  #   # stylix.image = (configLib.relativeToRoot "assets/wallpapers/a_group_of_tall_buildings_with_clouds_in_the_sky.png");
  #   # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/horizon-dark.yaml";
  #   # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
  #   # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/ashes.yaml";
  #   # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-dark.yaml";
  #   # stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/classic-dark.yaml";
  #   stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/circus.yaml";
  #   # stylix.image = "/home/volceri/Pictures/wallpapers/wallpapers/apeiros/a_group_of_tall_buildings_with_clouds_in_the_sky.png";

  #   stylix.targets.kitty.enable = true;
    
  #   #VS Code
  #   stylix.targets.vscode.enable = true;
    
  #   stylix.targets.neovim.enable = true;
  #   # stylix.targets.bat.enable = true;
  #   stylix.targets.starship.enable = true;
  #   # stylix.targets.fzf.enable = true;    
    
  #   # stylix.targets.btop.enable = true;

  #   stylix.targets.xresources.enable = true;    
  #   stylix.targets.kde.enable = false;

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/circus.yaml";
}

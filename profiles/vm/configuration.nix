{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../../hardware-configuration.nix
      ../../system/security/gpg.nix
    ];

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
  
    networking = {
        hostName = systemSettings.hostname; # Define your hostname.
        networkmanager.enable = true; # Use networkmanager
    };

    # Enable network manager applet
    programs.nm-applet.enable = true;

    # Timezone and locale
    time.timeZone = systemSettings.timezone; # time zone
    i18n.defaultLocale = systemSettings.locale;
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "pt_PT.UTF-8";
        LC_IDENTIFICATION = "pt_PT.UTF-8";
        LC_MEASUREMENT = "pt_PT.UTF-8";
        LC_MONETARY = "pt_PT.UTF-8";
        LC_NAME = "pt_PT.UTF-8";
        LC_NUMERIC = "pt_PT.UTF-8";
        LC_PAPER = "pt_PT.UTF-8";
        LC_TELEPHONE = "pt_PT.UTF-8";
        LC_TIME = "pt_PT.UTF-8";
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.${userSettings.username} = {
        isNormalUser = true;
        description = userSettings.name;
        extraGroups = [ "networkmanager" "wheel" ];
        uid = 1000;
        packages = with pkgs; [     ];
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search, run:
    environment.systemPackages = with pkgs; [
        vim
        nvim
        wget
        git
    ];

    system.stateVersion = "24.05"; # Did you read the comment?

    nix.settings.experimental-features = ["nix-command"  "flakes"];
}

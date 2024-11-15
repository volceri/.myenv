{
  description = "My Flake";

  inputs = {
    nixpkgs-stable.url              = "nixpkgs-stable/nixos-24.05";
    nixpkgs.url                     = "nixpkgs-stable/nixos-unstable";
    home-manager-unstable          = {
        url                         = "github:nix-community/home-manager/master";
        inputs.nixpkgs-stable.follows  = "nixpkgs";
    };
    home-manager-stable         = {
        url                     = "github:nix-community/home-manager/release-24.05";
        inputs.nixpkgs-stable.follows  = "nixpkgs-stable";
    };
  };

  outputs = inputs@{ self, ... }:
	let
		
	    systemSettings = {
            system = "x86_64-linux"; # system arch
            hostname = "nix-os"; # hostname
            profile = "vm"; # select a profile defined from my profiles directory
            timezone = "Europe/Lisbon"; # select timezone
            locale = "en_US.UTF-8"; # select locale
            # uefi or bios (Patched during install)
            bootMode = "uefi"; 
            bootMountPath = "/boot"; # mount path for efi boot partition; only used for uefi boot mode
            # device identifier for grub; only used for legacy (bios) boot mode
            # (Patched during install)
            grubDevice = "nodev"; 
            gpuType = "intel"; # amd, intel or nvidia; only makes some slight mods for amd at the moment
        };

        # ----- USER SETTINGS ----- #
        userSettings = rec {
            username = "volceri"; # username
            name = "Volceri D Avila"; # name/identifier
            email = "volceri.davila@gmail.com"; # email (used for certain configurations)
            dotfilesDir = "~/.myenv"; # absolute path of the local repo
            theme = "io"; # selcted theme from my themes directory (./themes/)
            wm = "lxqt"; # Selected window manager or desktop environment; must select one in both ./user/wm/ and ./system/wm/
            # window manager type (hyprland or x11) translator
            wmType = if ((wm == "hyprland") || (wm == "plasma")) then "wayland" else "x11";
            browser = "firefox"; # Default browser; must select one from ./user/app/browser/
            spawnBrowser = if ((browser == "qutebrowser") && (wm == "hyprland")) then "qutebrowser-hyprprofile" else (if (browser == "qutebrowser") then "qutebrowser --qt-flag enable-gpu-rasterization --qt-flag enable-native-gpu-memory-buffers --qt-flag num-raster-threads=4" else browser); # Browser spawn command must be specail for qb, since it doesn't gpu accelerate by default (why?)
            defaultRoamDir = "Personal.p"; # Default org roam directory relative to ~/Org
            term = "alacritty"; # Default terminal command;
            font = "Intel One Mono"; # Selected font
            fontPkg = pkgs.intel-one-mono; # Font package
            editor = "nvim"; # Default editor;
            # editor spawning translator
            # generates a command that can be used to spawn editor inside a gui
            # EDITOR and TERM session variables must be set in home.nix or other module
            # I set the session variable SPAWNEDITOR to this in my home.nix for convenience
            spawnEditor = if (editor == "emacsclient") then
                            "emacsclient -c -a 'emacs'"
                        else
                            (if ((editor == "vim") ||
                                (editor == "nvim") ||
                                (editor == "nano")) then
                                "exec " + term + " -e " + editor
                            else
                                (if (editor == "neovide") then
                                    "neovide -- --listen /tmp/nvimsocket" 
                                else
                                    editor));
        };

        # configure pkgs
        pkgs-stable = import inputs.nixpkgs-stable {
            system = systemSettings.system;
            config = {
                allowUnfree = true;
                allowUnfreePredicate = (_: true);
            };
        };

        pkgs-unstable = import inputs.nixpkgs {
            system = systemSettings.system;
            config = {
                allowUnfree = true;
                allowUnfreePredicate = (_: true);
            };
            overlays = [ inputs.rust-overlay.overlays.default ];
        };
      

        pkgs = (if ((systemSettings.profile == "homelab") || (systemSettings.profile == "vm"))
            then
                pkgs-unstable
            else
                pkgs-stable
        ); 
        
        # configure lib
        # use nixpkgs-stable if running a server (homelab or vm profile)
        # otherwise use patched nixos-unstable nixpkgs-stable
        lib = (if ((systemSettings.profile == "homelab") || (systemSettings.profile == "vm"))
             then
               inputs.nixpkgs.lib
             else
               inputs.nixpkgs-stable.lib);

        # use home-manager-stable if running a server (homelab or vm profile)
        # otherwise use home-manager-unstable
        home-manager = (if ((systemSettings.profile == "homelab") || (systemSettings.profile == "vm"))
            then
                inputs.home-manager-unstable
            else
                inputs.home-manager-stable);
        
        # Systems that can run tests:
        supportedSystems = [ "x86_64-linux" ];

        # Function to generate a set based on supported systems:
        forAllSystems = inputs.nixpkgs-stable.lib.genAttrs supportedSystems;

        # Attribute set of nixpkgs-stable for each system:
        nixpkgs-stableFor = forAllSystems (system: import inputs.nixpkgs-stable { inherit system; });
	in {
		nixosConfigurations = {
            system = lib.nixosSystem {
                system = systemSettings.system;
                modules = [
                    (./. + "/profiles" + ("/" + systemSettings.profile) + "/configuration.nix")                
                ]; # load configuration.nix from selected PROFILE
                specialArgs = {
                    # pass config variables from above
                    inherit pkgs-stable;
                    inherit systemSettings;
                    inherit userSettings;
                    inherit inputs;
                };
            };
        };
		homeConfigurations = {
            user = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [
                    (./. + "/profiles" + ("/" + systemSettings.profile) + "/home.nix") # load home.nix from selected PROFILE
                ];
                extraSpecialArgs = {
                    # pass config variables from above
                    inherit pkgs-stable;                    
                    inherit systemSettings;
                    inherit userSettings;
                    inherit inputs;
                };
            };
        };

        packages = forAllSystems (system:
            let pkgs = nixpkgs-stableFor.${system};
            in {
                default = self.packages.${system}.install;

                install = pkgs.writeShellApplication {
                    name = "install";
                    runtimeInputs = with pkgs; [ git ]; # I could make this fancier by adding other deps
                    text = ''${./install.sh} "$@"'';
                };
            });

        apps = forAllSystems (system: {
            default = self.apps.${system}.install;

            install = {
                type = "app";
                program = "${self.packages.${system}.install}/bin/install";
            };
        });
	};
}

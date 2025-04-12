{
  description = "My Nix-Config";

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      stylix,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      # Systems that can run tests:
      supportedSystems = [ "x86_64-linux" ];

      # Function to generate a set based on supported systems:
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      inherit (nixpkgs) lib;
      configVars = import ./vars { inherit inputs lib; };
      configLib = import ./lib { inherit lib; };
      specialArgs = {
        inherit inputs;
        inherit outputs;
        inherit configVars;
        inherit configLib;
        inherit nixpkgs;
      };
      nixpkgsFor = forAllSystems (system: import inputs.nixpkgs { inherit system; });
    in
    {
      # Custom modules to enable special functionality for nixos or home-manager oriented configs.
      #nixosModules = { inherit (import ./modules/nixos); };
      #homeManagerModules = { inherit (import ./modules/home-manager); };
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      # Custom modifications/overrides to upstream packages.
      overlays = import ./overlays { inherit inputs outputs; };

      # Custom packages to be shared or upstreamed.
      # packages = forAllSystems (
      #   system:
      #   let
      #     pkgs = nixpkgs.legacyPackages.${system};
      #   in
      #   import ./pkgs { inherit pkgs; }
      # );

       packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              self.overlays.default
              # alacritty-theme.overlays.default
            ];
          };
        in
        lib.packagesFromDirectoryRecursive {
          callPackage = lib.callPackageWith pkgs;
          directory = ./pkgs/common;
        }
      );

      # checks = forAllSystems (
      #   system:
      #   let
      #     pkgs = nixpkgs.legacyPackages.${system};
      #   in
      #   import ./checks { inherit inputs system pkgs; }
      # );

      # Nix formatter available through 'nix fmt' https://nix-community.github.io/nixpkgs-fmt
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-rfc-style);

      # # ################### DevShell ####################
      # #
      # # Custom shell for bootstrapping on new hosts, modifying nix-config, and secrets management
      devShells = forAllSystems (
        system:
        import ./shell.nix { 
          pkgs = nixpkgs.legacyPackages.${system};
        }
      );

      #################### NixOS Configurations ####################
      #
      # Building configurations available through `just rebuild` or `nixos-rebuild --flake .#hostname`

      nixosConfigurations = {
        # Main
        work = lib.nixosSystem {
          inherit specialArgs;
          modules = [
            stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager {
              home-manager = {
                useUserPackages = true;
                extraSpecialArgs = specialArgs;
              };
            }
            ./hosts/${configVars.systemSettings.profile}/configuration.nix
          ];
        };

        homelab = lib.nixosSystem {
          inherit specialArgs;
          modules = [
            stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager {
              home-manager = {
                useUserPackages = true;
                extraSpecialArgs = specialArgs;
              };
            }
            ./hosts/${configVars.systemSettings.profile}/configuration.nix
          ];
        };
      };

      #  homeConfigurations = {
      #   user = home-manager.lib.homeManagerConfiguration {
      #     pkgs = nixpkgsFor.x86_64-linux;
      #     extraSpecialArgs = specialArgs;
      #     modules = [
      #       ./modules/home-manager
      #       ./home/${configVars.userSettings.username}/${configVars.systemSettings.profile}.nix # Example: /home/volceri/homelab.nix
      #     ];
      #   };
      # };
    };

  inputs = {
    #################### Official NixOS and HM Package Sources ####################

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # The next two are for pinning to stable vs unstable regardless of what the above is set to
    # See also 'stable-packages' and 'unstable-packages' overlays at 'overlays/default.nix"
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixpkgs-zoom.url = "nixpkgs/24.05";
    nixpkgs-zoom.url = "github:NixOS/nixpkgs/06031e8a5d9d5293c725a50acf01242193635022";
    #################### Utilities ####################

    # Declarative partitioning and  h
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secrets management. See ./docs/secretsmgmt.md
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # vim4LMFQR!
    nixvim = {
      #url = "github:nix-community/nixvim/nixos-24.11";
      #inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Theming    
    stylix.url = "github:danth/stylix";
    # rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";

    # Alacritty theme
    # alacritty-theme.url = "github:alexghr/alacritty-theme.nix";

    # nix-aws-okta.url = "git+ssh://git@git.naspersclassifieds.com/volceri.avila/nix-aws-okta.git?ref=main&shallow=2";
    # nix-aws-okta.inputs = { };
    #################### Personal Repositories ####################

    # Private secrets repo.  See ./docs/secretsmgmt.md
    # Authenticate via ssh and use shallow clone
    # nix-secrets = {
    #   url = "git+ssh://git@gitlab.com/emergentmind/nix-secrets.git?ref=main&shallow=1";
    #   inputs = { };
    # };
  };
}

{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
	home-manager = {
		url = "github:nix-community/home-manager/release-24.05";
		inputs.nixpkgs.follows = "nixpkgs";
	};
  };

  outputs = { self, nixpkgs, home-manager, ... }: 
	let
		#config.allowUnfree = true;
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};		
		lib = nixpkgs.lib;
	in {
		nixosConfigurations = {
			vm-nixos = lib.nixosSystem {
				inherit system;
				modules = [ ./configuration.nix];
			};
		};
		homeConfigurations = {
			volceri = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [ ./home.nix];
			};
		};
	};
}

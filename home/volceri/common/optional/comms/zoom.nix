{ pkgs, inputs, ...}: 
let
    zoomPkgs = import inputs.nixpkgs-zoom {
        system = "x86_64-linux";
        config.allowUnfree = true;
    };
in
{
    home.packages = with pkgs; [
        zoomPkgs.zoom-us
    ];
}

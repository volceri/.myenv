{ pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      kdePackages.korganizer
      kdePackages.kdepim-addons
    ];
}
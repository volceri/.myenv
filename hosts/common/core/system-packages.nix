{pkgs, ...} : {
  environment.systemPackages = with pkgs; [
    zsh
    vim
    neovim
    wget
    htop
    btop
    kdePackages.kate
    kdePackages.dolphin
    google-chrome
    gnumake
    libgcc
    gcc
    exif
    xclip
    traceroute
    kubectl
  ];
}

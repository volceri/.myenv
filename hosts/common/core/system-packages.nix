{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    zsh
    vim
    neovim
    wget
    htop
    btop
    kdePackages.kate
    kdePackages.dolphin
    kdePackages.kompare
    google-chrome
    gnumake
    libgcc
    gcc
    exif
    xclip
    traceroute
    kubectl
    file
    atuin
    nixfmt # Formatter
    nil # Language Server
    go
  ];
}

{pkgs, ...} : {
  environment.systemPackages = with pkgs; [
    vim
    neovim
    wget
    htop
    btop
  ];
}
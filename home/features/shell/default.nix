{ pkgs, ... }: {
 
 imports = [
    ./aliases.nix
    ./fzf.nix
  ];

  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    extraOptions = [ "-l" "--icons" "--git" "-a" ];
  };

  programs.bat = { enable = true; };

  home.packages = with pkgs; [
    coreutils
    fd
    gcc
    htop
    httpie
    jq
    procs
    ripgrep
    tldr
    zip
  ];
}

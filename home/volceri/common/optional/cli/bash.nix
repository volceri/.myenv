{
  programs.bash = {
    enable = true;

    shellAliases = {
    };

    initExtra = ''
      eval "$(starship init bash)"      
      source ~/.extra
    '';
  };
}
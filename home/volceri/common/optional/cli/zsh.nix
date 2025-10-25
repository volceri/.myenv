{
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    autosuggestion.enable = true;
    history.size = 10000;
    history.share = true;

    shellAliases = { };

    initContent = ''
      source ~/.extra
    '';
  };
}
    
  
{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    autosuggestion.enable = true;

    history = {
      size = 100000;
      save = 100000;
    };

    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../../";
    };

    initContent = ''
      source ~/.extra

      # History settings (INC_APPEND_HISTORY implies APPEND_HISTORY)
      setopt INC_APPEND_HISTORY
      setopt SHARE_HISTORY
      setopt HIST_IGNORE_DUPS
      setopt HIST_IGNORE_ALL_DUPS
      setopt HIST_REDUCE_BLANKS
      setopt HIST_IGNORE_SPACE
      setopt EXTENDED_HISTORY

      # Case-insensitive completion (must reload completion system)
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}'
      zstyle ':completion:*' menu select

      # Reload completion system to apply case-insensitive settings
      autoload -Uz compinit && compinit

      # Add Go bin to PATH
      export PATH=$PATH:$(go env GOPATH)/bin
    '';

    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
      }
    ];
  };
}

{
  programs.bash = {
    enable = true;

    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../../";
    };

    historySize = 100000;
    historyFileSize = 100000;
    historyControl = [
      "ignoredups"
      "ignorespace"
    ];
    historyIgnore = [
      "ls"
      "cd"
      "pwd"
      "exit"
      "clear"
    ];

    initExtra = ''
      eval "$(starship init bash)"
      source ~/.extra

      # Additional history settings
      shopt -s histappend
      PROMPT_COMMAND="history -a; history -n"

      # Add Go bin to PATH
      export PATH=$PATH:$(go env GOPATH)/bin
    '';
  };
}

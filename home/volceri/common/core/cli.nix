{ pkgs, ... }: {
  home.packages = with pkgs; [
    eza # Better ls
    ripgrep # Better grep
    fd # Better find
    httpie # Better curl
    jq # JSON pretty printer and manipulator
    eza # ls replacement
    fd # tree style ls
    findutils # find
    fzf # fuzzy search
    curl
    tree # cli dir tree viewer
  ];
  
}
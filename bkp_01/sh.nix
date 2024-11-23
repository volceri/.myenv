{ config, pkgs, ... } : 

  let myAliases = {
      ll = "ls -lha";
      ".." = "cd ..";
    };
in
{
  programs.bash = {
    enable = true;
    shellAliases = myAliases;
  };

  programs.zsh = {
    enable = true;
    shellAliases = myAliases;
  };
}
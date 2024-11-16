{ config, pkgs, lib, ... }: with lib;

let
  cfg = config.features.shell.shellAliases;

  shellAliases = {
    ll = "ls -lha";
    ".." = "cd ..";
  };
in
{
  options.features.shell.fzf.enable = mkEnableOption "enable shell aliases";

  config = mkIf cfg.enable {

    programs.bash = {
      enable = true;
      shellAliases = shellAliases;
    };

    programs.zsh = {
      enable = true;
      shellAliases = shellAliases;
    };

  };
}

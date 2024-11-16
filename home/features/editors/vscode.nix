{ config, lib, ... }: with lib;
let
  cfg = config.features.editors.vscode;
in
{
  options.features.editors.vscode.enable = mkEnableOption "enable vscode";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      vscode
    ];

    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        dracula-theme.theme-dracula
        golang.go
      ];
    };
  };
}

{ pkgs, lib, ...}: 
{
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
}

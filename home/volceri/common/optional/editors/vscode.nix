{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      golang.go
      graphql.vscode-graphql
      graphql.vscode-graphql-syntax
      devsense.phptools-vscode
    ];
  };
}
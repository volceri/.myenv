{ pkgs, config, lib, ...}: {
  programs.vscode = {
    enable = true;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
          dracula-theme.theme-dracula
          golang.go
          graphql.vscode-graphql
          graphql.vscode-graphql-syntax
        ];

      userSettings = {
        "update.mode" = "none";
        "editor.fontSize" = lib.mkForce 12;
        "workbench.tree.indent" = lib.mkForce 14;
        "workbench.tree.renderIndentGuides" = lib.mkForce "always";
        "debug.console.fontSize" = lib.mkForce 12;
        "files.autoSave" = lib.mkForce "afterDelay";
        "terminal.integrated.fontSize" = lib.mkForce 12;
        "scm.inputFontSize" = lib.mkForce 12;
        "git.confirmSync" = lib.mkForce false;
        "workbench.editor.enablePreview" = lib.mkForce false;
        "editor.minimap.enabled" = false;

        "editor.language.brackets" = [
          [ "[" "]" ]
          [ "{" "}" ]
          [ "(" ")" ]
          [ "⟨" "⟩" ]
        ];

        "editor.language.colorizedBracketPairs" = [
            ["[" "]"]
            ["(" ")"]
            ["{" "}"]
            ["⟨" "⟩"]
          ];
          "workbench.colorCustomizations" = {
            "editorBracketHighlight.foreground1" = "#fac928";
            "editorBracketHighlight.foreground2" = "#c122e9";
            "editorBracketHighlight.foreground3" = "#057aff";
            "editorBracketHighlight.foreground4" = "#00e74d";
            "editorBracketHighlight.foreground5" = "#f51384";
            "editorBracketHighlight.foreground6" = "#19f9d8";
            "editorBracketPairGuide.background1" = "#fac9289E";
            "editorBracketPairGuide.background2" = "#c122e99E";
            "editorBracketPairGuide.background3" = "#057aff9E";
            "editorBracketPairGuide.background4" = "#00e74d9E";
            "editorBracketPairGuide.background5" = "#f513849E";
            "editorBracketPairGuide.background6" = "#19f9d89E";
            "editorBracketPairGuide.activeBackground1" = "#FAC9289E";
            "editorBracketPairGuide.activeBackground2" = "#C122E99E";
            "editorBracketPairGuide.activeBackground3" = "#057AFF9E";
            "editorBracketPairGuide.activeBackground4" = "#00E7499E";
            "editorBracketPairGuide.activeBackground5" = "#F513849E";
            "editorBracketPairGuide.activeBackground6" = "#19F9D89E";
          };
          "terminal.integrated.defaultProfile.linux" = "zsh";
          "terminal.integrated.profiles.linux" = {      
              "zsh" =  {
                  "path" = "zsh";
                  "args" = [
                      "-l"
                  ];
              } ;
          };
          "chat.tools.terminal.autoApprove" = {
            "git add" = true;
            "make" = true;
            "go" = true;
          };
      };
    };
  };
}

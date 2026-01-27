{
  programs.atuin = {
    enable = true;

    enableZshIntegration = true;
    enableBashIntegration = true;

    settings = {
      auto_sync = false; # local only (recommended)
      sync_address = ""; # disable remote sync
      update_check = false;

      search_mode = "fuzzy";
      filter_mode = "global";
      style = "auto"; # Options: auto, full, compact
      inline_height = 20;
      show_preview = true;
      exit_mode = "return-query";

      # Store all commands including those that failed
      records = true;

      # Arrow key configuration - make sure UP arrow shows all history
      filter_mode_shell_up_key_binding = "global";
      search_mode_shell_up_key_binding = "prefix";

      # Share history across all sessions
      sync_frequency = "0";

      # Theme configuration - built-in themes: "default", "autumn", "marine"
      theme.name = "marine";

      # Filter out only basic commands without arguments
      history_filter = [
        "^ls$"
        "^cd$"
        "^pwd$"
        "^exit$"
        "^clear$"
        "^ll$"
        "^la$"
      ];
    };
  };
}

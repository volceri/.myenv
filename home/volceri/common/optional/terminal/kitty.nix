{ pkgs, ... }:{
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;

    #    font = {
    #package = "";
    #     name = "notosansmono";
    #      size = 9;
    #    };

    settings = {
      font_family = "FiraMono Nerd Font";
      bold_font = "auto";
      italic_font = "auto";
      scrollback_lines = 10000;
      font_size = 10;
     
      cursor = "#c66e02";
      cursor_shape = "underline";
      cursor_beam_thickness = 1.5;
      cursor_underline_thickness = 2;
      cursor_blink_interval = -1;
      cursor_stop_blinking_after = 15.0;

      copy_on_select = true;

      dim_opacity = 0.2;
      background_tint = 0.2;
      
      dynamic_background_opacity = true;


      tab_bar_min_tabs = 1;
      
      shell = "${pkgs.zsh}/bin/zsh";

      window_border_width = 2;
      draw_minimal_borders = false;
      window_padding_width = 4;

      active_border_color = "#ff0000";
      background = "#282c34";
      bell_border_color = "#cd0000";
      foreground = "#bbc2cf";

      term = "xterm-256color";
    };
    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      #      "ctrl+v" = "paste_from_clipboard"; #interferes with visual block mode in vim
    };
    #theme = "";

    extraConfig = ''
           tab_bar_style  powerline
           tab_title_template \uf489 {title}
           # tab_title_template "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{tab.last_focused_progress_percent}{title}"
    '';
  };
}
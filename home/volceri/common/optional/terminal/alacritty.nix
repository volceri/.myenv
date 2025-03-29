{
  pkgs,
  ...
}: {
    programs.alacritty = {
        enable = true;

        settings = {
            window = {
                padding = {
                    x = 4;
                    y = 8;
                };
                decorations = "full";
                opacity = 1;
                startup_mode = "Windowed";
                title = "Alacritty";
                dynamic_title = true;
                decorations_theme_variant = "None";
            };

            general = {
                # import = [
                #      pkgs.alacritty-theme.catppuccin_macchiato
                # ];

                live_config_reload = true;
            };

            font = let
            jetbrainsMono = style: {
                family = "JetBrainsMono Nerd Font";
                inherit style;
            };
            in {
                #   size =
                #     if meta.name == "karasu"
                #     then 12
                #     else 16;
                normal = jetbrainsMono "Regular";
                bold = jetbrainsMono "Bold";
                italic = jetbrainsMono "Italic";
                bold_italic = jetbrainsMono "Bold Italic";
            };

            mouse.hide_when_typing = true;

            cursor = {
                style = "Block";
            };

            env = {
                TERM = "xterm-256color";
            };
        };
    };
}

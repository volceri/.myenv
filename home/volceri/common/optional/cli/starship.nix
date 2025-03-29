{pkgs, ...}: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;

    # Configuration written to ~/.config/starship.toml
    settings = {
        add_newline = true;
        package = {
            disabled = true;
        };


        character = {
            success_symbol = "[➜](bold green)";
            error_symbol = "[➜](bold red)";
        };

        directory = {
            truncate_to_repo = false;
            truncation_length = 100;
            truncation_symbol = ".../";
            home_symbol = "/home/volceri";
        };

        # time = {
        #     disabled = false;
        #     style = "gray";
        #     format = "🕙[\[ $time \]]($style) ";
        #     time_format = "%H:%M:%S.%f";
        # };

        container = {
            format = "[$symbol \\[$name \\]] ($style)";
        };
    };
  };
}
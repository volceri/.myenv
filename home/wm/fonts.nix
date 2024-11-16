# { pkgs, ... }: {
#   fonts.packages = with pkgs; [
#     nerdfonts
#     powerline
#     fira-code
#     fira-code-symbols
#     fira-code-nerdfont
#     font-manager
#     font-awesome_5
#     noto-fonts
#   ];
# }


{ pkgs, ... }:

{
  # Fonts are nice to have
  fonts.packages = with pkgs; [
    # Fonts
    nerdfonts
    powerline
  ];

}

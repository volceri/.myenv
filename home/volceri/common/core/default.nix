{ config
, lib
, pkgs
, outputs
, inputs
, configLib
, configVars
, ...
}: {
  imports = (configLib.scanPaths ./.) ++ (builtins.attrValues outputs.homeManagerModules);

  home.packages = builtins.attrValues {
    inherit (pkgs)

      # Packages that don't have custom configs go here
      btop # resource monitor
      copyq # clipboard manager
      coreutils # basic gnu utils
      dust # disk usage
      findutils # find
      nix-tree # nix package tree viewer
#       neofetch # fancier system info than pfetch
#       ncdu # TUI disk usage
#       pciutils
#       pfetch # system info
#       pre-commit # git hooks
      p7zip # compression & encryption
      ripgrep # better grep
      # steam-run # for running non-NixOS-packaged binaries on Nix
      # usbutils
      
      unzip # zip extraction
      unrar # rar extraction
#       xdg-utils # provide cli tools such as `xdg-mime` and `xdg-open`
#       xdg-user-dirs
#       wev # show wayland events. also handy for detecting keypress codes
      wget # downloader
      zip # zip compression

      pdfpc # presentation tool with multi-screen support
      screen-message # shows a fullscreen text (sm)
      xournalpp # free-hand notes, drawings and PDF annotations
      cheese # webcam app
      inkscape # vector graphics editor
      
      ;
  };


  # xdg = {
  #   enable = true;
  #   userDirs = {
  #     enable = true;
  #     createDirectories = true;
      # desktop = "${config.home.homeDirectory}/.desktop";
      # documents = "${config.home.homeDirectory}/documents";
      # download = "${config.home.homeDirectory}/downloads";
      # music = "${config.home.homeDirectory}/media/audio";
      # pictures = "${config.home.homeDirectory}/media/images";
      # videos = "${config.home.homeDirectory}/media/video";
      # # publicshare = "/var/empty"; #using this option with null or "/var/empty" barfs so it is set properly in extraConfig below
      # # templates = "/var/empty"; #using this option with null or "/var/empty" barfs so it is set properly in extraConfig below

      # extraConfig = {
      #   # publicshare and templates defined as null here instead of as options because
      #   XDG_PUBLICSHARE_DIR = "/var/empty";
      #   XDG_TEMPLATES_DIR = "/var/empty";
      # };
    # };
  #   portal = {
  #     enable = true;
  #     config.common.default = [
  #       "gtk"
  #     ];
  #     extraPortals = with pkgs; [
  #       xdg-desktop-portal
  #       xdg-desktop-portal-kde
  #     ];

  #     config.kde = {
  #       "org.freedesktop.impl.portal.ScreenCast" = "kde";
  #     };
  #     config.plasma6 = {
  #       "org.freedesktop.impl.portal.ScreenCast" = "kde";
  #     };
  #     xdgOpenUsePortal = true;
  #   #   # gtkUsePortal = true;
  #   };
  # };

  # xdg.portal.gtkUsePortal=true;

  nixpkgs = {
    # overlays = (builtins.attrValues outputs.overlays) ++ (builtins.attrValues inputs.alacritty-theme.overlays) ;
    overlays = (builtins.attrValues outputs.overlays);
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
    };
  };



  programs = {
    home-manager.enable = true;
  };

  home = {
    stateVersion = "24.11";
  };

}

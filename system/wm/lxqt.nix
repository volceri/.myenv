{ pkgs, ... }:

{
  imports = [
    # ./pipewire.nix
    # ./dbus.nix
    # ./fonts.nix
  ];

  # Configure X11
  services.xserver = {
    enable = true;
    #xkbOptions = "caps:escape";
    #excludePackages = [ pkgs.xterm ];
    xkb = {
      layout = "us";
      variant = "";
    };
    displayManager = {
      lightdm.enable = true;
      #sessionCommands = ''
      #xset -dpms
      #xset s blank
      #xset r rate 350 50
      #xset s 300
      #${pkgs.lightlocker}/bin/light-locker --idle-hint &
      #'';    
    };
    desktopManager = {
      # Enable the LXQT Desktop Environment.
      lxqt.enable = true;
    };
    libinput = {
      #touchpad.disableWhileTyping = true;
    };
  };
}

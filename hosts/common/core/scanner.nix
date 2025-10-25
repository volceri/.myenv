{ pkgs, ... }: {
    
  hardware.sane.enable = true; # enables support for SANE scanners
  hardware.sane.extraBackends = [ pkgs.hplipWithPlugin ];

  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  
}

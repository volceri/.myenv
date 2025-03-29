{ pkgs, ... }: {
  
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplip ]; 
  };
  
  # Enable autodiscovery of network printers
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}

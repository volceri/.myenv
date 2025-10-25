
{pkgs, ...} : {
  environment.systemPackages = with pkgs; [
    appimage-run
  ];
  
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  programs.appimage.package = pkgs.appimage-run.override { extraPkgs = pkgs: [
  
  ]; };
}

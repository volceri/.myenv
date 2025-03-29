{ pkgs, ...} : {
    home.packages = with pkgs; [
        python311
    ] ++
    (with pkgs.python311Packages; [
        pipx
      ]
    );
}
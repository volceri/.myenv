{ pkgs, ...} : {
    home.packages = with pkgs; [
        (python311.withPackages (
            ps: with ps; [ 
                requests 
                pyyaml 
            ])
        )
        pipx
    ];
}
{ pkgs, ...} : {
    home.packages = with pkgs; [
        (python313.withPackages (
            ps: with ps; [ 
                requests 
                pyyaml 
                pdftotext
            ])
        )
        pipx
        poppler-utils

    ];
}
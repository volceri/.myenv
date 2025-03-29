{ config, pkgs, lib, configVars, ... }: with lib;

    let shellAliases = {
        #-------------Bat related------------
        cat = "bat --paging=never";
        diff = "batdiff";
        rg = "batgrep";
        man = "batman";
        
        #------------Navigation------------
        l = "eza -lah";
        la = "eza -lah";
        ll = "eza -lha";
        ls = "eza";
        lsa = "eza -lah";

        #-------------Neovim---------------
        vi = "nvim";
        vim = "nvim";

        #-------------- Nix ----------------- 
        nixb = "sudo nixos-rebuild switch --flake /home/${configVars.userSettings.username}/.myenv#${configVars.systemSettings.profile}";
    };
in
{
    programs.bash.shellAliases = shellAliases;
    programs.zsh.shellAliases = shellAliases;

}

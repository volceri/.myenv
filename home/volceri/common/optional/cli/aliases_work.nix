{ config, pkgs, lib, configVars, ... }: with lib;

    let shellAliases = {
        cvpn = "sudo openconnect vpn.olxcorp.com --authgroup 'OLXGROUP-TUNNEL-ALL' -u ${configVars.userSettings.workusername} --useragent AnyConnect --no-external-auth --form-entry=challenge:answer=2";
        aol = "nix-shell -p semeru-jre-bin-11 --command 'aws-okta login'";
        aor = "nix-shell -p semeru-jre-bin-11 --command 'aws-okta roles'";
        ssh-v-stg = "/home/${configVars.userSettings.username}/.local/bin/ssh-olx developer@bastion-bless.toolbox.stg.verticals.olx.org -o StrictHostKeyChecking=no";
        ssh-v-prd = "/home/${configVars.userSettings.username}/.local/bin/ssh-olx developer@bastion-bless.toolbox.prd.verticals.olx.org -o StrictHostKeyChecking=no";

        ssh-h-stg = "/home/${configVars.userSettings.username}/.local/bin/ssh-olx developer@developer-bastion.stg.eu.olx.org -o StrictHostKeyChecking=no";
        ssh-h-prd = "/home/${configVars.userSettings.username}/.local/bin/ssh-olx developer@developer-bastion.prd.eu.olx.org -o StrictHostKeyChecking=no";

        atlas_update =''
            cd /home/${configVars.userSettings.username}/dev/projects/motors/atlas/verticals-cars-atlas-web-dist && \
            make update && \
            echo "Fixing cache dir" && \
            sudo rm -frv /home/${configVars.userSettings.username}/dev/projects/motors/atlas/verticals-cars-atlas-web-dist/cache && \
            mkdir ./cache && \
            echo "Changing ownership" && \
            sudo chown -R ${configVars.userSettings.username}:users ./cache ./vendor ./node_modules && \
            echo "Changing permissions" && \
            chmod 777 -R  ./cache ./vendor ./node_modules && \
            make start-debug
        '';
    };
in
{
    programs.bash.shellAliases = shellAliases;
    programs.zsh.shellAliases = shellAliases;

}
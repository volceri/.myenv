{ config, pkgs, lib, configVars, ... }: with lib;

    let shellAliases = {
        cvpn = "sudo openconnect vpn.olxcorp.com --authgroup 'OLXGROUP-TUNNEL-ALL' -u ${configVars.userSettings.workusername} --useragent AnyConnect --no-external-auth --form-entry=challenge:answer=2";

        aol = "nix-shell -p semeru-jre-bin-11 --command 'aws-okta login'";
        aor = "nix-shell -p semeru-jre-bin-11 --command 'aws-okta roles'";
        # ssh-v-stg = "/home/${configVars.userSettings.username}/.local/bin/ssh-olx developer@bastion-bless.toolbox.stg.verticals.olx.org -o StrictHostKeyChecking=no";
        # ssh-v-prd = "/home/${configVars.userSettings.username}/.local/bin/ssh-olx developer@bastion-bless.toolbox.prd.verticals.olx.org -o StrictHostKeyChecking=no";
        
        ssh-v-stg-m = "/home/${configVars.userSettings.username}/.local/bin/ssh-olx developer@verticals-cf-dev.eu-west-1.bastion.eu.olx.org -o StrictHostKeyChecking=no";
        ssh-v-prd-m = "/home/${configVars.userSettings.username}/.local/bin/ssh-olx developer@verticals-cf.eu-west-1.bastion.eu.olx.org -o StrictHostKeyChecking=no";
       
        ssh-v-stg-s = "/home/${configVars.userSettings.username}/.local/bin/ssh-olx developer@naspers-verticals-mercury-dev.eu-west-1.bastion.eu.olx.org -o StrictHostKeyChecking=no";
        ssh-v-prd-s = "/home/${configVars.userSettings.username}/.local/bin/ssh-olx developer@naspers-verticals-mercury.eu-west-1.bastion.eu.olx.org -o StrictHostKeyChecking=no";

        ssh-h-stg = "/home/${configVars.userSettings.username}/.local/bin/ssh-olx developer@developer-bastion.stg.eu.olx.org -o StrictHostKeyChecking=no";
        ssh-h-prd = "/home/${configVars.userSettings.username}/.local/bin/ssh-olx developer@developer-bastion.prd.eu.olx.org -o StrictHostKeyChecking=no";

        atlas_update =''
            cd /home/${configVars.userSettings.username}/dev/projects/motors/atlas/verticals-cars-atlas-web-dist && \
            make update && \
            echo -e "\033[31m-- Fixing cache dir\033[0m" && \
            sudo rm -frv /home/${configVars.userSettings.username}/dev/projects/motors/atlas/verticals-cars-atlas-web-dist/cache && \
            mkdir ./cache && \
            echo -e "\033[31m-- Changing ownership\033[0m" && \
            sudo chown -R ${configVars.userSettings.username}:users ./logs ./cache ./vendor ./node_modules && \
            echo -e "\033[31m-- Changing permissions\033[0m" && \
            chmod 777 -R ./logs ./cache ./vendor ./node_modules && \
            make start-debug
        '';

        atlas_start_kafka = ''
            cd /home/${configVars.userSettings.username}/dev/projects/motors/atlas/verticals-cars-atlas-web-dist && \
            make start-with-kafka && \
            make start-debug
        '';

        fix-atlas-permissions = ''
            sudo chown -R ${configVars.userSettings.username}:users /home/${configVars.userSettings.username}/dev/projects/motors/atlas/verticals-cars-atlas-web-dist/logs
            sudo chown -R ${configVars.userSettings.username}:users /home/${configVars.userSettings.username}/dev/projects/motors/atlas/verticals-cars-atlas-web-dist/cache
            sudo chown -R ${configVars.userSettings.username}:users /home/${configVars.userSettings.username}/dev/projects/motors/atlas/verticals-cars-atlas-web-dist/vendor
            sudo chown -R ${configVars.userSettings.username}:users /home/${configVars.userSettings.username}/dev/projects/motors/atlas/verticals-cars-atlas-web-dist/node_modules
            sudo chmod 777 -R /home/${configVars.userSettings.username}/dev/projects/motors/atlas/verticals-cars-atlas-web-dist/logs
            sudo chmod 777 -R /home/${configVars.userSettings.username}/dev/projects/motors/atlas/verticals-cars-atlas-web-dist/cache
            sudo chmod 777 -R /home/${configVars.userSettings.username}/dev/projects/motors/atlas/verticals-cars-atlas-web-dist/vendor
            sudo chmod 777 -R /home/${configVars.userSettings.username}/dev/projects/motors/atlas/verticals-cars-atlas-web-dist/node_modules
        '';
    };
in
{
    programs.bash.shellAliases = shellAliases;
    programs.zsh.shellAliases = shellAliases;

}
{ inputs, ... }: {
  systemSettings = rec {
    system = "x86_64-linux";
    hostname = "lisbon";
    profile = "homelab";
    timezone = "Europe/Lisbon";
    locale = "en_US.UTF-8";
    networking = {
      ports = {
        tcp = {
          ssh = 22;
        };
      };
    };
  };
  userSettings = rec {
    username = "volceri";
    workusername = "volceri.avila";
    name = "Volceri D'Avila";
    email = "volceri.davila@gmail.com";
    signingKey = "3D154B08850D1043";
  };
}

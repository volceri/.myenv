{
  inputs,
  config,
  lib,
  ...
}:
{
  imports = [
    inputs.nix-sweep.nixosModules.default
  ];

  nix = {
    # This will add each flake input as a registry
    # To make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # See https://jackson.dev/post/nix-reasonable-defaults/
      connect-timeout = 5;
      log-lines = 25;
      min-free = 128000000; # 128MB
      max-free = 1000000000; # 1GB

      # Deduplicate and optimize nix store
      auto-optimise-store = true;

      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
    };
  };

  # Garbage Collection & Clean-up
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";

  services.nix-sweep = {
    enable = true;
    removeOlder = "7d"; # Remove anything inactive for 7 days
    gc = false; # Let nix.gc handle general garbage
    interval = "weekly";
  };
}

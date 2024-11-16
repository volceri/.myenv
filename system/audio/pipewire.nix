{ config, lib, ... }: with lib;

let cfg = config.features.audio.pipewire;

in {
  options.features.audio.pipewire.enable = mkEnableOption "enable Pipewire";

  # Pipewire
  config = mkIf cfg.enable {
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}

{ config, pkgs, ... }:
{
  programs.obs-studio = {
    enable = true;

    # AMD hardware acceleration (no CUDA needed)

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi #optional AMD hardware acceleration
      obs-gstreamer
      obs-vkcapture
    ];
  };
}

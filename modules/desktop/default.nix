{ config, pkgs, ... }: {
  hardware.graphics.enable = true;

  programs.niri.enable = true;

  security.pam.services.swaylock = {};

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.niri = {
      "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
    };
  };

  services.dbus.enable = true;

  programs.xwayland.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  services.udisks2.enable = true;
  services.gvfs.enable = true;
  services.gnome.gnome-keyring.enable = true;
}

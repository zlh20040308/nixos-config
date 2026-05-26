{ config, pkgs, ... }: {
  gtk = {
    enable = true;

    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };

    iconTheme = {
      name = "Adwaita";
    };

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  # 显式让 GTK4 跟随 GTK3 主题，消除 stateVersion 警告
  gtk.gtk4.theme = config.gtk.theme;

  # mkOutOfStoreSymlink，方便直接改 CSS 实时调试
  xdg.configFile."gtk-3.0/gtk.css".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/home/gtk/gtk.css";

  dconf.enable = true;

  home.sessionVariables = {
    GTK_THEME = "Adwaita-dark";
  };
}

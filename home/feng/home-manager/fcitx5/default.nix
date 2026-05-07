{ config, pkgs, ... }:
{
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      kdePackages.fcitx5-qt
      qt6Packages.fcitx5-chinese-addons
      fcitx5-nord
    ];
  };
  i18n.inputMethod.fcitx5.waylandFrontend = true;
  home.sessionVariables = {
    QT_IM_MODULE = "fcitx";
    QT5_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };
}

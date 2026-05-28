{ config, pkgs, nixvim, ... }:
{
  imports = [
    nixvim.homeModules.nixvim
    ../../home/zsh
    ../../home/niri
    ../../home/nvim
    ../../home/gtk
    ../../home/waybar
    ../../home/fcitx5
    ../../home/wallpaper
    ../../home/kitty
    ../../home/claude
    ../../home/obs
    ../../home/tmux
  ];
  home.username = "feng";
  home.homeDirectory = "/home/feng";
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    vscode
    qq
    btop
    wev
    fastfetch
    yazi
    tmux
    fuzzel
    lazygit
    ueberzugpp
    wl-clipboard
  ];
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "feng";
        email = "2165926681@qq.com";
      };
    };
  };
  home.file = {};
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  programs.home-manager.enable = true;
}

{ config, pkgs, ... }:
{
  imports = [
    ../../home/zsh
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
    qq
    btop
    wev
    fastfetch
    neovim
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

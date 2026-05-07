{ pkgs, ... }:
{
  home.packages = with pkgs; [
    awww
  ];

  home.file.".config/wallpaper/pictures" = {
    source = ./pictures;
    recursive = true;
  };

  home.file.".config/wallpaper/switch.sh" = {
    source = ./switch.sh;
    executable = true;
  };
}


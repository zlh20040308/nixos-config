{ config, pkgs, ... }: {
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji

    dejavu_fonts

    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  fonts = {
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "DejaVu Sans" "Noto Sans CJK SC" "Noto Sans CJK JP" ];
        serif = [ "DejaVu Serif" "Noto Serif CJK SC" "Noto Serif CJK JP" ];
        monospace = [ "Fira Code" "DejaVu Sans Mono" "Noto Sans Mono CJK SC" ];
      };
    };
  };
}

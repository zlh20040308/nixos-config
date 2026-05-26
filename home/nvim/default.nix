{ config, pkgs, ... }:
let
  cfgDir = "${config.home.homeDirectory}/nixos-config/home/nvim";
in {
  home.packages = [
    (pkgs.wrapNeovim pkgs.neovim-unwrapped {
      plugins = with pkgs.vimPlugins; [
        nvim-lspconfig
        fzf-lua
        mini-nvim
        gitsigns-nvim
        quicker-nvim
      ];
    })
  ];

  xdg.configFile."nvim/init.lua".source =
    config.lib.file.mkOutOfStoreSymlink "${cfgDir}/init.lua";
}

{ config, pkgs, lib, ... }:
{
  programs.nixvim = {
    enable = true;

    colorschemes.nord.enable = true;

    globals.mapleader = " ";

    opts = {
      number = true;
      relativenumber = true;
      ignorecase = true;
      smartcase = true;
      cursorline = true;
      scrolloff = 10;
      list = true;
      confirm = true;
    };

    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };

    keymaps = [
      { mode = "t"; key = "<Esc>"; action = "<C-\\><C-n>"; }
      { mode = [ "t" "i" ]; key = "<A-h>"; action = "<C-\\><C-n><C-w>h"; }
      { mode = [ "t" "i" ]; key = "<A-j>"; action = "<C-\\><C-n><C-w>j"; }
      { mode = [ "t" "i" ]; key = "<A-k>"; action = "<C-\\><C-n><C-w>k"; }
      { mode = [ "t" "i" ]; key = "<A-l>"; action = "<C-\\><C-n><C-w>l"; }
      { mode = "n"; key = "<A-h>"; action = "<C-w>h"; }
      { mode = "n"; key = "<A-j>"; action = "<C-w>j"; }
      { mode = "n"; key = "<A-k>"; action = "<C-w>k"; }
      { mode = "n"; key = "<A-l>"; action = "<C-w>l"; }
      { mode = "i"; key = "jj"; action = "<Esc>"; }
    ];

    plugins = {
      lsp = {
        enable = true;
        inlayHints = true;
        servers.rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
          settings = {
            inlayHints = {
              typeHints = true;
              parameterHints = true;
              chainingHints = true;
            };
            checkOnSave.command = "clippy";
          };
        };
        keymaps = {
          diagnostic = {};
          lspBuf = {
            gd.action = "definition";
            gr.action = "references";
            K.action = "hover";
            "<leader>rn".action = "rename";
            "<leader>ca".action = "code_action";
          };
        };
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
          mapping = {
            "<Tab>" = "cmp.mapping.select_next_item()";
            "<S-Tab>" = "cmp.mapping.select_prev_item()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<C-e>" = "cmp.mapping.abort()";
          };
        };
      };

      fzf-lua = {
        enable = true;
        settings = { fzf_colors = true; };
      };

      gitsigns.enable = true;
    };

    highlightOverride = {
      Normal.bg = "NONE";
      NormalNC.bg = "NONE";
      NonText.bg = "NONE";
    };

    autoCmd = [
      {
        event = [ "TextYankPost" ];
        command = "lua vim.hl.on_yank()";
        desc = "Highlight when yanking (copying) text";
      }
    ];

    userCommands = {
      GitBlameLine = {
        command.__raw = ''
          function()
            local line_number = vim.fn.line('.')
            local filename = vim.api.nvim_buf_get_name(0)
            print(vim.system({ 'git', 'blame', '-L', line_number .. ',+1', filename }):wait().stdout)
          end
        '';
        desc = "Print the git blame for the current line";
      };
    };

    extraPlugins = [ pkgs.vimPlugins.quicker-nvim ];

    extraConfigLua = ''
      vim.cmd('packadd! nohlsearch')
      require('quicker').setup {}
    '';
  };
}

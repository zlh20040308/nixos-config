{config, pkgs, ...}: let
  waybarStylePath = "${config.home.homeDirectory}/nixos-config/home/waybar/style.css";
in {
  home.packages = with pkgs; [
    pavucontrol
    networkmanagerapplet
    # Niri 需要的工作区脚本依赖
    jq  # 用于解析 Niri 的 JSON 输出
  ];

  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 36;
        spacing = 8;

        modules-left = [
          "niri/workspaces"
          "niri/window"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "temperature"
          "battery"
          "tray"
        ];

        "niri/workspaces" = {
          format = "{icon}";
          current-only = false;
          all-outputs = false;

          format-icons = {
            active = "";
            default = "";
          };
        };

        "niri/window" = {
          format = "{title}";
          separate-outputs = true;
          max-length = 60;

          rewrite = {
            "(.*) - Mozilla Firefox" = "🌍 $1";
            "(.*) - Zen Browser" = "🌍 $1";
            "(.*) - kitty" = " $1";
            "(.*) - nvim" = " $1";
          };
        };

        clock = {
          format = "  {:%H:%M}";
          format-alt = "  {:%A, %d %B %Y}";
          tooltip-format = "{:%Y-%m-%d %H:%M:%S}";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "󰝟 muted";

          format-icons = {
            default = [ "" "" "" ];
          };

          on-click = "pavucontrol";
        };

        network = {
          format-wifi = "󰖩  {signalStrength}%";
          format-ethernet = "󰈀 connected";
          format-disconnected = "󰖪 offline";
          tooltip-format = "{ifname} via {gwaddr}";
        };

        cpu = {
          format = "󰍛 {usage}%";
          interval = 2;
        };

        memory = {
          format = "󰘚 {}%";
          interval = 2;
        };

        temperature = {
          critical-threshold = 80;
          format = "󰔄 {temperatureC}°C";
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };

          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰚥 {capacity}%";

          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        tray = {
          spacing = 10;
        };
      };
    };

    style = config.lib.file.mkOutOfStoreSymlink waybarStylePath;
  };
}

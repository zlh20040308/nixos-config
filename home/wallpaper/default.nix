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

  systemd.user.services.set-wallpaper = {
    Unit = {
      Description = "Set wallpaper";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Install.WantedBy = [ "default.target" ];
    Service = {
      Type = "oneshot";
      ExecStart = "%h/.config/wallpaper/switch.sh";
    };
  };

  systemd.user.timers.set-wallpaper = {
    Install.WantedBy = [ "timers.target" ];
    Timer = {
      OnCalendar = "*:0/5";
      Persistent = true;
    };
  };
}

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../../modules/clash
      ./hardware-configuration.nix
    ];
  nixpkgs.config.allowUnfree = true;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking = {
    hostName = "nixos";
    # Configure network connections interactively with nmcli or nmtui.
    networkmanager.enable = true;
  };
  hardware.bluetooth.enable = true;

  services.blueman.enable = true;
  # Set time zone.
  time.timeZone = "Asia/Shanghai";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://127.0.0.1:7897";
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "LatArCyrHeb-16";
    keyMap = "us";
  };
  programs.zsh.enable = true;
  programs.niri.enable = true;
  #programs.waybar.enable = true;
  security = {
    pam.services.swaylock = {};
  };
  xdg.portal = { 
    enable = true;
    extraPortals = [
      # pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-gtk
    ];  
    config.niri = {
      "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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
	sansSerif = [ "Noto Sans CJK SC" "Noto Sans CJK JP" "DejaVu Sans" ];
        serif = [ "Noto Serif CJK SC" "Noto Serif CJK JP" "DejaVu Serif" ];
	monospace = [ "Fira Code" "DejaVu Sans Mono" "Noto Sans Mono CJK SC" ];
      };
    };
  };

  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };
  
  services.dbus.enable = true;
  services.displayManager.gdm.enable = true;

  programs.xwayland.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support
  services.libinput.enable = true;

  services.udisks2.enable = true;
  services.gvfs.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  # Define a user account
  users.users.feng = {
    isNormalUser = true;
    initialPassword = "1234";
    extraGroups = [ "wheel" "networkmanager" "input" ]; # Enable ‘sudo’ for the user.
  };

  programs.firefox.enable = true;
  programs.thunar.enable = true;
  environment.systemPackages = with pkgs; [
    home-manager
    git
    vim
    wget
    xwayland-satellite
    power-profiles-daemon
    swaylock
    mako
    waybar
    xdg-desktop-portal-gtk
    gvfs
  ];
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  system.stateVersion = "25.11";

}


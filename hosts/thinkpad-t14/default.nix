{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../../modules/clash
      ../../modules/fonts
      ../../modules/power
      ../../modules/desktop
      ./hardware-configuration.nix
    ];
  nixpkgs.config.allowUnfree = true;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  swapDevices = [{
    device = "/dev/disk/by-uuid/f1b6c56b-d45b-4958-b160-ba1141e643a1";
  }];

  zramSwap.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking = {
    hostName = "thinkpad-t14";
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
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;

  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  # Define a user account
  users.users.feng = {
    isNormalUser = true;
    initialPassword = "1234";
    extraGroups = [ "wheel" "networkmanager" "input" ]; # Enable 'sudo' for the user.
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
  services.earlyoom.enable = true;

  system.stateVersion = "25.11";

}

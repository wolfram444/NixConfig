{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules.nix
  ];

  nixpkgs.config.allowUnfree = true;
  networking.hostName = "temp"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Define a user account.
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  users.users.wolf4am = {
    isNormalUser = true;
    description = "Xabib";

    extraGroups = [
      "networkmanager"
      "wheel"

    ];
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  time.timeZone = "Asia/Tashkent";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  programs.nix-data = {
    enable = true;

    systemconfig = "/home/wolf4am/NixConfig/systems/x86_64-linux/temp/default.nix";
    flake = "/home/wolf4am/NixConfig/flake.nix";
    flakearg = "asus";
  };

  system.stateVersion = "26.05"; # Do not change it!!
  environment.systemPackages = [
    pkgs.zed-editor
    pkgs.gnome-secrets
  ];
}

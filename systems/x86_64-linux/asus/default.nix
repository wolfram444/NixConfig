{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules.nix
  ];

  nixpkgs.config.allowUnfree = true;
  # Bootloader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "asus"; # Define your hostname.
  boot.loader.grub.devices = [ "nodev" ];

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

  virtualisation.docker = {
    enable = true;
  };

  programs.nix-data = {
    enable = true;
    # systemconfig = "/home/bahrom/workplace/bahrom04/nix-config/systems/x86_64-linux/matax/default.nix"
    systemconfig = "/home/wolf4am/NixConfig/systems/x86_64-linux/asus/default.nix";
    flake = "/home/wolf4am/NixConfig/flake.nix";
    flakearg = "asus";
  };

  systemd.services.garage-webui = {
    description = "Garage Web UI";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.garage-webui}/bin/garage-webui";
      Restart = "on-failure";
      RestartSec = "5s";
      DynamicUser = true;
    };
    environment = {
      PORT = "3905";
    };

  };

  system.stateVersion = "25.11"; # Do not change it!!
}

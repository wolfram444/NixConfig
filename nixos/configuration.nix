{ config, pkgs, lib, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];



  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "nixos"; # Define your hostname.
  

  #Flake
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Tashkent";

  # Select internationalisation properties.
  i18n.defaultLocale = "ru_RU.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  


  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.defaultUserShell = pkgs.zsh;
  users.users.wolf4am = {
    isNormalUser = true;
    description = "Xabib";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];  
    
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    vscode
    telegram-desktop
    neofetch
    htop
    vim
  ];

  

  system.stateVersion = "25.11"; # Do not change it!!

}

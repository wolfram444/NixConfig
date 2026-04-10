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
    inputs.xinux-modules.nixosModules.branding
    inputs.xinux-modules.nixosModules.kernel
    inputs.xinux-modules.nixosModules.xinux
    inputs.xinux-modules.nixosModules.gnome
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Tashkent";

  #swap for RAM
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024; # 16 GB
    }
  ];

  # Select internationalisation properties.
  i18n.defaultLocale = "ru_RU.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

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

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs = {
    config.allowUnfree = true;
  };

  nix = {
    enable = true;
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    # Garbage collector.
    gc = {
      automatic = true;
      options = "--delete-older-than 10d";
    };

    settings = {
      # download-buffer-size = 524288000; # 500 MiB to prevent buffer warnings

      experimental-features = "nix-command flakes pipe-operators";
      substituters = [
        "https://cache.xinux.uz/"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "cache.xinux.uz:BXCrtqejFjWzWEB9YuGB7X2MV4ttBur1N8BkwQRdH+0=" # xinux
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
      trusted-users = [
        "root"
        "wolf4am"
        "@wheel"
      ];
    };
  };

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    vscode
    telegram-desktop
    htop
    vim
    rustc
    cargo
    rustfmt
    gcc
    docker-compose
    docker
    fractal
    prismlauncher
    github-desktop
    jdk8_headless
    direnv
    fastfetch
    garage-webui
    e-imzo-manager
    # garage_2
    google-chrome
    # (pkgs.callPackage /home/wolf4am/WorkPlace/xinux/upstream/pkgs/by-name/e-/e-imzo/package.nix { })

  ];

  services.e-imzo.enable = true;

  services.garage = {
    enable = true;
    package = pkgs.garage;

    settings = {
      replication_mode = "2";
      data_dir = "/var/lib/garage/data";
      metadata_dir = "/var/lib/garage/meta";
      db_engine = "sqlite";

      rpc_bind_addr = "0.0.0.0:3901";
      rpc_secret = "b8ed42b061bee4500b4fbe783ef87b2be78a8e58fdb6318278c9ee492c408c27";
      rpc_public_addr = "127.0.0.1:3901";

      s3_api = {
        s3_region = "garage";
        bind_addr = "0.0.0.0:3900";
      };

      admin = {
        api_bind_addr = "0.0.0.0:3903";
        admin_token = "tw6yNoVNtG28Qgv48nwF2YA7rGzphRZ5PuwcWFFXqZk=";
        metrics_token = "d8eCFmyqMf+nWKDqpI90cqXATEWTPLRE0V3DzyJMz3k=";
      };
    };
  };

  hardware = {
    graphics = {
      enable = true;
    };

    nvidia = {
      open = false;
      modesetting.enable = true;
      nvidiaSettings = false;
      powerManagement.enable = true;
    };

    bluetooth.settings = {
      General = {
        Experimental = true;
      };
    };
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  virtualisation.docker.enable = true;

  system.stateVersion = "25.11"; # Do not change it!!
}

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
    # inputs.penpot.nixosModules.default
  ];

  nixpkgs.config.allowUnfree = true;
  networking.hostName = "asus"; # Define your hostname.

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
      "docker"
    ];
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  services.asterisk = {
    enable = true;

    confFiles = {
      "pjsip.conf" = ''
        [transport-udp]
        type=transport
        protocol=udp
        bind=0.0.0.0:5060


        [1001]
        type=endpoint
        context=internal
        disallow=all
        allow=ulaw,alaw,opus
        direct_media=no
        auth=1001
        aors=1001


        [1001]
        type=auth
        auth_type=userpass
        username=1001
        password=passwd

        [1001]
        type=aor
        max_contacts=1
        remove_existing=yes

        [1002]
        type=endpoint
        context=internal
        direct_media=no
        disallow=all
        allow=ulaw,alaw,opus
        auth=1002
        aors=1002


        [1002]
        type=auth
        auth_type=userpass
        username=1002
        password=passwd

        [1002]
        type=aor
        max_contacts=1
        remove_existing=yes
      '';

      "extensions.conf" = ''
        [internal]
        exten => 1001,1,Dial(PJSIP/1001,20)
         same => n,Hangup()

        exten => 1002,1,Dial(PJSIP/1002,20)
         same => n,Hangup()
      '';
    };
  };

  networking.firewall = {
    allowedUDPPorts = [ 5060 ]; # SIP
    allowedUDPPortRanges = [
      {
        from = 10000;
        to = 20000;
      } # RTP
    ];
  };

  networking.hosts = {
    "135.181.165.24" = [ "search.funksiyachi.uz" ];
    "127.0.0.1" = [ "penpot.uz" ];
  };

  virtualisation.docker = {
    enable = true;
  };

  time.timeZone = "Asia/Tashkent";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  programs.nix-data = {
    enable = true;
    # systemconfig = "/home/bahrom/workplace/bahrom04/nix-config/systems/x86_64-linux/matax/default.nix"
    systemconfig = "/home/wolf4am/NixConfig/systems/x86_64-linux/asus/default.nix";
    flake = "/home/wolf4am/NixConfig/flake.nix";
    flakearg = "asus";
  };

  # systemd.services.garage-webui = {
  #   description = "Garage Web UI";
  #   after = [ "network.target" ];
  #   wantedBy = [ "multi-user.target" ];

  #   serviceConfig = {
  #     ExecStart = "${pkgs.garage-webui}/bin/garage-webui";
  #     Restart = "on-failure";
  #     RestartSec = "5s";
  #     DynamicUser = true;
  #   };
  #   environment = {
  #     PORT = "3905";
  #   };

  # };

  networking.firewall.allowedTCPPorts = [ 25565 ];

  system.stateVersion = "25.11"; # Do not change it!!
  environment.systemPackages = [
    pkgs.zed-editor
    pkgs.gnome-secrets
  ];
}

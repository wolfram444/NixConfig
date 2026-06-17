{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024; # 16 GB
    }
  ];
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/50bb533f-8277-43e8-944b-c06d5b9d947d";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/CAC1-254C";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  # default 50% ram
  zramSwap = {
    enable = true;
    priority = 100;
  };

  # https://github.com/sched-ext/scx/blob/main/INSTALL.md#nix
  services.scx = {
    enable = true;
    # scheduler = "scx_lavd"; # default is "scx_rustland"
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot = {
    kernelPackages = pkgs.linux-cachyos-latest-lto-x86_64-v3;
    supportedFilesystems = [ "ntfs" ];
    consoleLogLevel = 3;
    initrd.systemd.enable = true;
    initrd.verbose = false;

    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "systemd.show_status=auto"
      "intel_pstate=active"
    ];
    kernel.sysctl = {
      "vm.dirty_ratio" = 10;
      "vm.dirty_background_ratio" = 5;
      "vm.watermark_boost_factor" = 0;
      "vm.page-cluster" = 0;
      "net.core.default_qdisc" = "fq";
      "net.ipv4.tcp_congestion_control" = "bbr";
    };

    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];

    kernelModules = [
      "kvm-amd"
      "fuse"
      "nvme"
    ];
    initrd.kernelModules = [ ]; # "nvme"
  };

  # nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  # Hardware optimized compilation
  # https://nixos.wiki/wiki/Build_flags
  nix.settings.system-features = [
    "nixos-test"
    "benchmark"
    "big-parallel"
    "kvm"
    "gccarch-znver3"
    "gccarch-x86-64-v3"
    "gccarch-x86-64-v2"
    "gccarch-x86-64"
  ];
  nixpkgs.localSystem = {
    gcc.arch = "znver3";
    gcc.tune = "znver3";
    system = "x86_64-linux";
  };
  services.thermald.enable = true;

  #For nvidia GPU
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
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
}

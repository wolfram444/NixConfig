{ pkgs, ... }:
{
  # List packages installed in system profile. To search, run:
  home.packages = with pkgs; [
    ayugram-desktop
    starship
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
    # garage-webui
    google-chrome
    element-desktop
    # (pkgs.callPackage /home/wolf4am/WorkPlace/xinux/upstream/pkgs/by-name/e-/e-imzo/package.nix { })5
  ];
}

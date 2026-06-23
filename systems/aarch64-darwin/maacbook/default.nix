{ lib, pkgs, ... }:

{
  system.stateVersion = 5;


  environment.systemPackages = with pkgs; [
    vim
    fastfetch
    htop
  ];

      

  security.pam.services.sudo_local.touchIdAuth = true;
  nix.settings.experimental-features = [ "nix-command" "flakes"  "pipe-operators"];
  
}
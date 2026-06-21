{ lib, pkgs, ... }:

{
  system.stateVersion = 5;


  environment.systemPackages = with pkgs; [
    vim
    fastfetch
    htop
    
  ];

  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
}
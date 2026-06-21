{ lib, pkgs, ... }:

{
  system.stateVersion = 5;


  environment.systemPackages = with pkgs; [
    git
    vim
    htop
    
  ];

  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
}
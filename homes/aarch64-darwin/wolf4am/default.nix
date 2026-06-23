{ lib, pkgs, ... }:

{
  home.stateVersion = "26.05";
  home.username = "wolf4am";
  home.homeDirectory = "/Users/wolf4am";



  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

}
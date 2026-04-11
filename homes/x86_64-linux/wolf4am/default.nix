{ ... }:
{

  home = {
    stateVersion = "25.11";
    username = "wolf4am";
    enableNixpkgsReleaseCheck = false;
  };

  # Let's enable home-manager
  programs.home-manager.enable = true;

}

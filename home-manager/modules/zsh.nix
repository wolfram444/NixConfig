{
  config,
  pkgs,
  ...
}: {
  programs.zoxide.enable = true;
  programs.zoxide.enableFishIntegration = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    initContent = ''
      eval "$(starship init zsh)"
      eval "$(direnv hook zsh)"

    '';

    shellAliases = {
      cls = "clear";
    };
  };
}

{
  config,
  pkgs,
  ...
}: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
    add_newline = false;

    format = "$directory$git_branch$git_status$character";

    directory = {
      style = "white";
      truncation_length = 3;
      truncation_symbol = "…/";
    };

    git_branch = {
      symbol = " ";
      style = "bold purple";
    };

    git_status = {
      style = "red";
    };

    character = {
      success_symbol = "[❯](bold green)";
      error_symbol = "[❯](bold red)";
    };
  };
  };
}

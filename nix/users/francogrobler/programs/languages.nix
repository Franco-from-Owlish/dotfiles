{ pkgs }:
{
  programs = {
    go = {
      enable = true;
      goPath = "$HOME/.go";
      telemetry = {
        mode = "on";
      };
    };

    java = {
      enable = true;
      package = pkgs.jre;
    };
  };
}

{ inputs, pkgs, ... }:

{
  homebrew = {
    enable = true;
    casks  = [
      "1password"
      "discord"
      "google-chrome"
      "istat-menus"
      "slack"
      "skim"
    ];
  };

  # The user should already exist, but we need to set this up so Nix knows
  # what our home directory is (https://github.com/LnL7/nix-darwin/issues/423).
  users.users.francogrobler = {
    home = "/Users/francogrobler";
    shell = pkgs.zsh;
  };

  # Required for some settings like homebrew to know what user to apply to.
  system.primaryUser = "francogrobler";
}

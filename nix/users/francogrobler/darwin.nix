{ inputs, pkgs, ... }:

{
  homebrew = {
    enable = true;
    brews = [ "mas" ];
    casks = [
      "1password"
      "adobe-acrobat-reader"
      "discord"
      "ghostty"
      "google-chrome"
      "istat-menus"
      "slack"
      "skim"
    ];
    caskArgs = {
      appdir = "$HOME/Applications";
      language = "en-ZA,en-GB";
      require_sha = true;
    };
    global = {
      autoUpdate = true;
      brewfile = true;
    };
    masApps = {
      "1Password for Safari" = 1569813296;
      Xcode = 497799835;
    };
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = false;
    };
  };

  # Required for some settings like homebrew to know what user to apply to.
  system.primaryUser = "francogrobler";

  security.pam.services.sudo_local = {
    enable = true;
    reattach = true;
    touchIdAuth = true;
    watchIdAuth = true;
  };

  # The user should already exist, but we need to set this up so Nix knows
  # what our home directory is (https://github.com/LnL7/nix-darwin/issues/423).
  users.users.francogrobler = {
    home = "/Users/francogrobler";
    shell = pkgs.zsh;
  };
}

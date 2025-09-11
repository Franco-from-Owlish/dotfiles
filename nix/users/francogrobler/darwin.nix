{ inputs, pkgs, ... }:

{
  homebrew = {
    enable = true;
    brews = [
      "cocoapods"
      "gemini-cli"
      "llvm"
      "mas"
    ];
    casks = [
      "1password"
      "adobe-acrobat-reader"
      "alacritty"
      "balenaetcher"
      "discord"
      "flutter"
      "freecad"
      "ghostty"
      "google-chrome"
      "keka"
      "podman-desktop"
      "slack"
      "skim"
      "vial"
    ];
    caskArgs = {
      appdir = "~/Applications";
      language = "en-ZA,en-GB";
      # Initial chrome installs fails - no sha is specified for the cask recipe.
      require_sha = true;
    };
    global = {
      autoUpdate = true;
      brewfile = true;
    };
    masApps = {
      "1Password for Safari" = 1569813296;
      Wireguard = 1451685025;
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

  system = {
    defaults = {
      finder = {
        AppleShowAllExtensions = true;
        FXPreferredViewStyle = "Nlsv";
        FXRemoveOldTrashItems = true;
        NewWindowTarget = "iCloud Drive";
        ShowExternalHardDrivesOnDesktop = true;
        ShowHardDrivesOnDesktop = true;
        ShowMountedServersOnDesktop = true;
        ShowPathbar = true;
        ShowStatusBar = true;
      };
      iCal = {
        "TimeZone support enabled" = true;
        "first day of week" = "Monday";
      };
      menuExtraClock = {
        FlashDateSeparators = true;
        IsAnalog = false;
        Show24Hour = true;
        ShowDate = 0;
        ShowDayOfMonth = true;
        ShowDayOfWeek = true;
        ShowSeconds = true;
      };
      screencapture = {
        location = "~/Desktop/";
        target = "file";
      };
      trackpad = {
        Clicking = true;
        FirstClickThreshold = 1;
        SecondClickThreshold = 1;
        TrackpadRightClick = true;
        TrackpadThreeFingerDrag = true;
      };
    };
    # TODO: This fucks up external keyboards.
    keyboard = {
      enableKeyMapping = true;
      swapLeftCtrlAndFn = false;
    };
    startup.chime = false;
  };

  time.timeZone = "Africa/Johannesburg";

  # The user should already exist, but we need to set this up so Nix knows
  # what our home directory is (https://github.com/LnL7/nix-darwin/issues/423).
  users.users.francogrobler = {
    description = "Franco Grobler";
    home = "/Users/francogrobler";
    shell = pkgs.zsh;
  };
}

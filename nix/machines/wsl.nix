{ pkgs, currentSystemUser, config, ... }: {
  imports = [ ];

  wsl = {
    enable = true;
    wslConf = {
      automount = { root = "/mnt"; };
    };
    defaultUser = currentSystemUser;
    startMenuLaunchers = true;
  };

  nix = {
    package = pkgs.nixVersions.latest;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  system.stateVersion = "25.05";
}

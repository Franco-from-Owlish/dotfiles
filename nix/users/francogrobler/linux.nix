{ pkgs, inputs, ... }:

{
  # Add ~/.local/bin to PATH
  environment.localBinInPath = true;

  users.users.francogrobler = {
    isNormalUser = true;
    home = "/home/francogrobler";
    extraGroups = [ "docker" "lxd" "wheel" ];
    shell = pkgs.zsh;
  };
}

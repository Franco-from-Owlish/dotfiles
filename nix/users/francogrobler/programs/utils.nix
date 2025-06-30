{
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 2";
    flake = "~/dotfiles/nix/flake.nix";
  };
}

{ osConfig, systemName }: {
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 2";
    };
    flake = "$HOME/dotfiles/nix#${osConfig}.${systemName}";
  };
}

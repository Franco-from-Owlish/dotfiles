{ isWSL, inputs, ... }:

{ config, lib, pkgs, ... }:

let
  # sources = import ../../nix/sources.nix;
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;

  shellAliases = {
    cl = "clear";
    ".." = "cd ..";
    "..." = "cd ../..";
    justg = "just --global-justfile";
    l = "eza -l --icons --git -a";
    lt = "eza --tree --level=2 --long --icons --git";
    ltree = "eza --tree --level=2  --icons --git";
  } // (if isLinux then {
    pbcopy = "xclip";
    pbpaste = "xclip -o";
  } else { });

  # For our MANPAGER env var
  # https://github.com/sharkdp/bat/issues/1145
  manpager = (pkgs.writeShellScriptBin "manpager" (if isDarwin then ''
    sh -c 'col -bx | bat -l man -p'
  '' else ''
    cat "$1" | col -bx | bat --language man --style plain
  ''));

  currentDir = builtins.path { path = ./.; };

  globalPrograms = [
    (import "${currentDir}/programs/clis.nix")
    (import "${currentDir}/programs/shells.nix" { inherit shellAliases; })
    (import "${currentDir}/programs/utils.nix")
    (import "${currentDir}/programs/vsc.nix")
  ];
in
{
  home.stateVersion = "25.05";

  xdg.enable = true;

  #---------------------------------------------------------------------
  # Packages
  #---------------------------------------------------------------------

  # Packages I always want installed. Most packages I install using
  # per-project flakes sourced with direnv and nix-shell, so this is
  # not a huge list.
  home.packages = [
    pkgs._1password-cli
    pkgs.alacritty
    pkgs.bat
    pkgs.bottom
    pkgs.btop
    pkgs.cmatrix
    pkgs.cowsay
    pkgs.docker
    pkgs.eza
    pkgs.fastfetch
    pkgs.fd
    pkgs.fzf
    pkgs.gh
    pkgs.glow
    pkgs.htop
    pkgs.just
    pkgs.jq
    pkgs.lazydocker
    pkgs.lazygit
    pkgs.lolcat
    pkgs.neovim
    pkgs.nodejs
    pkgs.podman
    pkgs.podman-desktop
    pkgs.podman-tui
    pkgs.ripgrep
    pkgs.sentry-cli
    pkgs.thefuck
    pkgs.tree
    pkgs.tmux
    pkgs.yazi
    pkgs.zoxide

    pkgs.nerd-fonts.jetbrains-mono
  ] ++ (lib.optionals (isLinux) [
    pkgs.chromium
    pkgs.firefox
    pkgs.ghostty # macos installer is broken
    pkgs.rofi
    pkgs.valgrind
    pkgs.zathura
  ]);

  #---------------------------------------------------------------------
  # Env vars and dotfiles
  #---------------------------------------------------------------------

  home.sessionVariables = {
    LANG = "en_ZA.UTF-8";
    LC_CTYPE = "en_ZA.UTF-8";
    LC_ALL = "en_ZA.UTF-8";
    EDITOR = "nvim";
    PAGER = "less -FirSwX";
    MANPAGER = "${manpager}/bin/manpager";
  } // (if isDarwin then {
    # See: https://github.com/NixOS/nixpkgs/issues/390751
    DISPLAY = "nixpkgs-390751";
  } else { });

  #---------------------------------------------------------------------
  # Programs
  #---------------------------------------------------------------------

  imports = globalPrograms;

  programs.gpg.enable = !isDarwin;

  programs.go = {
    enable = true;
    goPath = "$HOME/.go";
  };

  #---------------------------------------------------------------------
  # Services
  #---------------------------------------------------------------------

  services.gpg-agent = {
    enable = isLinux;
    pinentry.package = pkgs.pinentry-tty;

    # cache the keys forever so we don't get asked for a password
    defaultCacheTtl = 31536000;
    maxCacheTtl = 31536000;
  };

  xresources.extraConfig = builtins.readFile ./config/Xresources;

  # Make cursor not tiny on HiDPI screens
  home.pointerCursor = lib.mkIf (isLinux && !isWSL) {
    name = "Vanilla-DMZ";
    package = pkgs.vanilla-dmz;
    size = 128;
    x11.enable = true;
  };
}

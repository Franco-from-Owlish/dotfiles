{ isWSL, inputs, systemName, ... }:

{ config, lib, pkgs, ... }:

let
  # sources = import ../../nix/sources.nix;
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;

  osConfig = if isDarwin then "darwinConfigurations" else if isLinux then "nixosConfigurations" else "homeConfigurations";

  shellAliases = {
    cl = "clear";
    ".." = "cd ..";
    "..." = "cd ../..";
    justg = "just --global-justfile";
    l = "eza -l --icons --git -a";
    lt = "eza --tree --level=2 --long --icons --git";
    ltree = "eza --tree --level=2  --icons --git";

    "gemini-cli" = "op run -- gemini";
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
    (import "${currentDir}/programs/i3.nix" { isLinux = isLinux; isWSL = isWSL; })
    (import "${currentDir}/programs/shells.nix" { inherit shellAliases; })
    (import "${currentDir}/programs/utils.nix" { inherit osConfig systemName; })
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
    pkgs.ookla-speedtest
    pkgs.podman
    pkgs.podman-tui
    pkgs.ripgrep
    pkgs.rustup
    pkgs.sentry-cli
    pkgs.stow
    pkgs.thefuck
    pkgs.tree
    pkgs.tmux
    pkgs.yazi
    pkgs.zoxide

    pkgs.nerd-fonts.jetbrains-mono
  ] ++ (lib.optionals (!isWSL) [
    # GUI apps
    pkgs.alacritty
    pkgs.podman-desktop
  ]) ++ (lib.optionals (!isDarwin) [
    pkgs.gemini-cli # macos installer not availble
  ]) ++ (lib.optionals (isLinux && !isWSL) [
    pkgs.chromium
    pkgs.firefox
    pkgs.freecad-wayland
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

    GEMINI_API_KEY = "op://Personal/Gemini CLI/credential";
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

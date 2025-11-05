{ shellAliases }:
{
  programs = {
    bash = {
      enable = true;
      shellOptions = [ "vi" ];
      historyControl = [
        "ignoredups"
        "ignorespace"
      ];
      inherit shellAliases;
    };

    nushell = {
      enable = true;
      settings = {
        edit_mode = "vi";
      };
      inherit shellAliases;
    };

    zsh = {
      enable = true;
      autosuggestion = {
        enable = true;
      };
      defaultKeymap = "vicmd";
      initContent = ''
        # Nix
        if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
          . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
        fi
        # End Nix

        # Dotfiles
        source "$HOME/.config/zsh/zshrc"
      '';
      syntaxHighlighting = {
        enable = true;
      };
      inherit shellAliases;
    };
  };
}

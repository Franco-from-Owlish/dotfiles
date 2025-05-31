{
  description = "Nix configuration";

  inputs = {
    # Default to stable, use unstable for some packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, darwin, ... }@inputs: let
    # Overlays is the list of overlays we want to apply from flake inputs.
    overlays = [
      (final: prev: rec {
        # gh CLI on stable has bugs.
        gh = inputs.nixpkgs-unstable.legacyPackages.${prev.system}.gh;

        # Latest version of these
        nushell = inputs.nixpkgs-unstable.legacyPackages.${prev.system}.nushell;
      })
    ];

    mkSystem = import ./lib/mksystem.nix {
      inherit overlays nixpkgs inputs;
    };
  in {
      darwinConfigurations.apple-silicone = mkSystem "apple-silicone" {
      system = "aarch64-darwin";
      user   = "francogrobler";
      darwin = true;
    };
  };
}

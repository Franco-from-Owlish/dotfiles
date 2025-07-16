set export := true

default:
    just --list

# Generate Changelog
[group('Chores')]
generate-changelog:
    git cliff -r .

# Add pre-push hook
[group('Git')]
add-hooks:
    cp pre-push.sh .git/hooks/pre-push

# Remove all symlinks
[group('Stow')]
unlink:
    stow -D .

# Update home manager.
[group('Nix')]
[working-directory("nix")]
nix-switch:
    #!/usr/bin/env bash
    set -euo pipefail
    . ../_scripts/set_nix_envs.sh
    echo "Update nix config with: "
    printenv | grep "^NIX[^_]"
    nix build ".#${NIXCONFIG}.${NIXNAME}.system"
    sudo ./result/sw/bin/darwin-rebuild switch --flake "$(pwd)#${NIXNAME}"

# Test home manager flake.
[group('Nix')]
[working-directory("nix")]
nix-test:
    #!/usr/bin/env bash
    set -euxo pipefail
    . ../_scripts/set_nix_envs.sh
    echo "Test nix config with: "
    printenv | grep "^NIX[^_]"
    nix build ".#${NIXCONFIG}.${NIXNAME}.system"
    sudo ./result/sw/bin/darwin-rebuild test --flake "$(pwd)#${NIXNAME}"

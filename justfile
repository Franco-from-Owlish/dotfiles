set export := true

HOMEBREW_LEAVES := "homebrew/leaves.txt"

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

# Sort homebrew leaves
[group('Chores')]
sort-leaves:
    sort ${HOMEBREW_LEAVES} -o ${HOMEBREW_LEAVES}

# Update homebrew leaves
[group('Homebrew')]
update-leaves:
    brew leaves > ${HOMEBREW_LEAVES}

# Compare installed vs listed
[group('Homebrew')]
compare-leaves:
    #!/usr/bin/env bash
    diff --color -u homebrew/leaves.txt <(brew leaves)

# See leaves not installed but listed
[group('Homebrew')]
installable-leaves:
    #!/usr/bin/env bash
    comm -23 homebrew/leaves.txt <(brew leaves)

# See leaves installed but not listed
[group('Homebrew')]
unlisted-leaves:
    #!/usr/bin/env bash
    comm -13 homebrew/leaves.txt <(brew leaves)

# Remove all symlinks
[group('Stow')]
unlink:
    stow -D .

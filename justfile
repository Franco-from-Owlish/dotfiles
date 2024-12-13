set export := true

HOMEBREW_LEAVES := "homebrew/leaves.txt"

default:
    just --list

# Generate Changelog
[group('Chores')]
generate-changelog:
    git cliff -r .

# Sort homebrew leaves
[group('Chores')]
sort-leaves:
    sort ${HOMEBREW_LEAVES} -o ${HOMEBREW_LEAVES}

# Update homebrew leaves
[group('Homebrew')]
update-leaves:
    brew leaves > ${HOMEBREW_LEAVES}

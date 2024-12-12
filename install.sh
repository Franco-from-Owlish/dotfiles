#!/usr/bin/env bash

# Check if zshrc is source by ~/.zshrc
config="source $HOME/.config/zsh/zshrc"
read -r -d '' message << EOM
# Dotfiles ZSH config
${config}
EOM
zshrc="$HOME/.zshrc"
grep -qxF "$config" "$zshrc" || echo "$message" >> "$zshrc"

stow .

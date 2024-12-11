#!/bin/bash 

# Check if zshrc is source by ~/.zshrc
config="source $HOME/.config/zsh/zshrc"
zshrc="$HOME/.zshrc"
grep -qxF "$config" "$zshrc" || echo "$config" >> "$zshrc"

stow .

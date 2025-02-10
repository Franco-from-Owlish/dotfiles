#!/usr/bin/env bash

# Check if zshrc is source by ~/.zshrc
config="source $HOME/.config/zsh/zshrc"
read -r -d '' message <<EOM
# Dotfiles ZSH config
${config}
EOM
zshrc="$HOME/.zshrc"
grep -qxF "$config" "$zshrc" || echo "$message" >>"$zshrc"

# Create SOPS age key
sops_age_dir="sops/age"
if [[ ! -d ${sops_age_dir} ]]; then
  mkdir -p "${sops_age_dir}"
  age-keygen -o "${sops_age_dir}/keys.txt" || true
  echo "*" >>"${sops_age_dir}/.gitignore"
fi

stow .

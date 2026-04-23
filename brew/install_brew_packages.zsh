#!/bin/zsh

set -euo pipefail

SCRIPT_DIR=${0:A:h}
FORMULAE_FILE="$SCRIPT_DIR/brew_formulae.txt"
CASKS_FILE="$SCRIPT_DIR/brew_casks.txt"

install_from_file() {
  local mode=$1
  local file=$2
  local line

  [[ -f "$file" ]] || return 0

  while IFS= read -r line; do
    [[ -z "$line" ]] && continue

    if [[ "$mode" == "cask" ]]; then
      brew install --cask "$line"
    else
      brew install "$line"
    fi
  done < "$file"
}

install_from_file formula "$FORMULAE_FILE"
install_from_file cask "$CASKS_FILE"

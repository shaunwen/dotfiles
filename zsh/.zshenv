[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
# Project roots for nvim snippets: PATH-like list of "prefix=dir" entries.
# Lives here, not .zshrc, so GUI launches (Neovide) inherit it too.
export PROJECT_ROOTS="sp=$HOME/workspace/projects/scalapay-repos"

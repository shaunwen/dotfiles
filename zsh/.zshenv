[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
# Machine-local env (e.g. PROJECT_ROOTS for nvim snippets) lives in an untracked
# file, sourced here rather than in .zshrc so GUI launches (Neovide) inherit it too.
[ -f "$HOME/.zshenv.local" ] && . "$HOME/.zshenv.local"

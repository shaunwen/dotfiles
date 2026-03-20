# dotfiles

Personal macOS development environment configs for tmux, Alacritty, Vim, IdeaVim, Karabiner, GitUI, Homebrew, and tmuxp.

## What is in this repo

- `.tmux.conf`: tmux tuned around a `C-a` prefix, Vim-style pane navigation, mouse support, clipboard integration, session restore, and `tmux-fzf`.
- `tmux-sessionizer`: fuzzy-picks a project directory, creates a tmux session if needed, and switches to it.
- `.config/tmuxp/payments.yaml`: saved tmuxp workspace for a payments-focused session layout.
- `.config/alacritty/alacritty.toml`: Catppuccin Macchiato Alacritty config with JetBrainsMono Nerd Font and macOS-style keybindings.
- `.config/karabiner/karabiner.json`: keyboard remaps including `Caps Lock -> Esc` when tapped and `Caps Lock -> Ctrl` when held.
- `.config/gitui/theme.ron`: Catppuccin-flavoured GitUI theme.
- `.vimrc`: Vim config built around `vim-plug`, `gruvbox`, `fzf`, NERDTree, EasyMotion, surround, commentary, and language plugins.
- `.ideavimrc`: IdeaVim config that mirrors many Vim motions and adds IntelliJ action mappings.
- `brew/brew_packages.txt`: package list for CLI tools and desktop apps.
- `brew/install_brew_packages.zsh`: helper script to install the Homebrew package list.

Neovim configuration lives in a separate repository: [shaunwen/nvim](https://github.com/shaunwen/nvim).

## Setup

This repository contains a mix of portable config and machine-specific paths. Before using it on another machine, update hard-coded directories in:

- `tmux-sessionizer`
- `.config/tmuxp/payments.yaml`

Link the tracked files into place with something like:

```sh
mkdir -p ~/.config/alacritty ~/.config/gitui ~/.config/karabiner ~/.config/tmuxp ~/.local/bin

ln -sfn "$PWD/.tmux.conf" ~/.tmux.conf
ln -sfn "$PWD/.vimrc" ~/.vimrc
ln -sfn "$PWD/.ideavimrc" ~/.ideavimrc
ln -sfn "$PWD/tmux-sessionizer" ~/.local/bin/tmux-sessionizer
ln -sfn "$PWD/.config/alacritty/alacritty.toml" ~/.config/alacritty/alacritty.toml
ln -sfn "$PWD/.config/gitui/theme.ron" ~/.config/gitui/theme.ron
ln -sfn "$PWD/.config/karabiner/karabiner.json" ~/.config/karabiner/karabiner.json
ln -sfn "$PWD/.config/tmuxp/payments.yaml" ~/.config/tmuxp/payments.yaml
```

To install the Homebrew package set:

```sh
cd brew
./install_brew_packages.zsh
```

The package list includes the main tools this repo expects, such as `tmux`, `tmuxp`, `fzf`, `ripgrep`, `fd`, `gitui`, `alacritty`, `karabiner-elements`, and `font-jetbrains-mono-nerd-font`.

## Tmux

### Current tracked setup

The current `.tmux.conf` includes:

- `C-a` as the prefix instead of `C-b`
- pane splitting with `prefix + s` and `prefix + v`
- pane movement with `h`, `j`, `k`, `l`
- pane resizing with arrow keys
- `prefix + r` to reload config
- `prefix + e` to kill all other panes
- mouse support and `vi` copy mode
- clipboard support with `set -g set-clipboard on`
- TPM plugins:
  - `tmux-plugins/tpm`
  - `tmux-plugins/tmux-resurrect`
  - `tmux-plugins/tmux-continuum`
  - `sainnhe/tmux-fzf`
- `prefix + f` bound to the sessionizer script installed at `~/.local/bin/tmux-sessionizer`

Install TPM with:

```sh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### Notes folded in from `tmux.md`

Useful tmux and tmuxp commands:

- save a session layout with tmuxp:
  `tmuxp freeze payments -f yaml -o ~/.config/tmuxp/payments.yaml`
- load a configured tmuxp session:
  `tmuxp load payments`
- kill a tmux session:
  `tmux kill-ses -t payments`

Quickly kill a session selected through `fzf`:

```sh
session=$(tmux list-sessions | fzf | cut -d ':' -f 1)
if [[ -n "$session" ]]; then
  tmux kill-session -t "$session"
fi
```

For mouse copy on macOS, these notes are still useful if you want explicit `pbcopy` integration in copy mode:

```tmux
unbind -T copy-mode MouseDragEnd1Pane
bind-key -T copy-mode-vi MouseDragEnd1Pane send -X copy-pipe-and-cancel "reattach-to-user-namespace pbcopy"
```

Older optional plugin notes that are not currently enabled in the tracked `.tmux.conf`:

```tmux
set -g @plugin 'christoomey/vim-tmux-navigator'
set -g @plugin 'jimeh/tmux-themepack'
set -g @themepack 'powerline/default/cyan'
```

## Alacritty

The Alacritty config uses:

- Catppuccin Macchiato colours
- `JetBrainsMono Nerd Font` at size `16`
- `TERM=xterm-256color`
- `Option` mapped as `Alt`
- macOS-style copy, paste, font scaling, fullscreen, and search shortcuts
- `selection.save_to_clipboard = true`
- scrollback history of `100000`

## Editor configs

`.vimrc` is the classic Vim setup in this repo. It uses `vim-plug`, `gruvbox`, FZF, NERDTree, EasyMotion, multiple cursors, commentary, and language support for JavaScript, TypeScript, GraphQL, and Rust.

`.ideavimrc` mirrors the same movement and editing style inside JetBrains IDEs, then layers on IntelliJ actions for navigation, refactoring, testing, debugging, and terminal access.

## Karabiner and GitUI

Karabiner currently handles:

- `Caps Lock` as `Escape` when tapped and `Left Control` when held
- `Ctrl + h/j/k/l` as arrow keys
- `fn` and `left_control` swaps on selected keyboards

GitUI uses a Catppuccin-style theme that matches the Alacritty palette.

## Notes

This repo no longer documents a tracked `.zshrc` because shell customisation is not currently versioned here. The main shell-related setup that remains in-repo is the Homebrew package list and the tmux/Vim tooling built on top of it.

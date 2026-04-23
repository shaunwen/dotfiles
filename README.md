# dotfiles

Personal macOS development environment configs for zsh, tmux, Alacritty, Vim, IdeaVim, Karabiner, GitUI, Homebrew, and tmuxp.

## Stow packages

This repo is organised as top-level GNU Stow packages:

- `zsh/.zshrc`
- `tmux/.tmux.conf`
- `tmux/.local/bin/tmux-sessionizer`
- `tmuxp/.config/tmuxp/payments.yaml`
- `alacritty/.config/alacritty/alacritty.toml`
- `gitui/.config/gitui/theme.ron`
- `karabiner/.config/karabiner/karabiner.json`
- `vim/.vimrc`
- `ideavim/.ideavimrc`

The `brew/` directory is repo support data, not a Stow package.

Neovim configuration lives in a separate repository: [shaunwen/nvim](https://github.com/shaunwen/nvim).

## Setup

This repository contains a mix of portable config and machine-specific paths. Before using it on another machine, update hard-coded directories in:

- `tmux/.local/bin/tmux-sessionizer`
- `tmuxp/.config/tmuxp/payments.yaml`

Create the parent directories first:

```sh
mkdir -p ~/.config/alacritty ~/.config/gitui ~/.config/karabiner ~/.config/tmuxp ~/.local/bin
```

Preview the Stow operations:

```sh
cd ~/dotfiles
stow -nv zsh tmux tmuxp vim ideavim alacritty gitui karabiner
```

If the dry-run is clean, apply it:

```sh
stow -Sv zsh tmux tmuxp vim ideavim alacritty gitui karabiner
```

If you already have unmanaged files in `$HOME`, Stow will report conflicts instead of overwriting them. In that case, either:

- move or back up the conflicting target files first, then rerun `stow -Sv ...`
- or use `stow -Sv --adopt ...` if you explicitly want Stow to import the current target files into the package layout

The current `zsh` package also restores the expected `~/dotfiles/zsh/.zshrc` target, so an existing `~/.zshrc -> ~/dotfiles/zsh/.zshrc` symlink becomes valid again once this repo layout is in place.

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

- `zsh/.zshrc` is tracked in this repo again and can be managed through Stow like the other packages.
- `brew/` stays as repo-local support data and should not be passed to `stow`.

BREW_PREFIX="${HOMEBREW_PREFIX:-$(brew --prefix 2>/dev/null)}"
_ZSHRC_DIR="${${(%):-%N}:A:h}"
fpath=(${fpath:#$HOME/.oh-my-zsh*})

# Native Zsh history — kept as a backup / fallback for Atuin
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_ALL_DUPS INC_APPEND_HISTORY

[[ -d "$_ZSHRC_DIR/.zsh/completions" ]] && fpath=("$_ZSHRC_DIR/.zsh/completions" $fpath)
[[ -n "$BREW_PREFIX" ]] && fpath=("$BREW_PREFIX/share/zsh-completions" $fpath)
zmodload zsh/complist 2>/dev/null
autoload -Uz compinit && compinit -C -i
autoload -Uz _uv _uvx
compdef _uv uv
compdef _uvx uvx
zstyle ':completion:*' menu select                       # arrow-key menu
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case-insensitive
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}    # colourful menu

[[ -r "$_ZSHRC_DIR/.zsh/ohmyzsh-git.plugin.zsh" ]] \
  && source "$_ZSHRC_DIR/.zsh/ohmyzsh-git.plugin.zsh"
unset _ZSHRC_DIR

bindkey -v
KEYTIMEOUT=100

# env / path / tools root
export EDITOR=nvim
#
export PKG_CONFIG_PATH="/opt/homebrew/opt/libffi/lib/pkgconfig"
export LDFLAGS="-L/opt/homebrew/opt/libffi/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libffi/include"
#
export GOPATH=$HOME/go
export GOROOT="$BREW_PREFIX/opt/go/libexec"
export ZK_NOTEBOOK_DIR="/Users/shaun.wen/Documents/myNotes"
# forgit configuration
# export FORGIT_GLO_FORMAT="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset"
# export FORGIT_PAGER='delta --side-by-side -w ${FZF_PREVIEW_COLUMNS:-$COLUMNS}'
export FORGIT_LOG_FORMAT="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ai) %C(bold blue)<%an>%Creset"
export FORGIT_LOG_GRAPH_ENABLE=false
export FORGIT_CHECKOUT_BRANCH_BRANCH_GIT_OPTS='--sort=-committerdate'
export FORGIT_WORKTREE_ADD_DIR="$HOME/workspace/projects/scalapay-repos/worktrees"
export FORGIT_LOG_FZF_OPTS=' --bind="ctrl-e:execute(echo {} |grep -Eo [a-f0-9]+ |head -1 |xargs git show |nvim -R -n -c \"setlocal nomodified bufhidden=wipe\" -)" '
export FORGIT_WORKTREE_FZF_OPTS="-s --scheme=path --delimiter=/ --with-nth='1,-1..' --prompt='Enter worktrees> '"
export FORGIT_WORKTREE_DELETE_FZF_OPTS="--delimiter=/ --with-nth=-1.. --prompt='Delete worktree(s)> '"
export FORGIT_STASH_FZF_OPTS='
    --bind="alt-a:execute(git stash apply $(cut -d: -f1 <<<{}))+refresh-preview"
    --bind="ctrl-p:execute(git stash pop $(cut -d: -f1 <<<{}))+reload(git stash list)"
    --bind="ctrl-d:reload(git stash drop $(cut -d: -f1 <<<{}) 1>/dev/null && git stash list)"
  '
# make zoxide use fzf
export _ZO_FZF_OPTS="
--height=50%
--layout=reverse
--border
--info=inline
--prompt='Jump ❯ '
"
export PATH="$PATH:/Users/shaun.wen/.yarn/bin:/usr/local/mysql/bin:/Users/shaun.wen/workspace/bin:/Users/shaun.wen/.config/yarn/global/node_modules/.bin:${GOPATH}/bin:${GOROOT}/bin:$BREW_PREFIX/bin:$HOME/.cargo/bin:/usr/local/bin"
export PATH="$PATH:/Applications/IntelliJ IDEA.app/Contents/MacOS"
export PATH="$PATH:/Users/shaun.wen/.kit/bin"
export PATH="/opt/homebrew/bin/nvim:$PATH"
export NVM_DIR=~/.nvm
export WASMTIME_HOME="$HOME/.wasmtime"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$WASMTIME_HOME/bin:$PATH"
path=("$PYENV_ROOT/shims" ${path:#$PYENV_ROOT/shims})
#
. "$HOME/.local/bin/env"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"

_nvm_lazy_load() {
  unset -f nvm node npm npx corepack
  [[ -r "$BREW_PREFIX/opt/nvm/nvm.sh" ]] && source "$BREW_PREFIX/opt/nvm/nvm.sh"
}

nvm() {
  _nvm_lazy_load
  nvm "$@"
}

node() {
  _nvm_lazy_load
  node "$@"
}

npm() {
  _nvm_lazy_load
  npm "$@"
}

npx() {
  _nvm_lazy_load
  npx "$@"
}

corepack() {
  _nvm_lazy_load
  corepack "$@"
}

_pyenv_lazy_load() {
  unset -f pyenv
  eval "$(command pyenv init - --no-rehash zsh)"
  eval "$(command pyenv virtualenv-init - 2>/dev/null)"
}

pyenv() {
  _pyenv_lazy_load
  pyenv "$@"
}

# aliases
alias mbrew="arch -arm64 brew"
#
if command -v gls >/dev/null 2>&1; then
  alias l='gls -lah --color=auto'
  alias la='gls -lAh --color=auto'
  alias ll='gls -lh --color=auto'
else
  alias l='ls -lah'
  alias la='ls -lAh'
  alias ll='ls -lh'
fi
#
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias md='mkdir -p'
alias rd='rmdir'
alias vi="nvim"
alias cdswap="cd ~/.local/state/nvim/swap"
alias e="direnv allow"
alias vz="vi ~/.zshrc"
alias fcd='cd $(ls|fzf)'
alias qr="qrencode -t ansiutf8"
# git related alias
alias gpra="git pull --rebase --autostash"
alias gpf="git push --force"
alias gfpush="ggpush --force"
alias glab="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias delMergedToDev="git branch --merged develop | grep -v "develop" | xargs -n 1 git branch -d"
alias delMergedToMaster="git branch --merged master | grep -v "master" | xargs -n 1 git branch -d"
alias gpwd='echo "branch $(git_current_branch) in $(pwd)" | pbcopy'
alias addKey='eval $(ssh-agent) && ssh-add --apple-use-keychain ~/.ssh/id_ed25519_gh'
#
alias backupnotes="gcam \"notes backup: \$(date +'%Y-%m-%d-%H:%M')\""
#
alias cc="clang"
alias vik="NVIM_APPNAME=kickstart nvim"
alias vir="NVIM_APPNAME=NvChad-rust nvim"
# scalapay specific
alias ipj='cd "$( (find ~/workspace/projects/scalapay-repos -mindepth 1 -maxdepth 1 -type d; find ~/workspace/projects/scalapay-repos/rust -mindepth 1 -maxdepth 1 -type d 2>/dev/null) | fzf )"'
alias icd="source pj"
alias pj="cd ~/workspace/projects/scalapay-repos/"
alias sc="codex exec 'Create a single git commit for unstaged changes'"
alias sgc="CODEX_HOME=~/.codex-no-mcp codex exec 'use the skill named commit-work-general to create a git commit for unstaged changes'"
# markdown preview on CLI
alias gl="glow -s ~/.config/glow/styles/dark-customised.json"
alias gll="fd -e md -E README.md -E CHANGELOG.md | CLICOLOR_FORCE=1 fzf --preview 'glow -w 120 -s ~/.config/glow/styles/dark-customised.json {}' --preview-window=right:80%"
alias gl.="fd -e md -E README.md -E CHANGELOG.md | fzf | xargs glow -s ~/.config/glow/styles/dark-customised.json"

# init scripts
export FORGIT_PLUGIN="$BREW_PREFIX/share/forgit/forgit.plugin.zsh"
[ -f "$FORGIT_PLUGIN" ] && source "$FORGIT_PLUGIN"
#
[[ -r "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] \
  && source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
#
[[ -t 0 ]] && source <(fzf --zsh)
#
eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(atuin init zsh)"

# final manual bind overrides
#
#bindkey "ç" fzf-cd-widget # Option+c
# bindkey -M vicmd '^R' atuin-search-vicmd
#
# Accept autosuggestions with Tab, otherwise keep normal completion.
accept-autosuggestion-or-complete() {
  if [[ -n "$POSTDISPLAY" ]]; then
    zle autosuggest-accept
    return
  fi

  if (( $+functions[_zsh_autosuggest_fetch_suggestion] )) && [[ -n "$BUFFER" ]]; then
    unset suggestion
    _zsh_autosuggest_fetch_suggestion "$BUFFER"
    if [[ -n "$suggestion" && "$suggestion" == "$BUFFER"* && "$suggestion" != "$BUFFER" ]]; then
      BUFFER="$suggestion"
      CURSOR=$#BUFFER
      POSTDISPLAY=
      zle -R
      return
    fi
    unset suggestion
  else
    zle expand-or-complete
    return
  fi

  zle expand-or-complete
}
zle -N accept-autosuggestion-or-complete
bindkey -M viins '^I' accept-autosuggestion-or-complete
bindkey -M emacs '^I' accept-autosuggestion-or-complete
#
# Open buffer line in editor
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^g' edit-command-line
#
# Copy current command to clipboard
copy-command() {
  echo -n $BUFFER | pbcopy # or xolip
}
zle -N copy-command
bindkey '^xc' copy-command
# nvim switcher, select a nvim config to start
function vis() {
  items=("default" "kickstart" "NvChad-rust")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}
bindkey -s ^a "vis\n"

# local configuration
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"

# Keep syntax highlighting last so it can hook widgets defined above.
[[ -r "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] \
  && source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"


# Added by Antigravity CLI installer
export PATH="/Users/shaun.wen/.local/bin:$PATH"

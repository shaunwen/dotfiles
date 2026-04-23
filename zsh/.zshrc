# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

[ -f $HOMEBREW_PREFIX/share/forgit/forgit.plugin.zsh ] && source $HOMEBREW_PREFIX/share/forgit/forgit.plugin.zsh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

bindkey -v
export EDITOR=nvim

export PKG_CONFIG_PATH="/opt/homebrew/opt/libffi/lib/pkgconfig"
export LDFLAGS="-L/opt/homebrew/opt/libffi/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libffi/include"

export DISABLE_AUTO_TITLE='true'
export GOPATH=$HOME/go
export GOROOT="$(brew --prefix go)/libexec"
export ZK_NOTEBOOK_DIR="/Users/shaun.wen/Documents/myNotes"
# forgit configuration
#export FORGIT_GLO_FORMAT="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset"
#export FORGIT_PAGER='delta --side-by-side -w ${FZF_PREVIEW_COLUMNS:-$COLUMNS}' 
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

export PATH="$PATH:/Users/shaun.wen/.yarn/bin:/usr/local/mysql/bin:/Users/shaun.wen/workspace/bin:/Users/shaun.wen/.config/yarn/global/node_modules/.bin:${GOPATH}/bin:${GOROOT}/bin:$(brew --prefix)/bin:$HOME/.cargo/bin:/usr/local/bin"
export PATH="$PATH:/Applications/IntelliJ IDEA.app/Contents/MacOS"
export PATH="$WASMTIME_HOME/bin:$PATH"
export PATH="$PATH:/Users/shaun.wen/.kit/bin"
export PATH="/opt/homebrew/bin/nvim:$PATH"

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh


alias mbrew="arch -arm64 brew"

alias vi="nvim"
alias e="direnv allow"
alias vz="vi ~/.zshrc"
alias cdswap="cd ~/.local/state/nvim/swap"
alias gpra="git pull --rebase --autostash"
alias gpf="git push --force"
alias gfpush="ggpush --force"
alias glab="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias delMergedToDev="git branch --merged develop | grep -v "develop" | xargs -n 1 git branch -d"
alias delMergedToMaster="git branch --merged master | grep -v "master" | xargs -n 1 git branch -d"
alias qr="qrencode -t ansiutf8"
alias addKey='eval $(ssh-agent) && ssh-add --apple-use-keychain ~/.ssh/id_ed25519_gh'
alias fcd='cd $(ls|fzf)'
alias backupnotes="gcam \"notes backup: \$(date +'%Y-%m-%d-%H:%M')\""
alias gpwd='echo "branch $(git_current_branch) in $(pwd)" | pbcopy'

alias cc="clang"
alias vik="NVIM_APPNAME=kickstart nvim"
alias vir="NVIM_APPNAME=NvChad-rust nvim"
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

# scalapay specific
# alias ipj="cd \$(ls -d ~/workspace/projects/scalapay-repos/* | fzf)"
alias ipj='cd "$( (find ~/workspace/projects/scalapay-repos -mindepth 1 -maxdepth 1 -type d; find ~/workspace/projects/scalapay-repos/rust -mindepth 1 -maxdepth 1 -type d 2>/dev/null) | fzf )"'
alias icd="source pj"
alias pj="cd ~/workspace/projects/scalapay-repos/"
alias sc="codex exec 'Create a single git commit for unstaged changes'"
alias sgc="CODEX_HOME=~/.codex-no-mcp codex exec 'use the skill named commit-work-general to create a git commit for unstaged changes'"
#

# markdown preview on CLI
alias gl="glow -s ~/.config/glow/styles/dark-customised.json"

alias gll="fd -e md -E README.md -E CHANGELOG.md | CLICOLOR_FORCE=1 fzf --preview 'glow -w 120 -s ~/.config/glow/styles/dark-customised.json {}' --preview-window=right:80%"
alias gl.="fd -e md -E README.md -E CHANGELOG.md | fzf | xargs glow -s ~/.config/glow/styles/dark-customised.json"

eval "$(direnv hook zsh)"

source <(fzf --zsh)

#bindkey "ç" fzf-cd-widget
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export WASMTIME_HOME="$HOME/.wasmtime"

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# eval "$(gh copilot alias -- zsh)"

. "$HOME/.local/bin/env"
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

# make zoxide use fzf
export _ZO_FZF_OPTS="
--height=50%
--layout=reverse
--border
--info=inline
--prompt='Jump ❯ '
"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(atuin init zsh)"

[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"

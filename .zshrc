# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

# Load Zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in Zsh-plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add int snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found

# Load completions
autoload -U compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Key bindings
bindkey -v
bindkey '^e' autosuggest-accept
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# Completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias vim="nvim"
alias ls='ls --color=auto'
alias bt="bluetuith"
alias tag="git tag -ma"
alias pusht="git push --follow-tags"
alias ls="eza --oneline --long --git --no-user --no-permissions --no-time --icons=always --git-ignore --color=never"
alias la="eza -a --oneline --long --icons=always --color=never"
alias lt="eza --oneline --long --git --no-user --no-permissions --no-time --icons=always --git-ignore --tree --color=never"

alias lvlup="~/Code/PING/out/ping-linux-x64/ping"
alias clone="git clone"

function v() {
  if [ $# -eq 0 ]; then
    nvim
    return
  fi
  if [ -d "$1" -o -f "$1" ]; then
    nvim "$1"
    return
  fi
  res=$(zoxide query "$1")
  if [ $? -eq 0 ]; then
    nvim "$res"
    return
  fi
}


function spact() { # activate spact
  source ~/spack-develop/share/spack/setup-env.sh
}

# Exports
export CHROME_EXECUTABLE=/usr/bin/chromium
export PATH=$HOME/bin:$PATH
export PATH="/usr/local/bin:$PATH"
export PATH="/home/phoenix/.local/bin:$PATH"
export PATH=/opt/flutter/bin:$PATH
export PATH=/opt/rocm/bin:$PATH
export PATH=$HOME/.config/script:$PATH

export CC=/usr/bin/gcc
export CXX=/usr/bin/g++
export OPENCV_LOG_LEVEL=OFF

export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

export SHELL=/usr/bin/zsh
export EDITOR='nvim'
export VISUAL="nvim"

# Shell integration
eval "$(fzf --zsh)"
eval "$(zoxide init zsh --cmd cd)"
eval $(thefuck --alias)

alias m="mamba"
alias ma="mamba activate"
alias ml="mamba env list"
alias mlt="mamba list"
alias mc="mamba env create -n"
alias mr="mamba env remove -n"
alias mu="mamba update --prune -n"
alias md="mamba deactivate"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/phoenix/mambaforge/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/phoenix/mambaforge/etc/profile.d/conda.sh" ]; then
        . "/home/phoenix/mambaforge/etc/profile.d/conda.sh"
    else
        export PATH="/home/phoenix/mambaforge/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/phoenix/mambaforge/etc/profile.d/mamba.sh" ]; then
    . "/home/phoenix/mambaforge/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<


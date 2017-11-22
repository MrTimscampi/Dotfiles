source ~/.zplug/init.zsh

# Make sure we are in 256 colors mode if supported
zplug "chrissicool/zsh-256color"
# Get more completions
zplug "zsh-users/zsh-completions"
# Syntax highlighting for the prompt
zplug "zsh-users/zsh-syntax-highlighting", defer:2
# Set the theme to dracula
zplug "dracula/zsh", as:theme

# Store 1000 lines of history into a file
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

setopt appendhistory
setopt autocd
setopt beep
setopt extendedglob
setopt nomatch
setopt notify
bindkey -e

# Enable more colors
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}
eval $(dircolors -b $HOME/.ls_colors/LS_COLORS)

# Configure and initialize completion
zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/jmachiels/.zshrc'
autoload -Uz compinit
compinit

# Check if all zplug plugins are installed
# If not, ask to install them
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Load zplug
zplug load

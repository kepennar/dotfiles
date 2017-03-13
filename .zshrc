# Path to your oh-my-zsh installation.
export ZSH=/home/kepennar/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="xxf"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git npm docker)

# User configuration

source $ZSH/oh-my-zsh.sh

# aliases
alias ll="ls -als --color=auto"	

# Git aliases
alias gco='git checkout'
alias gst='git status'
alias gci='git commit'
alias gpush='git push'
alias gplease='git please'

# Alias remove unused docker images
alias drmi="docker system prune"
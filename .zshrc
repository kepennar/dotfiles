# Path to your oh-my-zsh installation.
export ZSH=/home/kepennar/.oh-my-zsh
export PATH=~/.npm-packages/bin:~/bin:$PATH

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="spaceship"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git npm docker zsh-autosuggestions)

# User configuration
source $ZSH/oh-my-zsh.sh
source ~/.functions

# aliases
alias ll="ls -als --color=auto"	
alias untar="tar -xvzf"

# Git aliases
alias gco='git checkout'
alias gst='git status'
alias gci='git commit'
alias gpush='git push'
alias gplease='git please'
alias gcz='git cz' # commitizen alias

# Alias remove unused docker images
alias drmi="docker system prune"

alias dockre="docker"
# Java
export JAVA_HOME=/home/kepennar/bin/jdk
# Go
export GOROOT=/home/kepennar/bin/go1.9.6

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
source ~/.autoenv/activate.sh

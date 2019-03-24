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
plugins=(git npm yarn docker zsh-autosuggestions pass)

# User configuration
source $ZSH/oh-my-zsh.sh

source ~/.functions
source ~/.aliases

# Java
export JAVA_HOME=/home/kepennar/bin/jdk
# Go
export GOROOT=/home/kepennar/bin/go

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# source ~/.autoenv/activate.sh

 
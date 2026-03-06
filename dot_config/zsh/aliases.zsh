# Git aliases
alias gc='git commit'
alias gco='git checkout'
alias gpull='git pull'
alias gpush='git push'
alias gpushf='git please'
alias gst='git status'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'

# Navigation
alias tmpDir='cd $(mktemp -d)'

# eza (ls replacement)
alias l="eza --sort Name"
alias ll="eza --sort Name --long"
alias la="eza --sort Name --long --all"
alias lr="eza --sort Name --long --recurse"
alias lra="eza --sort Name --long --recurse --all"
alias lt="eza --sort Name --long --tree"
alias lta="eza --sort Name --long --tree --all"
alias ls="eza --sort Name"

# Modern CLI replacements
alias du=dust
alias ps=procs
alias cat=bat

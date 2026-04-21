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
if (( $+commands[eza] )); then
  alias l="eza --sort Name"
  alias ll="eza --sort Name --long"
  alias la="eza --sort Name --long --all"
  alias lr="eza --sort Name --long --recurse"
  alias lra="eza --sort Name --long --recurse --all"
  alias lt="eza --sort Name --long --tree"
  alias lta="eza --sort Name --long --tree --all"
  alias ls="eza --sort Name"
else
  alias l='ls'
  alias ll='ls -lh'
  alias la='ls -lah'
  alias lr='ls -lR'
  alias lra='ls -laR'
  alias lt='ls -lh'
  alias lta='ls -lah'
fi

# Modern CLI replacements
if (( $+commands[dust] )); then
  alias du='dust'
fi

if (( $+commands[procs] )); then
  alias ps='procs'
fi

if (( $+commands[bat] )); then
  alias cat='bat'
elif (( $+commands[batcat] )); then
  alias cat='batcat'
fi

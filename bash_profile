alias ta="tmux a -t"
alias tls="tmux list-session"
alias g="git"
alias gc="g checkout"
alias gs="g status"
alias gf="g fetch"
alias gr="g rebase"
alias gp="g pull"
alias gpp="g push origin HEAD"
alias gppf="gpp --force-with-lease"
alias gb="g branch"
alias gd="g diff"
alias gdc='git diff --cached'
alias gl="git log"
alias grw="git reset --soft HEAD~1"
alias ll='ls -l'
alias l='less'
alias ..="cd .."
alias ...="cd ../../.."
alias vim="nvim"

export PATH=$PATH:$HOME/.local/bin

# for ghostty + tmux
export TERM=xterm-256color

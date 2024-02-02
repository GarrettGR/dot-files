# ls -> lsd
alias l="command ls -l"
alias ls="lsd"
alias ll="lsd -l"
alias la="lsd -a"
alias lla="lsd -l -a"
alias lt="lsd --tree"
alias ltl="lsd --tree -l"
alias lta="lsd --tree -a"
alias ltla="lsd --tree -l -a"

# top -> btop
alias top="btop"

# git
alias gs="git status"
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push origin main"
alias gl="git pull origin main"
alias gb="git branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate"
alias gco="git checkout"
alias gcob="git checkout -b"

# Nginx
alias nginxreload='sudo /usr/local/nginx/sbin/nginx -s reload'
alias nginxtest='sudo /usr/local/nginx/sbin/nginx -t'

# other:
alias ..="cd .."
alias ...="cd ../.."
# alias dev="cd /mnt/e && ls"
alias c="clear"
alias update="sudo apt-get update && sudo apt-get upgrade -y"
alias rl="exec bash -l"

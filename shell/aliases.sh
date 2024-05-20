# echo 'source ~/dotFiles/shell/aliases.sh' >> ~/.bashrc

# Base commands ++
alias df='df -h'
alias du='du -h'
alias grep='grep --color=auto'
alias less='less --use-color --color=Er --color=My --color=Nb --color=Pm -N'
alias ls='ls --color=auto -h'
alias rg='rg --color always'
alias tree="tree -Ca -I '.git'"
alias xclip='xclip -selection clipboard'

# Build on base commands
alias .....='cd ../../../..'
alias ....='cd ../../..'
alias ...='cd ../../'
alias ..='cd ..'
alias la='ls -a'
alias lal='ls -al'
alias ll='ls -l'

# Emacs
alias e=emacs
alias eh='emacs . &'
alias ew='emacs -nw'
if ! $(command -v mg 1>/dev/null) ; then
    alias mg="emacs -nw"
fi

# Git
alias ga='git add'
alias gb='git branch'
alias gc='git commit -m'
alias gca='git commit -a -m'
alias gco='git checkout'
alias gd='git diff'
alias gg='git grep'
alias gl='git pull --rebase origin'
alias glg="git log --graph --pretty=format:'%Cblue%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias glm='git pull --rebase origin'
alias glp="git log --pretty=tformat:'%h %Cblue%cr%Creset %cn %Cgreen%s%Creset'"
alias gp='git push origin'
alias gpm='git push origin master'
alias gr='git restore'
alias gs='git status -s'

# Programming
alias make='make -j16'
alias pip='python -m pip'
alias venv='python -m venv'
alias shellcheck='shellcheck -xa'

# System
alias dmesg='sudo dmesg'
alias spac='sudo pacman --noconfirm'
alias clearjournal='sudo journalctl --vacuum-time=7d'
alias upgrade='sudo pacman -Syu --noconfirm'

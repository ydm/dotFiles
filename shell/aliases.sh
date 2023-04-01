# echo 'source ~/dotFiles/shell/aliases.sh' >> ~/.bashrc

# Rewrite basic commands
alias df='df -h'
alias du='du -h'
alias grep='grep --color=auto'
alias less="less --use-color --color=Er --color=My --color=Nb --color=Pm -N"
alias ls='ls --color=auto -h'
alias make='make -j16'
alias pipp='python -m pip'
alias rg="rg --color always"
alias tree='tree -Ca -I ".git"'
alias xclip='xclip -selection clipboard'

# Shortcuts
alias e=emacs
alias ew='emacs -nw'
if ! $(command -v mg 1>/dev/null) ; then
    alias mg="emacs -nw"
fi
alias spac='sudo pacman --noconfirm'

# Git
alias ga='git add'
alias gb='git branch'
alias gc='git commit -m'
alias gca='git commit -a -m'
alias gco='git checkout'
alias gd='git diff'
alias gl='git pull --rebase $(git remote | head -n1)'
alias glg="git log --graph --pretty=format:'%Cblue%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias glp="git log --pretty=tformat:'%h %Cblue%cr%Creset %cn %Cgreen%s%Creset'"
# alias gp="git push $(git remote | head -n1) $(git branch | grep -Pe '^\* ' | sed s/^..//)"

alias gr='git restore'
alias gs='git status'

# Navigation
alias .....='cd ../../../..'
alias ....='cd ../../..'
alias ...='cd ../../'
alias ..='cd ..'
alias l='ls'
alias la='ls -a'
alias lal='ls -al'
alias ll='ls -l'

# Utilities
alias upgrade='sudo pacman -Syu --noconfirm'
# alias theia='docker run -it --init -p 3000:3000 -v "$(pwd):/home/project:cached" theiaide/theia:latest'

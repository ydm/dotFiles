# echo 'source ~/dotFiles/shell/aliases.sh' >> ~/.bashrc

# Rewrite system commands
alias grep='grep --color=auto'
alias ls='ls --color=auto -h'
alias make='make -j16'

# Shortcuts
alias e=emacs
# alias s=sudo  # conflicts with fasd
alias spac='sudo pacman --noconfirm'

# Git
alias ga='git add'
alias gb='git branch'
alias gc='git commit -m'
alias gca='git commit -a -m'
alias gco='git checkout'
alias gd='git diff'
alias gl='git pull --rebase origin'
alias glg="git log --graph --pretty=format:'%Cblue%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias glp="git log --pretty=tformat:'%h %Cblue%cr%Creset %cn %Cgreen%s%Creset'"
alias gp='git push origin'
alias gr='git restore'
alias gs='git status'

# Navigation
alias ....='cd ../../..'
alias ...='cd ../../'
alias ..='cd ..'
alias l='ls'
alias la='ls -a'
alias lal='ls -al'
alias ll='ls -l'

# Utilities
alias hh="npx hardhat"
alias t='tree -Ca -I ".git"'
alias upgrade='sudo pacman -Syu --noconfirm'
alias xclip='xclip -selection clipboard'
# alias theia='docker run -it --init -p 3000:3000 -v "$(pwd):/home/project:cached" theiaide/theia:latest'

# .zshrc
# Dónal Murray (seadanda)

HISTFILE=~/.zhistory
HISTSIZE=10000
SAVEHIST=10000
setopt extendedglob
unsetopt beep

#comp
zstyle :compinstall filename '/home/donal/.zshrc'
autoload -Uz compinit
compinit

#prompt
PROMPT="[%n@%m %1~]%# "
RPROMPT="[%?]"
echo -e -n "\x1b[\x34 q" # solid underline
bindkey "^[[1;5D" backward-word # ctrl+<left> moves back one word
bindkey "^[[1;5C" forward-word # ctrl+<right> moves forward one word

# env
export VISUAL=vim
export EDITOR=vim
export RANGER_LOAD_DEFAULT_RC=FALSE
eval "$(/home/donal/miniconda3/bin/conda shell.zsh hook)"

# aliases
alias ls='ls -h --color=auto'
alias grep='grep --color=auto'
alias dmesg='dmesg -HL'
alias ccat='ccat --color=always --bg=dark'
alias dmenu='dmenu -m "0" -fn "noto:size=10" -nb "#222222" -nf "#bbbbbb" -sb "#005577" -sf "#eeeeee"'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
alias rm='rm -I'
alias ssh='ssh'
alias wine64='WINEPREFIX=~/.wine64'
alias rtv='rtv --enable-media'
alias lscmd='ls ~/.scripts'
alias pacwarn='curl -s https://www.archlinux.org/feeds/news/ | xmllint --xpath //item/title\ \|\ //item/pubDate /dev/stdin | sed -r -e "s:<title>([^<]*?)</title><pubDate>([^<]*?)</pubDate>:\2\t\1\n:g"'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# typos
alias :q='exit'
alias ake='make' #because tmux waits for a character for too long after switching window
alias cd..='cd ..'

# ssh
alias ckinit='kinit -f -p -r 168h dmurray@CERN.CH -k -t ~/.dmurray.keytab' #initialise cern krb5
alias cvminit='VBoxManage startvm cernvm --type headless' #start cernvm
alias fvminit='VBoxManage startvm firmware --type headless' #start cernvm
alias cvmssh="ssh -XY cernvm"
alias fvmssh="ssh -XY fwvm"
alias md2ssh='ssh -Y md2' #minidaq2
alias lmdssh='ssh -Y lhcb-asus01 || ssh -YJ lxplus.cern.ch lhcb-asus01'

# hyperjump
source ~/.scripts/hyperjump

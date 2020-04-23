
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh



[ -f ~/.fzf.bash ] && source ~/.fzf.bash
alias config='/usr/bin/git --git-dir=/Users/alistair.hughes/.cfg/ --work-tree=/Users/alistair.hughes'

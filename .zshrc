# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/alistair.hughes/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"
ZSH_DISABLE_COMPFIX=true

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# cheat functions
function c() {
  curl cht.sh/$1 | less
}

# Use like, "h ssh" to see all ssh in your history
alias h='history | grep'

# like `history` but with dates
alias hd="fc -li 1"

# open new browser
alias fx=firefox --new-instance --profile $(mktemp -d)
alias cx=chromium --user-data-dir $(mktemp -d)

# Weather
alias weather='curl wttr.in/$CITY'

# Vim short cuts
alias v='nvim'
alias vtd='nvim ~/Desktop/todo.markdown'
alias vcd='nvim ~/Desktop/code.markdown'
alias vrc='nvim ~/.config/nvim/init.vim'
alias vrc='nvim ~/.vimrc'
alias vzrc='nvim ~/.zshrc'

# Python ctags
alias pt='ctags -R --exclude=.git --exclude=node_modules --exclude=lambdas/deploy --exclude=.venv --exclude=.tox --exclude="*.html" --exclude="*.xml" --exclude="*.pyc" --exclude="*.json" --exclude="*.js" --extras=+f .'

# Fzf exclude
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude package/'

# Python install pudb
alias ipudb='pipenv install pudb --dev --skip-lock'

# Uninstall
alias upudb='pipenv uninstall pudb --skip-lock'

# Open markdown files
function omd() {
  open -a 'Markoff' $1
}

# Run with file
function rpudb() {
   pipenv run python -m pudb.run $1
}

# Git alias
alias grf='git checkout origin/master ; git fetch --all ; git pull upstream master ; git push origin master'

# git refresh with new branch
function grfb() {
   git checkout master ; git fetch --all ; git pull upstream master ; git push origin master ; git checkout -b $1
}

# Tmux shortcut
# tells tmux that utf-8 is supported
#alias tmux='tmux -u'

# Grep short cuts
function grp() {
  grep -rnw -e $1 .
}

function agg() {
  ag $1 --ignore-dir=.mypy_cache --ignore-dir=node_modules --ignore-dir=static --ignore-dir=htmlcov --ignore-dir=xunit-reports --ignore-dir=coverage-reports
}

# Clear
alias cl='clear'

# autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# git log
alias gitl='git log --pretty=format:"%Cred%h %Cgreen %cd %Cblue%<(14,trunc)%an %Creset %s %Cred %d %Creset" --graph --date=short -20'

###########
# using ripgrep combined with preview
# find-in-file - usage: fif <searchTerm>
fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

# Color history
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=3'

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/alistair.hughes/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/alistair.hughes/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/alistair.hughes/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/alistair.hughes/google-cloud-sdk/completion.zsh.inc'; fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias config='/usr/bin/git --git-dir=/Users/alistair.hughes/.cfg/ --work-tree=/Users/alistair.hughes'
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"


export PATH="$HOME/.poetry/bin:$PATH"

# Allow poetry to load .env on shell spawn files like pipenv, see here: https://github.com/python-poetry/poetry/issues/337#issuecomment-660549880
function poetry() {
    # if POETRY_DONT_LOAD_ENV is *not* set, then load .env if it exists
    if [[ -z "$POETRY_DONT_LOAD_ENV" && -f .env ]]; then
        echo 'Loading .env environment variables…'
        export $(grep -v '^#' .env | tr -d ' ' | xargs)
        command poetry "$@"
        unset $(grep -v '^#' .env | sed -E 's/(.*)=.*/\1/' | xargs)
    else
        command poetry "$@"
    fi
}


# Added by Amplify CLI binary installer
export PATH="$HOME/.amplify/bin:$PATH"

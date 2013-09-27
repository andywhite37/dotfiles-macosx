################################################################################
# awhite's .zshrc
################################################################################

################################################################################
# Oh My ZSH
################################################################################

ZSH=$HOME/.oh-my-zsh
ZSH_THEME="awhite"

COMPLETION_WAITING_DOTS="true"

plugins=(git vi-mode brew)

source $ZSH/oh-my-zsh.sh

# Undo some of the defaults
unset -f cd

################################################################################
# $PATH
################################################################################

removePathDir()
{
    dir="$1"
    export PATH=$(echo "$PATH" | tr ":" "\n" | grep -vx "$dir" | paste -s -d ':' -)
}

prependPathDir()
{
    dir="$1"
    if ! $(echo "$PATH" | tr ":" "\n" | grep -qx "$dir" ); then export PATH="${dir}:${PATH}"; fi
}

appendPathDir()
{
    dir="$1"
    if ! $(echo "$PATH" | tr ":" "\n" | grep -qx "$dir" ); then export PATH="${PATH}:${dir}"; fi
}

# Add homebrew's ruby gem install dir to path
if [[ -d "/usr/local/Cellar/ruby/1.9.3-p194/bin" ]]; then
    removePathDir '/usr/local/Cellar/ruby/1.9.3-p194/bin'
    prependPathDir '/usr/local/Cellar/ruby/1.9.3-p194/bin'
fi

# RVM script adds this
#if [[ -d "${HOME}/.rvm/bin" ]]; then
#    prependPathDir "${HOME}/.rvm/bin"
#fi

# Remove and re-add /usr/local/bin so it appears before /usr/bin
removePathDir "/usr/local/bin"
prependPathDir "/usr/local/bin"

removePathDir "${HOME}/bin"
prependPathDir "${HOME}/bin"

#appendPathDir "/usr/libexec"

################################################################################
# Environment variables
################################################################################

#export VIM_HOME='/Applications/MacVim.app/Contents/Resources/vim'
if [[ -d /Applications/MacVim.app ]]; then
    export VIM_COMMAND='/Applications/MacVim.app/Contents/MacOS/Vim'
    export GVIM_COMMAND='/Applications/MacVim.app/Contents/MacOS/Vim -g'
    export GVIMF_COMMAND='/Applications/MacVim.app/Contents/MacOS/Vim -gf'
else
    export VIM_COMMAND='/usr/bin/vim'
    export GVIM_COMMAND='/usr/bin/gvim'
    export GVIMF_COMMAND='/usr/bin/gvim -f'
fi

export EDITOR="${GVIMF_COMMAND}"
export GIT_EDITOR="${GVIMF_COMMAND}"

export PAGER="less -fiMQ"

export DROPBOX="${HOME}/Dropbox"
export MAC="${DROPBOX}/DevelopmentTools/Mac"
export DESKTOP="${HOME}/Desktop"
export DEV="${HOME}/dev"
export DOWNLOADS="${HOME}/Downloads"
export MYTEMP="${HOME}/tmp"

################################################################################
# Autocorrect
################################################################################

unsetopt correct_all
setopt correct

################################################################################
# Key Bindings
################################################################################

bindkey "^P" up-line-or-history
bindkey "^N" down-line-or-history

################################################################################
# Shell-related shortcuts
################################################################################

alias editor="${EDITOR}"
#alias e="${EDITOR}"
alias vim="${VIM_COMMAND}"
alias gvim="${GVIM_COMMAND} --servername GVIM --remote-tab-silent"
alias gvimraw="${GVIM_COMMAND}"

alias path='echo $PATH | ddown'

#alias et='gvim ~/.tcshrc'
#alias st='source ~/.tcshrc'
alias ee='gvim ~/.zshrc'
alias se='source ~/.zshrc'
alias eth="gvim $ZSH/custom/awhite.zsh-theme"
alias ev='gvim ~/.vimrc ~/.vimrc.before ~/.vimrc.after ~/.gvimrc ~/.gvimrc.before ~/.gvimrc.after'
alias evb='gvim ~/.vimrc.before'
alias eva='gvim ~/.vimrc.after'
alias egvb='gvim ~/.gvimrc.before'
alias egva='gvim ~/.gvimrc.after'
alias eg='gvim ~/.gitconfig'

alias rm='rm -i'

alias ddown="tr ':' '\n'"

alias srch='find . -print | grep'
alias ff='find . -type f -print'
alias rgrep="ack"

alias grepfiles='cut -d: -f1 | sort | uniq'

alias psall='ps -e -o pid,ppid,user,command'
alias psme='ps -u ${USER} -o pid,ppid,user,command'
alias psgrep='psall | grep'
alias psmegrep='psme | grep'

alias p="$PAGER"
alias more="$PAGER"

alias h='history'
alias hgrep='history | grep'

alias dt='~/bin/diffmerge.sh'

alias lock='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'

################################################################################
# cd shortcuts
################################################################################

alias up='cd ..'
alias up2='cd ../../'
alias up3='cd ../../../'
alias up4='cd ../../../../'
alias up5='cd ../../../../../'
alias up6='cd ../../../../../../'
alias up7='cd ../../../../../../../'
alias up8='cd ../../../../../../../../'

alias home="cd"
alias back="cd -"

alias dropbox="cd $DROPBOX"
alias db="cd $DROPBOX"
alias mac="cd $MAC"
alias desktop="cd $DESKTOP"
alias dl="cd $DOWNLOADS"
alias omz="cd $ZSH"
alias temp="cd $MYTEMP"
alias tmp="cd $MYTEMP"
alias ulb="cd /usr/local/bin"

alias isim5.1='cd ~/Library/Application\ Support/iPhone\ Simulator/5.1/Applications'
alias isim='cd ~/Library/Application\ Support/iPhone\ Simulator/6.0/Applications'

alias dev="cd $DEV"
alias am-ios="cd $DEV/bluedot/am-ios"

################################################################################
# ls shortcuts
################################################################################

if [[ -d /Applications ]]; then
    alias ls='ls -G'
else
    alias ls='ls --color'
fi

alias lf='ls -F'
alias ll='ls -la'
alias la='ls -la'
alias llrt='ls -lart'
alias llart='ls -lart'
alias l1='ls -1'

################################################################################
# Applications
################################################################################

alias xcode='open /Applications/Xcode.app'
alias appcode='open /Applications/AppCode.app'
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --allow-file-access-from-files &!'
alias canary='/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary --allow-file-access-from-files &!'
alias weinre='$DEV/apache/incubator-cordova-weinre/weinre.server/weinre &'

################################################################################
# Websites
################################################################################

alias github='open https://github.com/organizations/bluedot'
alias teamcity='open http://buildserver65/overview.html'
alias rally='open https://rally1.rallydev.com'

################################################################################
# Homebrew
################################################################################

#alias cellar="cd $(brew --cellar)"

################################################################################
# Python
################################################################################

# Pythonbrew
[[ -s $HOME/.pythonbrew/etc/bashrc ]] && source $HOME/.pythonbrew/etc/bashrc
alias pbhome='cd ~/.pythonbrew'
alias pb="pythonbrew"
alias pbon="pythonbrew switch 2.7.3"
alias pboff="pythonbrew off"

# pip/virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT=true
export PIP_REQUIRE_VIRTUALENV=true
export PIP_RESPECT_VIRTUALENV=true
alias vehome='cd $VIRTUAL_ENV'

# virtualenvwrapper
export WORKON_HOME=~/dev/virtualenvs
export PROJECT_HOME=~/dev/virtualprojects
export PIP_VIRTUALENV_BASE="$WORKON_HOME"
#export VIRTUALENVWRAPPER_PROJECT_FILENAME=".project"
#export VIRTUALENVWRAPPER_HOOK_DIR
#export VIRTUALENVWRAPPER_LOG_DIR
#export VIRTUALENVWRAPPER_PYTHON
#export VIRTUALENVWRAPPER_VIRTUALENV
#export VIRTUALENVWRAPPER_VIRTUALENV_ARGS
#export VIRTUALENVWRAPPER_TMPDIR
which virtualenvwrapper.sh >& /dev/null && source `which virtualenvwrapper.sh`
alias wohome="cd $WORKON_HOME"
alias projhome="cd $PROJECT_HOME"

################################################################################
# Ruby
################################################################################

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
alias rvmhome="cd ~/.rvm"
alias rvmon="rvm use 1.9.3 --default"
alias rvmoff="rvm use system"

################################################################################
# Node.js
################################################################################

export NODE_PATH="/usr/local/lib/node_modules"

alias npmupdate="npm update -g npm"
alias npmupdateall="npm update -g"


################################################################################
# awhite's .zshrc
################################################################################

################################################################################
# Oh My ZSH
################################################################################

ZSH=$HOME/.oh-my-zsh
ZSH_THEME="awhite"

COMPLETION_WAITING_DOTS="true"

plugins=(git vi-mode)

source $ZSH/oh-my-zsh.sh

################################################################################
# Path updates
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

prependPathDir '/usr/local/Cellar/ruby/1.9.3-p194/bin'

removePathDir "/usr/local/bin"
prependPathDir "/usr/local/bin"

prependPathDir "${HOME}/bin"

#appendPathDir "/usr/libexec"

################################################################################
# Environment variables
################################################################################

export EDITOR='/Applications/MacVim.app/Contents/MacOS/Vim -g'
export GIT_EDITOR='/Applications/MacVim.app/Contents/MacOS/Vim'
export VIM_HOME='/Applications/MacVim.app/Contents/Resources/vim'

################################################################################
# Key Bindings
################################################################################

bindkey "^P" up-line-or-history
bindkey "^N" down-line-or-history

################################################################################
# Command-line shortcuts
################################################################################

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

alias rm='rm -i'

alias editor="${EDITOR}"
alias gvimraw="${EDITOR}"
alias gvim="${EDITOR} --servername GVIM --remote-tab-silent"

alias ddown="tr ':' '\n'"

alias srch='find . -print | grep'
alias rgrep="ack"

alias grepfiles='cut -d: -f1 | sort | uniq'

alias psall='ps -e -o pid,ppid,user,command'
alias psme='ps -u awhite -o pid,ppid,user,command'

alias p='less -fiMQ'

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

alias omz='cd $ZSH'
alias isim='cd ~/Library/Application\ Support/iPhone\ Simulator/5.1/Applications'
alias dl='cd ~/Downloads'
alias mac='cd ~/Dropbox/DevelopmentTools/Mac'

alias devhome='cd ~/dev'
alias githome='devhome'
alias am-ios='githome && cd bluedot/am-ios' 

################################################################################
# ls shortcuts
################################################################################

alias ls='ls -G'
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
alias weinre='githome && apache/incubator-cordova-weinre/weinre.server/weinre &'

################################################################################
# Websites
################################################################################

alias github='open https://github.com/organizations/bluedot'
alias teamcity='open http://buildserver65/overview.html'
alias rally='open https://rally1.rallydev.com'

################################################################################
# Python
################################################################################

# Pythonbrew
[[ -s $HOME/.pythonbrew/etc/bashrc ]] && source $HOME/.pythonbrew/etc/bashrc
alias pbhome='cd ~/.pythonbrew'
alias pb="pythonbrew"

# virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT="true"
alias vehome='cd $VIRTUAL_ENV'

# virtualenvwrapper
export WORKON_HOME=~/dev/virtualenvs
export PROJECT_HOME=~/dev/virtualprojects
#export VIRTUALENVWRAPPER_PROJECT_FILENAME
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

# TODO: need to install RVM for better gem support than homebrew provides

#alias sass='/usr/local/lib/ruby/gems/1.9.1/gems/sass-3.1.18/bin/sass'
#alias scss='/usr/local/lib/ruby/gems/1.9.1/gems/sass-3.1.18/bin/scss'

################################################################################
# awhite's .zshrc
################################################################################

################################################################################
# Begin oh-my-zsh Setup
################################################################################
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="awhite"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git vi-mode)

source $ZSH/oh-my-zsh.sh

################################################################################
# End .oh-my-zsh stuff
# Begin awhite customizations
################################################################################

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
rgrep()
{
    # TODO: $* doesn't handle args like -i for grep
    find . -type f -print0 | xargs -0 grep "$*" |& grep -v 'Binary file.*matches'
}

alias grepfiles='cut -d: -f1 | sort | uniq'

alias psall='ps -e -o pid,ppid,user,command'
alias psme='ps -u awhite -o pid,ppid,user,command'

alias p='less -fiMQ'

alias h='history'
alias hgrep='history | grep'

alias dt='~/bin/diffmerge.sh'

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

alias githome='cd ~/dev'
alias am-ios='githome && cd bluedot/am-ios' 

alias isim='cd ~/Library/Application\ Support/iPhone\ Simulator/5.1/Applications'
alias dl='cd ~/Downloads'
alias mac='cd ~/Dropbox/DevelopmentTools/Mac'

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
alias weinre='githome && apache/incubator-cordova-weinre/weinre.server/weinre &'

################################################################################
# Python
################################################################################

# Pythonbrew
[[ -s $HOME/.pythonbrew/etc/bashrc ]] && source $HOME/.pythonbrew/etc/bashrc
alias pb="pythonbrew"

# virtualenv
alias vehome='cd $VIRTUAL_ENV'

# virtualenvwrapper
export WORKON_HOME=~/dev/virtualenvs
where virtualenvwrapper.sh >& /dev/null && source `where virtualenvwrapper.sh`
alias wohome="cd $WORKON_HOME"


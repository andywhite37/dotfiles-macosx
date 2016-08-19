################################################################################
# awhite's .zshrc
################################################################################

################################################################################
# Oh My ZSH
################################################################################

ZSH=$HOME/.oh-my-zsh
#ZSH_THEME="awhite"
ZSH_THEME="zsh2000"
ZSH_2000_DISABLE_RVM="true"
ZSH_2000_DISABLE_RIGHT_PROMPT="true"

#COMPLETION_WAITING_DOTS="true"

#zsh-syntax-highlighting
plugins=(brew colored-man extract git jsontools vi-mode aws httpie node npm web-search)

source $ZSH/oh-my-zsh.sh

# zsh-autosuggestions
#if [[ -f ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/autosuggestions.zsh ]]; then
  #source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/autosuggestions.zsh
  #zle-line-init() {
    #zle autosuggest-start
  #}
  #zle -N zle-line-init
  #bindkey '^e' end-of-line
  #bindkey '^f' vi-forward-word
  #AUTOSUGGESTION_HIGHLIGHT_COLOR='fg=black,bg=white'
#else
  ##echo "Not using autosuggestions"
#fi

# Undo some of the defaults
unset -f cd &> /dev/null

# Setup online help (recommended by homebrew)
unalias run-help &> /dev/null
autoload run-help
autoload -U zmv
HELPDIR=/usr/local/share/zsh/helpfiles

################################################################################
# Echo utilities
################################################################################

color_black='\033[0;30m'
color_red='\033[0;31m'
color_green='\033[0;32m'
color_yellow='\033[0;33m'
color_blue='\033[0;34m'
color_purple='\033[0;35m'
color_cyan='\033[0;36m'
color_gray='\033[0;37m'
color_none='\033[0m'

echo_red() {
  echo -e "${color_red}${1:-}${color_none}"
}

echo_green() {
  echo -e "${color_green}${1:-}${color_none}"
}

echo_yellow() {
  echo -e "${color_yellow}${1:-}${color_none}"
}

echo_blue() {
  echo -e "${color_blue}${1:-}${color_none}"
}

echo_purple() {
  echo -e "${color_purple}${1:-}${color_none}"
}

echo_cyan() {
  echo -e "${color_cyan}${1:-}${color_none}"
}

banner() {
  local msg="$1"
  echo_blue "--------------------------------------------------------------------------------"
  echo_cyan "${msg}"
  echo_blue "--------------------------------------------------------------------------------"
}

run_command() {
  local cmd="$1"
  echo_yellow "$cmd"
  eval "$cmd"
}

confirm_ok() {
  local msg="${1:-}"

  if [[ "$msg" != "" ]]; then
    echo
    echo "$msg"
  fi

  echo
  read -p "Is this ok? (y|n) " -n 1 -r choice
  case "$choice" in
    y|Y)
      echo
      ;;
    *)
      echo
      exit_error "Aborting"
      ;;
  esac
}

################################################################################
# PATH configurations
################################################################################

# Remove a directory from the PATH
removePathDir() {
  dir="$1"
  export PATH=$(echo "$PATH" | tr ":" "\n" | grep -vx "$dir" | paste -s -d ':' -)
}

# Prepend a directory to the PATH (at the beginning)
prependPathDir() {
  dir="$1"
  if ! $(echo "$PATH" | tr ":" "\n" | grep -qx "$dir" ); then export PATH="${dir}:${PATH}"; fi
}

# Append a directory to the PATH (at the end)
appendPathDir() {
  dir="$1"
  if ! $(echo "$PATH" | tr ":" "\n" | grep -qx "$dir" ); then export PATH="${PATH}:${dir}"; fi
}

# Add homebrew's ruby gem install dir to path
#if [[ -d "/usr/local/Cellar/ruby/1.9.3-p194/bin" ]]; then
#    removePathDir '/usr/local/Cellar/ruby/1.9.3-p194/bin'
#    prependPathDir '/usr/local/Cellar/ruby/1.9.3-p194/bin'
#fi

# Add homebrew's ruby gem install dir to path
#if [[ -d "/usr/local/Cellar/ruby/2.0.0-p353/bin" ]]; then
#    removePathDir '/usr/local/Cellar/ruby/2.0.0-p353/bin'
#    prependPathDir '/usr/local/Cellar/ruby/2.0.0-p353/bin'
#fi

# Add homebrew's ruby gem install dir to path
#if [[ -d "/usr/local/Cellar/ruby/2.1.1_1/bin" ]]; then
#    removePathDir '/usr/local/Cellar/ruby/2.1.1_1/bin'
#    prependPathDir '/usr/local/Cellar/ruby/2.1.1_1/bin'
#fi

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

sourceIfExists() {
  local file_path="${1:-}"
  if [[ -f "$file_path" ]]; then
    source "$file_path"
  else
    echo "Warning: not sourcing '$file_path' - does not exist"
  fi
}

################################################################################
# Environment variables/tools
################################################################################

#export VIM_HOME='/Applications/MacVim.app/Contents/Resources/vim'
if [[ -d /Applications/MacVim.app ]]; then
  # Mac OSX
  export VIM_COMMAND='/Applications/MacVim.app/Contents/MacOS/Vim'
  export GVIM_COMMAND='/Applications/MacVim.app/Contents/MacOS/Vim -g'
  export GVIMF_COMMAND='/Applications/MacVim.app/Contents/MacOS/Vim -gf'
else
  # Linux
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

# ctrl-p and ctrl-n go up and down in history
bindkey "^P" up-line-or-history
bindkey "^N" down-line-or-history

################################################################################
# Shell-related shortcuts
################################################################################

alias editor="${EDITOR}"
#alias e="${EDITOR}"
#alias vim="${VIM_COMMAND}"
#alias gvim="${GVIM_COMMAND} --servername GVIM --remote-tab-silent"
#alias gvim="${GVIM_COMMAND}"
#alias gvimraw="${GVIM_COMMAND}"
#alias gvim.="${GVIM_COMMAND} ."
#alias subl='/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl'

alias path='echo $PATH | ddown'

#alias et='gvim ~/.tcshrc'
#alias st='source ~/.tcshrc'
alias ee='gvim ~/.zshrc'
alias se='source ~/.zshrc'
alias eth="gvim $ZSH/custom/awhite.zsh-theme"
alias ev='gvim ~/.vimrc.before ~/.vimrc.after'
alias egv='gvim ~/.gvimrc.before ~/.gvimrc.after'
alias evb='gvim ~/.vimrc.before'
alias eva='gvim ~/.vimrc.after'
alias egvb='gvim ~/.gvimrc.before'
alias egva='gvim ~/.gvimrc.after'
alias eg='gvim ~/.gitconfig'
alias et="gvim ~/.oh-my-zsh/custom/${ZSH_THEME}.zsh-theme"

alias rm='rm -i'

alias ddown="tr ':' '\n'"

alias srch='find . -print | grep'
alias ff='find . -type f -print'
alias grep="egrep"
alias rgrep="ack"

alias grepfiles='cut -d: -f1 | sort | uniq'

alias psall='ps -e -o pid,ppid,user,command'
alias psme='ps -u ${USER} -o pid,ppid,user,command'
alias psgrep='psall | grep'
alias psmegrep='psme | grep'

alias p="$PAGER"
alias more="$PAGER"

alias h='history'
alias hist='history'
alias hgrep='history | grep'
alias rmhistory='mv "${HISTFILE}" "${HISTFILE}.bak"'

alias dt='diffmerge'

alias lock='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'

alias rmswp="rm ~/.vim/_temp/*.swp"
alias :q="echo Not in vim"

# Creates a Bash/AppleScript function for opening new iTerm2 tabs from the command line
. ~/bin/tab.bash

topp() {
  local name="${1:-}"
  pid=$(ps -e | grep "$name" | grep -v grep | awk '{print $1}')
  echo "Running top for name: '$name', pid: '$pid'"
  top -pid $pid
}

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
alias docs="cd ~/Documents"
alias doc="docs"
alias omz="cd $ZSH"
alias temp="cd $MYTEMP"
alias tmp="cd $MYTEMP"
alias ulb="cd /usr/local/bin"
alias dev="cd $DEV"
#alias src="cd ~/src"
#alias isim5.1='cd ~/Library/Application\ Support/iPhone\ Simulator/5.1/Applications'
#alias isim='cd ~/Library/Application\ Support/iPhone\ Simulator/6.0/Applications'

# Personal projects
alias ap="cd ~/dev/andypellucid"
alias aw="cd ~/dev/andywhite37"
alias redhawk="aw && cd redhawk"
alias vmort="aw && cd virdomort"
alias ddore="aw && cd dombledore"
alias hmmdir="aw && cd hmm"
alias haxpression="aw && cd haxpression"
alias graphx="aw && cd graphx"
alias sqlx="aw && cd sqlx"
alias mtg="aw && cd mtg"

# Open source/forks
#alias abedev="cd ~/dev/abedev"
#alias abe="abedev; cd abe"
#alias npmdir="abedev; cd npm"
alias abe="aw; cd abe"
alias npmdir="aw; cd npm"
alias thxcore="aw; cd thx.core"
alias thxpromise="aw; cd thx.promise"
alias utest="aw; cd utest"
alias doom="aw; cd doom"
alias doom-bootstrap="aw; cd doom-bootstrap"

# Old stuff
#alias decks="pa; cd decks"
#alias pillbox="pa; cd pillbox"
#alias hammer="pa; cd hammer.js"

################################################################################
# ls shortcuts
################################################################################

if [[ -d /Applications ]]; then
  # Mac OSX
  alias ls='ls -G'
else
  # Linux
  alias ls='ls --color'
fi

alias lf='ls -F'
alias ll='ls -la'
alias la='ls -la'
alias llrt='ls -lart'
alias llart='ls -lart'
alias l1='ls -1'

################################################################################
# Networking Shortcuts
################################################################################

#alias iphonedev2='ssh BDS@172.0.1.124'
#
# Print my current IP address
alias ip="ifconfig | grep inet | grep -v inet6 | grep -v '127.0.0.1' | tail -1 | cut -d' ' -f2"

################################################################################
# Applications
################################################################################

alias xcode='open -a /Applications/Xcode.app'
alias appcode='open -a /Applications/AppCode.app'
alias chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --allow-file-access-from-files &!'
alias canary='/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary --allow-file-access-from-files &!'
alias weinre='$DEV/apache/incubator-cordova-weinre/weinre.server/weinre &'

################################################################################
# Git
################################################################################

# Git aliases moved to ~/.gitconfig

#alias gfo='git fetch --prune origin'
#alias gmom='git merge origin/master'

# List files that are different in my branch compared to master (files to merge to master)
#alias gdm='git diff --name-only master..HEAD | cat'

# Difftool files that are different in my branch compared to master (files to merge to master)
#alias gdtm='git diff master..HEAD'

################################################################################
# Websites
################################################################################

alias github='open https://github.com/organizations/pellucidanalytics'
#alias teamcity='open http://buildserver65/overview.html'
#alias rally='open https://rally1.rallydev.com'

################################################################################
# Homebrew
################################################################################

#alias cellar="cd $(brew --cellar)"
alias brewup="brew update; brew upgrade"

################################################################################
# JetBrains IDEs (IntelliJ IDEA, WebStorm)
################################################################################

alias idea="/Applications/IntelliJ\ IDEA\ 13\ CE.app/Contents/MacOS/idea"

################################################################################
# Java
################################################################################

export JAVA_HOME=$( /usr/libexec/java_home )

################################################################################
# Android
################################################################################

export ANDROID_HOME=~/Downloads/Android/android-sdk-macosx
appendPathDir ${ANDROID_HOME}/tools
appendPathDir ${ANDROID_HOME}/platform-tools

################################################################################
# Python
################################################################################

# Pythonbrew
#[[ -s $HOME/.pythonbrew/etc/bashrc ]] && source $HOME/.pythonbrew/etc/bashrc
#alias pbhome='cd ~/.pythonbrew'
#alias pb="pythonbrew"
#alias pbon="pythonbrew switch 2.7.3"
#alias pboff="pythonbrew off"

# pip/virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT=true
export PIP_REQUIRE_VIRTUALENV=true
export PIP_RESPECT_VIRTUALENV=true
alias vehome='cd $VIRTUAL_ENV'

syspip() {
    PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

# virtualenvwrapper
#export WORKON_HOME=~/dev/virtualenvs
#export PROJECT_HOME=~/dev/virtualprojects
#export PIP_VIRTUALENV_BASE="$WORKON_HOME"
#export VIRTUALENVWRAPPER_PROJECT_FILENAME=".project"
#export VIRTUALENVWRAPPER_HOOK_DIR
#export VIRTUALENVWRAPPER_LOG_DIR
#export VIRTUALENVWRAPPER_PYTHON
#export VIRTUALENVWRAPPER_VIRTUALENV
#export VIRTUALENVWRAPPER_VIRTUALENV_ARGS
#export VIRTUALENVWRAPPER_TMPDIR
#which virtualenvwrapper.sh >& /dev/null && source `which virtualenvwrapper.sh`
#alias wohome="cd $WORKON_HOME"
#alias projhome="cd $PROJECT_HOME"

alias pyhttp="python -m SimpleHTTPServer"

################################################################################
# Ruby
################################################################################

# RVM
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
#alias rvmhome="cd ~/.rvm"
#alias rvmon="rvm use 1.9.3 --default"
#alias rvmoff="rvm use system"

################################################################################
# Node.js
################################################################################

export NODE_PATH="/usr/local/lib/node_modules"

# This is not required for homebrew node install
prependPathDir "/usr/local/share/npm/bin"

alias npmupdate="npm update -g npm"
alias npmupdateall="npm update -g"

npmlatest() {
  curl -s "https://registry.npmjs.org/$1" | python -m json.tool | grep latest | cut -d'"' -f4
}

################################################################################
# NVM (Node version manager)
################################################################################

# Manual install
#[ -s "/Users/awhite/.nvm/nvm.sh" ] && . "/Users/awhite/.nvm/nvm.sh"
#[[ -r "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"

# Homebrew install
export NVM_DIR=~/.nvm
sourceIfExists "$(brew --prefix nvm)/nvm.sh"

################################################################################
# JavaScript/Node.js
################################################################################

alias findconsolelogs="ack -l --js 'console\.log'"
alias editconsolelogs="findconsolelogs | xargs gvim"

alias node-debug-10="nvm run v0.10.38 `which node-debug`"
alias node-debug-11="nvm run v0.11.13 `which node-debug`"
alias node-inspector-10="nvm run v0.10.38 `which node-inspector`"
alias node-inspector-11="nvm run v0.11.13 `which node-inspector`"

################################################################################
# Haxe
################################################################################

#appendPathDir "${HOME}/Downloads/Haxe/haxe-3.1.3"
export HAXE_STD_PATH="/usr/local/lib/haxe/std"
#export HAXE_STD_PATH="${HOME}/Downloads/Haxe/haxe-3.1.3"
#export HAXE_STD_PATH="/usr/lib/haxe/std"

#alias haxes="env HAXE_STD_PATH=/usr/lib/haxe/std /usr/bin/haxe"
#
local haxe_321_path="$HOME/Downloads/Haxe/haxe-3.2.1"
alias haxe321="HAXE_STD_PATH=$haxe_321_path/std $haxe_321_path/haxe"

local haxe_330_path="$HOME/Downloads/Haxe/haxe-3.3.0-rc2"
alias haxe330="HAXE_STD_PATH=$haxe_330_path/std $haxe_330_path/haxe"

alias hmmre="hmm clean && yes n | hmm install"

################################################################################
# Pellucid Analytics Shortcuts
################################################################################

clone_fork() {
  local repo="$1"
  run_command "git clone git@github.com:andywhite37/$repo"
  run_command "cd $repo"
  run_command "git remote add upstream git@github.com:pellucidanalytics/$repo"
  run_command "git fetch --all --prune"
  run_command "git branch -u upstream/master"
}

# Pellucid base repos
#alias pa="cd ~/dev/pellucidanalytics"
#alias pabootswatch="pa; cd bootlucid"
#alias pacms="pa; cd cmsapi"
#alias paeaas="pa; cd eaas"
#alias paful="pa; cd fulfilment-tools"
#alias painv="pa; cd inventory"
#alias painve="pa; cd inventory-explore"
#alias painvm="pa; cd inventory-mizuho"
#alias painvs="pa; cd inventory-spgmi"
#alias paio="pa; cd pellucid-io"
#alias papal="pa; cd pal"
#alias papptx="pa; cd pptxtemplate"
#alias pastore="pa; cd store"
#alias pavaas="pa; cd vaas"
#alias pazuul="pa; cd zuul"

# andywhite37 forks
#alias ap="cd ~/dev/andypellucid"
alias inv="aw; cd inventory"
alias inve="aw; cd inventory-explore"
alias invm="aw; cd inventory-mizuho"
alias invs="aw; cd inventory-spgmi"
alias io="aw; cd pellucid-io"
alias cms="aw; cd cmsapi"
alias pal="aw; cd pal"
alias cmsapi="cms"
alias eaas="aw; cd eaas"
alias ghost="aw; cd ghost"
alias store="aw; cd store"
alias vaas="aw; cd vaas"
alias zuul="aw; cd zuul"
alias pm="aw; cd pellmetrics"
alias pellmetrics="pm"
alias ful="aw; cd fulfilment-tools"
alias pptxt="aw; cd pptxtemplate"
alias pptxc="aw; cd pptxconvert"

# Commands/shortcuts
alias cloudfrontstatus="aws cloudfront list-distributions | jq '.DistributionList.Items | .[] | { id: .Id, domain: .Aliases.Items[0], status: .Status }'"
sourceIfExists "$HOME/.saucerc"
sourceIfExists "$HOME/.cmsapi/.cmsapirc"
alias ecms="gvim ~/.cmsapi/.cmsapirc"
alias scms="source ~/.cmsapi/.cmsapirc"

alias restoredev="(echo 'yn' | ./tools/restore-db-to-local explore-dev) && (echo 'yy' | ./migrate local)"
alias restoredevclean="(echo 'yy' | ./tools/restore-db-to-local explore-dev) && (echo 'yy' | ./migrate local)"

# Deprecated junk
#alias cdp="pa; cd cdp"
#alias cdp2="pa; cd cdp2"
#alias cdpweb="cdp; cd modules/webApp"
#alias cdpcore="cdpweb; cd core"
#alias cdptestcore="cdpweb; cd test-core"
#alias cdpdesktop="cdpweb; cd desktop"
#alias cdpmobile="cdpweb; cd mobile"
#alias cdpwstorm="cdpweb; wstorm ."
#alias cdpgvim="cdpweb; gvim ."
#alias cdpxcode="cdpmobile; cd platforms/ios; open PellucidApp.xcodeproj"
#alias cdpappcode="cdpmobile; cd platforms/ios; appcode PellucidApp.xcodeproj"
#alias cdpios="cdpappcode"
#alias cdpopen='ip; open http://$( ip ):3000'
#alias cdpopen9000='ip; open http://$( ip ):9000'
#alias cdpclean="cdp && ./cleanEverything.sh && ./cleanFrontEnd.sh"
#alias cdprun="cdp && sbt run"
#alias cdpcleanrun="cdpclean && cdprun"
#alias cdppackagejson="cdp && gvim modules/webApp/package.json modules/webApp/desktop/package.json modules/webApp/mobile/package.json modules/webApp/test-core/package.json"
#alias lui="pa; cd Lui.js"
#alias hackday="pa; cd hackday"
#alias content="pa; cd content"
#alias w2="pa; cd website2"
#
# Update a npm module in all cdp folders
#cdpupdate() {
#  cdp && cdpbump.js $1 $(npmlatest $1)
#}

################################################################################
# Travis CI
################################################################################

sourceIfExists "$HOME/.travis/travis.sh"

################################################################################
# Go Lang
################################################################################

export GOPATH="$HOME/.go"
export GOROOTx="/usr/local/opt/go/libexec/bin"
appendPathDir "$GOPATH/bin"
appendPathDir "$GOROOTx"

################################################################################
# Heroku
################################################################################

logs() {
  local appSuffix="$1"
  heroku logs --app "pellucid-$appSuffix" --tail
}

restart() {
  local appSuffix="$1"
  heroku restart --app "pellucid-$appSuffix"
}

################################################################################
# Docker
################################################################################

alias dockerdefault='(docker-machine start default || :) && (eval $(docker-machine env default))'

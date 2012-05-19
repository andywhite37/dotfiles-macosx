#! /bin/tcsh -f

################################################################################
# Destination directory (in dropbox)
################################################################################
set rootDir = "${HOME}/Dropbox/DevelopmentTools/MacMini2"
set currentDate = `date "+%Y%m%dT%H%M%S"`
set destinationDir = "${rootDir}_${currentDate}"
mkdir -p "${destinationDir}"

################################################################################
# Vim config files
################################################################################
set vimDir = "${destinationDir}/vim"
mkdir "${vimDir}"
cp ~/.vimrc "${vimDir}"
cp ~/.vimrc.old "${vimDir}"
cp ~/.vimrc.before "${vimDir}"
cp ~/.vimrc.after "${vimDir}"
cp ~/.gvimrc "${vimDir}"
cp ~/.gvimrc.before "${vimDir}"
cp ~/.gvimrc.after "${vimDir}"
cp -R ~/.janus "${vimDir}"

################################################################################
# Shell config files
################################################################################
set shellDir = "${destinationDir}/shell"
mkdir "${shellDir}"
cp ~/.tcshrc "${shellDir}"
cp ~/.prompt.tcsh "${shellDir}"
cp ~/.zshrc "${shellDir}"
cp ~/.zshenv "${shellDir}"

set omzDir = "${shellDir}/.oh-my-zsh"
mkdir -p "${omzDir}"
cp -R ~/.oh-my-zsh/custom "${omzDir}"

################################################################################
# git config files
################################################################################
set gitDir = "${destinationDir}/git"
mkdir "${gitDir}"
cp ~/.gitconfig "${gitDir}"

################################################################################
# personal bin files
################################################################################
#set binDir = "${destinationDir}/bin"
#mkdir "${binDir}"
cp -R ~/bin "${destinationDir}"

################################################################################
# python/virtualenv/virtualenvwrapper files
################################################################################
set pythonDir = "${destinationDir}/python"
set vewrapperDir = "${pythonDir}/virtualenvwrapper"
mkdir ${pythonDir}
mkdir ${vewrapperDir}
cp ~/dev/virtualenvs/postactivate "${vewrapperDir}"



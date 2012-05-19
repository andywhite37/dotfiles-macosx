#! /usr/bin/env zsh

SOURCE_ROOT=~/Dropbox/DevelopmentTools/Mac

echo "Linking shell files"
rm ~/.zshrc ~/.zshenv ~/.tcshrc ~/.prompt.tcsh >& /dev/null
ln -s $SOURCE_ROOT/.zshrc ~/.zshrc
ln -s $SOURCE_ROOT/.zshenv ~/.zshenv
ln -s $SOURCE_ROOT/.tcshrc ~/.tcshrc
ln -s $SOURCE_ROOT/.prompt.tcsh ~/.prompt.tcsh

echo "Linking vim files (.vimrc and .gvimrc created by Janus install)"
rm ~/.vimrc.before ~/.vimrc.after ~/.gvimrc.before ~/.gvimrc.after >& /dev/null
ln -s $SOURCE_ROOT/.vimrc.before ~/.vimrc.before
ln -s $SOURCE_ROOT/.vimrc.after ~/.vimrc.after
ln -s $SOURCE_ROOT/.gvimrc.before ~/.gvimrc.before
ln -s $SOURCE_ROOT/.gvimrc.after ~/.gvimrc.after

echo "Linking ~/.janus directory"
rm -rf ~/.janus >& /dev/null
ln -s $SOURCE_ROOT/.janus ~/.janus

if [[ -d ~/.oh-my-zsh/custom ]]; then
    echo "Linking .oh-my-zsh/custom files"
    rm ~/.oh-my-zsh/custom/awhite.zsh-theme >& /dev/null
    ln -s $SOURCE_ROOT/.oh-my-zsh/custom/awhite.zsh-theme ~/.oh-my-zsh/custom/awhite.zsh-theme
else
    echo ".oh-my-zsh/custom does not exist, not linking"
fi

echo "Linking git files"
rm ~/.gitconfig >& /dev/null
ln -s $SOURCE_ROOT/.gitconfig ~/.gitconfig

echo "Linking ~/bin directory"
rm -rf ~/bin >& /dev/null
ln -s $SOURCE_ROOT/bin ~/bin

if [[ -d ~/dev/virtualenvs ]]; then
    echo "Linking ~/dev/virtualenvs files"
    rm ~/dev/virtualenvs/postactivate >& /dev/null
    ln -s $SOURCE_ROOT/dev/virtualenvs/postactivate ~/dev/virtualenvs/postactivate
else
    echo "~/dev/virtualenvs does not exist, not linking"
fi


#! /usr/bin/env zsh

SOURCE_ROOT=~/Dropbox/DevelopmentTools/Mac

echo "Linking shell files"
rm ~/.zshrc ~/.zshenv ~/.tcshrc ~/.prompt.tcsh ~/.ackrc >& /dev/null
ln -s $SOURCE_ROOT/.zshrc ~
ln -s $SOURCE_ROOT/.zshenv ~
ln -s $SOURCE_ROOT/.tcshrc ~
ln -s $SOURCE_ROOT/.prompt.tcsh ~
ln -s $SOURCE_ROOT/.ackrc ~

echo "Linking vim files (.vimrc and .gvimrc created by Janus install)"
rm ~/.vimrc.before ~/.vimrc.after ~/.gvimrc.before ~/.gvimrc.after >& /dev/null
ln -s $SOURCE_ROOT/.vimrc.before ~
ln -s $SOURCE_ROOT/.vimrc.after ~
ln -s $SOURCE_ROOT/.gvimrc.before ~
ln -s $SOURCE_ROOT/.gvimrc.after ~

echo "Linking ~/.janus directory"
rm -rf ~/.janus >& /dev/null
ln -s $SOURCE_ROOT/.janus ~

if [[ -d ~/.oh-my-zsh/custom ]]; then
    echo "Linking .oh-my-zsh/custom files"
    rm ~/.oh-my-zsh/custom/awhite.zsh-theme >& /dev/null
    ln -s $SOURCE_ROOT/.oh-my-zsh/custom/awhite.zsh-theme ~/.oh-my-zsh/custom
else
    echo ".oh-my-zsh/custom does not exist, not linking"
fi

echo "Linking git files"
rm ~/.gitconfig >& /dev/null
ln -s $SOURCE_ROOT/.gitconfig ~

echo "Linking ~/bin directory"
rm -rf ~/bin >& /dev/null
ln -s $SOURCE_ROOT/bin ~/bin

if [[ -d ~/dev/virtualenvs ]]; then
    echo "Linking ~/dev/virtualenvs files"
    rm ~/dev/virtualenvs/postactivate >& /dev/null
    ln -s $SOURCE_ROOT/dev/virtualenvs/postactivate ~/dev/virtualenvs
else
    echo "~/dev/virtualenvs does not exist, not linking"
fi


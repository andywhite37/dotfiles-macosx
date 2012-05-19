#! /usr/bin/env zsh

echo "Linking shell files"
rm ~/.zshrc ~/.zshenv ~/.tcshrc ~/.prompt.tcsh >& /dev/null
ln -s ~/Dropbox/DevelopmentTools/Mac/.zshrc ~/.zshrc
ln -s ~/Dropbox/DevelopmentTools/Mac/.zshenv ~/.zshenv
ln -s ~/Dropbox/DevelopmentTools/Mac/.tcshrc ~/.tcshrc
ln -s ~/Dropbox/DevelopmentTools/Mac/.prompt.tcsh ~/.prompt.tcsh

echo "Linking vim files"
rm ~/.vimrc.before ~/.vimrc.after ~/.gvimrc.before ~/.gvimrc.after >& /dev/null
ln -s ~/Dropbox/DevelopmentTools/Mac/.vimrc.before ~/.vimrc.before
ln -s ~/Dropbox/DevelopmentTools/Mac/.vimrc.after ~/.vimrc.after
ln -s ~/Dropbox/DevelopmentTools/Mac/.gvimrc.before ~/.gvimrc.before
ln -s ~/Dropbox/DevelopmentTools/Mac/.gvimrc.after ~/.gvimrc.after

echo "Linking ~/.janus directory"
rm -rf ~/.janus >& /dev/null
ln -s ~/Dropbox/DevelopmentTools/Mac/.janus ~/.janus

if [[ -d ~/.oh-my-zsh/custom ]]; then
    echo "Linking .oh-my-zsh/custom files"
    rm ~/.oh-my-zsh/custom/awhite.zsh-theme >& /dev/null
    ln -s ~/Dropbox/DevelopmentTools/Mac/.oh-my-zsh/custom/awhite.zsh-theme ~/.oh-my-zsh/custom/awhite.zsh-theme
else
    echo ".oh-my-zsh/custom does not exist, not linking"
fi

echo "Linking git files"
rm ~/.gitconfig >& /dev/null
ln -s ~/Dropbox/DevelopmentTools/Mac/.gitconfig ~/.gitconfig

echo "Linking ~/bin directory"
rm -rf ~/bin >& /dev/null
ln -s ~/Dropbox/DevelopmentTools/Mac/bin ~/bin

if [[ -d ~/dev/virtualenvs ]]; then
    echo "Linking ~/dev/virtualenvs files"
    rm ~/dev/virtualenvs/postactivate >& /dev/null
    ln -s ~/Dropbox/DevelopmentTools/Mac/dev/virtualenvs/postactivate ~/dev/virtualenvs/postactivate
else
    echo "~/dev/virtualenvs does not exist, not linking"
fi


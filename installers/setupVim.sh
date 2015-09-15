#! /bin/bash

# get location of running script
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd ${DIR}/..

# make symlinks to config files
ln -s .vimrc

mkdir -p ~/.vim/bundle
if [ ! -d "~/.vim/bundle/Vundle.vim" ]; then
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/Bundle/Vundle.vim
fi

echo "Installing vundle packages"
vim +BundleInstall +qall

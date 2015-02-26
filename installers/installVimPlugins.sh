#! /bin/bash
mkdir ~/.vim
mkdir ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
cd ~/.vim/
sudo apt-get install silversearcher-ag
cd bundle/
git clone https://github.com/tfnico/vim-gradle
git clone https://github.com/rking/ag.vim ag
git clone https://github.com/jonathanfilip/vim-lucius
git clone https://github.com/othree/html5.vim
git clone https://github.com/Shutnik/jshint2.vim
git clone https://github.com/scrooloose/nerdcommenter
git clone https://github.com/scrooloose/nerdtree
git clone https://github.com/wting/rust.vim
git clone https://github.com/ervandew/supertab
git clone https://github.com/scrooloose/syntastic
git clone https://github.com/bling/vim-airline
git clone https://github.com/hail2u/vim-css3-syntax
git clone https://github.com/nathanaelkane/vim-indent-guides
git clone https://github.com/pangloss/vim-javascript
git clone https://github.com/elzr/vim-json
git clone https://github.com/plasticboy/vim-markdown
git clone https://github.com/terryma/vim-multiple-cursors
git clone https://github.com/tpope/vim-surround


#!/bin/bash 


VIM_ROOT=$HOME/.vim
RANDOM_NR=`shuf -i 1000-90000 -n 1`
INSTALL_ROOT=`pwd`

if [ -d $VIM_ROOT -o -L $VIM_ROOT ]; then 
    mv $VIM_ROOT $HOME/.vim_$RANDOM_NR
fi 

cd 
#checking whether install from vim-ide dir or dotfiles
BASE_INSTALL_DIR=`basename $INSTALL_ROOT`
if [ $BASE_INSTALL_DIR == "vim-ide" ];
then
    mv $INSTALL_ROOT $VIM_ROOT
else 
    ln -s $INSTALL_ROOT $VIM_ROOT
fi

if [ -f $HOME/.vimrc -o -L $HOME/.vimrc ]; then 
    mv $HOME/.vimrc $HOME/.vimrc_$RANDOM_NR
fi

ln -s $VIM_ROOT/vimrc $HOME/.vimrc

echo -e "Installing ctags"
brew install ctags

echo -e "Installing cscope"
brew install cscope

echo -e "Initializing and checking out plugins submodules: "


cd $VIM_ROOT 

git submodule init 
git submodule update 
git submodule foreach git checkout master
git submodule foreach git pull origin master

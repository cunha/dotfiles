#!/bin/bash

mkdir -p $HOME/.vim/plugins
cd $HOME/.vim/plugins
if [[ -d dein.vim ]] ; then
    (cd dein.vim ; git pull)
else
    git clone git@github.com:Shougo/dein.vim.git dein.vim
fi

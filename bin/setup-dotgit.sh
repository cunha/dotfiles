#!/bin/bash
set -eu

# This script replaces the functionality in the `ui` Ansible playbook

echo "setting up dotfiles repo"
git init --bare /home/cunha/.dotfiles
git --git-dir=/home/cunha/.dotfiles --work-tree=/home/cunha config status.showUntrackedFiles no
git --git-dir=/home/cunha/.dotfiles --work-tree=/home/cunha remote add origin git@github.com:cunha/dotfiles.git
git --git-dir=/home/cunha/.dotfiles --work-tree=/home/cunha fetch
echo "removing commonly generated files before checkout"
rm -rf bin \
        .config \
        .local/share/fonts \
        .local/share/applications \
        .ansible.cfg \
        .bashrc \
        .gdbinit \
        .gitconfig \
        .gvimrc \
        .inputrc \
        .irssi \
        .pinerc \
        .profile \
        .pylintrc \
        .screenrc \
        .tmux.conf \
        .vim \
        .vimrc \
        .xsession \
        .xprofile \
        .XCompose \
        .Xresources \
        .zshenv \
        .zshrc
echo "checking out"
git --git-dir=/home/cunha/.dotfiles --work-tree=/home/cunha pull
git --git-dir=/home/cunha/.dotfiles --work-tree=/home/cunha checkout master
echo "successfully checked out dotfiles"
echo "next: change shell to zsh"


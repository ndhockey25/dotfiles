#!/usr/bin/env zsh
git pull origin master
rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
      --exclude "README.md" --exclude "LICENSE-MIT.txt" -av --no-perms . \
      --exclude ".gitconfig" ~
source ~/.zshrc

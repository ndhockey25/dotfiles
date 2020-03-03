#!/usr/bin/env bash

export BASE_DIR=~

# Create base directory for all installs
printf "Install source directory is $BASE_DIR\n"
touch $BASE_DIR || mkdir $BASE_DIR
cd $BASE_DIR
printf "\n"

printf "Installing homebrew if it does not already exist\n"
hash brew 2>/dev/null || { ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"; }
printf "\n"

printf "Updating homebrew\n"
brew update
printf "\n"

function git-update() {
  repository=$1
  remote_url=$2
  cd $BASE_DIR
  if cd $repository 2>&1 1>/dev/null; then printf "$repository already exists. Getting latest version\n"; git pull; else git clone $remote_url; fi
  cd $BASE_DIR
}

brew install wget

printf "Installing oh-my-zsh"
wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
brew tap caskroom/fonts
brew cask install font-hack-nerd-font
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git

printf "Install Pathogen"
mkdir -p ~/.vim/autoload ~/.vim/bundle; \
curl -LSso ~/.vim/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
printf "\n"

printf "Adding gruvbox color scheme\n"
git clone https://github.com/morhetz/gruvbox.git ~/.vim/bundle/gruvbox
~/.vim/bundle/gruvbox/gruvbox_256palette_osx.sh
printf "\n"

printf "Adding iTerm color schemes\n"
git-update iTerm2-Color-Schemes https://github.com/mbadolato/iTerm2-Color-Schemes
printf "\n"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions

printf "Installing Pygments for cat syntax highlighting\n"
sudo easy_install Pygments
printf "\n"

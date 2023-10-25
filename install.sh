#!/usr/bin/env bash

# get to repo dir
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

# updates and utils
sudo apt update && sudo apt upgrade -y
sudo apt install xclip tree

# ruby apt
sudo apt install -y autoconf patch build-essential rustc libssl-dev libyaml-dev \
  libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 \
  libgdbm-dev libdb-dev uuid-dev

# vim
# Here we want to install the vundle without also trying to use it before it's
# ready. So we grab the plugin list, install it, then copy over the full .vimrc.
sudo apt install -y git curl vim vim-nox vim-gtk bash-completion
mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
grep "vundle#end" ./.vimrc -B 1000 > "$HOME/.vimrc"
vim +PluginInstall +qall
cp ./.vimrc "$HOME/.vimrc"

# asdf
git clone https://github.com/malakai97/asdf.git ~/.asdf --branch v0.13.1
. "$HOME/.asdf/asdf.sh"

asdf plugin add bat
asdf install bat latest
asdf global bat latest

asdf plugin add fd
asdf install fd latest
asdf global fd latest

asdf plugin add fzf
asdf install fzf latest
asdf global fzf latest

asdf plugin add ripgrep
asdf install ripgrep latest
asdf global ripgrep latest

asdf plugin add ruby
asdf install ruby 3.2.2
asdf global ruby 3.2.2


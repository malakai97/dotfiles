#!/bin/bash
set -e

try_bash_extension() {
  if [ -x src/configure ]; then
    src/configure && make -C src || {
      echo "Optional bash extension failed to build, but things will still work normally."
    }
  fi
}

if ! type -p git >/dev/null; then
  git() {
    echo "Error: git is required to proceed. Please install git and try again." >&2
    exit 1
  }
fi

http() {
  local url="$1"
  if type -p curl >/dev/null; then
    curl -fsSL "$url"
  elif type -p wget >/dev/null; then
    wget -q "$url" -O-
  else
    echo "Error: couldn't download file. No \`curl' or \`wget' found." >&2
    return 1
  fi
}

rbenv="$(command -v rbenv ~/.rbenv/bin/rbenv | head -1)"

if [ -n "$rbenv" ]; then
  echo "rbenv already seems installed in \`$rbenv'."
  cd "${rbenv%/*}"

  if git remote -v 2>/dev/null | grep -q rbenv; then
    echo "Trying to update with git..."
    git pull --tags origin master
    cd ..
  fi
  try_bash_extension
else
  echo "Installing rbenv with git..."
  mkdir -p ~/.rbenv
  cd ~/.rbenv
  git init
  git remote add -f -t master origin https://github.com/rbenv/rbenv.git
  git checkout -b master origin/master
  try_bash_extension
  rbenv=~/.rbenv/bin/rbenv

  if [ ! -e versions ] && [ -w /opt/rubies ]; then
    ln -s /opt/rubies versions
  fi
fi

rbenv_root="$("$rbenv" root)"
ruby_build="$(command -v "$rbenv_root"/plugins/*/bin/rbenv-install rbenv-install | head -1)"

echo
if [ -n "$ruby_build" ]; then
  echo "\`rbenv install' command already available in \`$ruby_build'."
  cd "${ruby_build%/*}"

  if git remote -v 2>/dev/null | grep -q ruby-build; then
    echo "Trying to update with git..."
    git pull origin master
  fi
else
  echo "Installing ruby-build with git..."
  mkdir -p "${rbenv_root}/plugins"
  git clone https://github.com/rbenv/ruby-build.git "${rbenv_root}/plugins/ruby-build"
fi

# Enable caching of rbenv-install downloads
mkdir -p "${rbenv_root}/cache"

echo
# echo "Running doctor script to verify installation..."
# http https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | "$BASH"

# rbenv-aliases
mkdir -p "$(rbenv root)/plugins"
git clone git://github.com/tpope/rbenv-aliases.git "$(rbenv root)/plugins/rbenv-aliases"
rbenv alias --auto

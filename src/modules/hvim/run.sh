#!/usr/bin/env sh

REPO_URL="https://github.com/hungknow/nvim-config.git"
CLONE_PATH="~/.config/nvim"

curl -L https://github.com/neovim/neovim/archive/refs/tags/stable.tar.gz -o nvim-linux64.tar.gz
tar xzvf nvim-linux64.tar.gz -C ~/
rm nvim-linux64.tar.gz
# ln -s ~/nvim-linux64/bin/nvim /usr/bin/nvim

mkdir -p "~/.config"
export PATH="~/nvim-linux64/bin;$PATH"

if [ -z "$(ls -A "$CLONE_PATH")" ]; then
  echo "Cloning $REPO_URL to $CLONE_PATH..."
  git clone "$REPO_URL" "$CLONE_PATH"
else
  echo "$CLONE_PATH already exists and isn't empty, skipping clone!"
  exit 0
fi

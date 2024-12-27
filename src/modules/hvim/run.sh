#!/usr/bin/env sh

# Create folder if not exists
mkdir -p ~/.config ~/.local 

REPO_URL="https://github.com/hungknow/nvim-config.git"
CLONE_PATH=~/.config/nvim
echo "nvim hello"
curl -L https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz -o nvim-linux64.tar.gz
tar xzvf nvim-linux64.tar.gz -C ~/.local --strip-components=1
rm nvim-linux64.tar.gz

if [ -z "$(ls -A $CLONE_PATH)" ]; then
  echo "Cloning $REPO_URL to $CLONE_PATH..."
  git clone "$REPO_URL" $CLONE_PATH
else
  echo "$CLONE_PATH already exists and isn't empty, skipping clone!"
  exit 0
fi

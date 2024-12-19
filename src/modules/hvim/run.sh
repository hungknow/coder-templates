#!/usr/bin/env bash

REPO_URL="https://github.com/hungknow/nvim-config.git"
CLONE_PATH="~/.config/nvim"

if [ -z "$(ls -A "$CLONE_PATH")" ]; then
  echo "Cloning $REPO_URL to $CLONE_PATH..."
  git clone "$REPO_URL" "$CLONE_PATH"
else
  echo "$CLONE_PATH already exists and isn't empty, skipping clone!"
  exit 0
fi

#!/usr/bin/env sh

if command -v apt >/dev/null; then
  export DEBIAN_FRONTEND=noninteractive 
  apt-get update 
  apt install -y curl unzip 
  rm -rf /var/lib/apt/lists/*
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  ./aws/install --bin-dir /usr/bin --install-dir /usr/aws-cli
  rm awscliv2.zip
elif command -v apk >/dev/null; then
  apk add --no-cache aws-cli
else
  echo 'The supported package manager not found'
  exit 127
fi

echo "Installed AWS-CLI v2"
aws --version

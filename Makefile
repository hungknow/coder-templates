build-ubuntu-nvm:
	docker build -t hungbuiknow/coder-ubuntu-nvm:latest -f ./src/dockerfile/ubuntu-nvm.Dockerfile .

coder-workspace-push:
	coder template push hungknow -y --name $@
build-ubuntu-nvm:
	docker build -t hungbuiknow/coder-ubuntu-nvm:latest -f ./src/dockerfile/ubuntu-nvm.Dockerfile .
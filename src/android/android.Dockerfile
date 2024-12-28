FROM linuxserver/rdesktop:ubuntu-openbox

# RUN sh <(curl -L https://nixos.org/nix/install) --daemon
# RUN nix-env -iA devenv -f https://github.com/NixOS/nixpkgs/tarball/nixpkgs-unstable

ENV DEBIAN_FRONTEND=noninteractive

ARG SDK_VERSION=commandlinetools-linux-11076708_latest.zip
ARG ANDROID_BUILD_VERSION=35
ARG ANDROID_TOOLS_VERSION=35.0.0
ARG NDK_VERSION=27.1.12297006
ARG NODE_VERSION=18.20
ARG WATCHMAN_VERSION=4.9.0
ARG CMAKE_VERSION=3.22.1
ARG NODE_VERSION=22
ARG USER=coder

# Install necessary dependencies for GUI support, Android/Flutter development, Linux development, CMake/Ninja, and Android Emulator
RUN apt-get update && apt-get install -y \
   apt-transport-https \
   curl \
   file \
   gcc \
   git \
   g++ \
   gnupg2 \
   libgl1 \
   libtcmalloc-minimal4 \
   make \
   openjdk-17-jdk-headless \
   openssh-client \
   patch \
   python3 \
   rsync \
   tzdata \
   unzip \
   sudo \
   ninja-build \
   zip \
   ccache \
   # Dev libraries requested by Hermes
   libicu-dev \
   # Dev dependencies required by linters
   jq \
   shellcheck \
   && rm -rf /var/lib/apt/lists/*

# Create the target user
RUN useradd --group sudo --no-create-home --shell /bin/bash ${USER} \
    && echo "${USER} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USER} \
    && chmod 0440 /etc/sudoers.d/${USER}


USER ${USER}
ENV HOME /home/${USER}
WORKDIR /home/${USER}

# Set environment variables for Android and Flutter
ENV ANDROID_HOME=$HOME/android-sdk
ENV ANDROID_SDK_ROOT=$ANDROID_HOME
ENV FLUTTER_HOME=$HOME/flutter
ENV PATH="$PATH:$FLUTTER_HOME/bin:$ANDROID_HOME/emulator:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools"


# Download and install Android SDK
RUN mkdir -p ${ANDROID_HOME}/cmdline-tools && \
   cd ${ANDROID_HOME}/cmdline-tools && \
   curl -o cmdline-tools.zip https://dl.google.com/android/repository/${SDK_VERSION} && \
   unzip cmdline-tools.zip && \
   rm cmdline-tools.zip && \
   mv cmdline-tools latest

# Accept Android SDK licenses
RUN yes | sdkmanager --licenses 
RUN sdkmanager "platform-tools" \
       "platforms;android-$ANDROID_BUILD_VERSION" \
       "build-tools;$ANDROID_TOOLS_VERSION" \
       "cmake;$CMAKE_VERSION" \
       "ndk;$NDK_VERSION" 

# Download and install Flutter SDK
RUN git clone https://github.com/flutter/flutter.git -b stable ${FLUTTER_HOME}

# Run basic check to download Dart SDK
RUN flutter doctor

# install nodejs using nvm
ENV NVM_DIR="/home/${USER}/.nvm"
RUN mkdir $NVM_DIR

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm use $NODE_VERSION \ 
    && npm install -g npm@latest \
    && npm install -g yarn 
#    && npm cache clean

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH


# Expose the necessary port numbers (adjust if necessary)
EXPOSE 8080 44300


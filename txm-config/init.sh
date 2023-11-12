#!/bin/bash

echo "alias ll='ls -alFh'" >> /root/.bashrc
echo "source /usr/share/bash-completion/completions/git" >> /root/.bashrc

# Setup custom latex package installed path
echo "export TEXMFHOME=\"/txm-config/texmf\"" >> /root/.bashrc

# Install vim & setup config
apt update && apt install vim wget zip dos2unix -y && cp /txm-config/.vimrc /root
source /root/.bashrc

# Install commonly used latex packages
tlmgr update --self
tlmgr install xecjk courier algorithms preprint enumitem xifthen ifmtarg tcolorbox environ lm-math trimspaces imakeidx marginnote

# Install latex compile tool chain
tlmgr install latexmk
tlmgr path add

# Install GitHub CLI to make integration with GitHub easy.
# This part is based on https://github.com/cli/cli/blob/trunk/docs/install_linux.md , but remove `sudo` part to make it can run in docker container
type -p curl >/dev/null || ( apt update &&  apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg |  dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&&  chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" |  tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&&  apt update \
&&  apt install gh -y

echo "To login github, please run: gh auth login"
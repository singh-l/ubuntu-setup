#!/usr/bin/env bash

set -e
set -o errexit

cd $(dirname "$(realpath "$0")")/../

# Install VSCode and pin to the version with the good sidebar icons
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/ && rm packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y clang-tools-8 bear code
sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-8 100

# Install some useful vscode extensions
code --install-extension slevesque.shader
code --install-extension ms-python.python
code --install-extension eg2.vscode-npm-script
code --install-extension guyskk.language-cython
code --install-extension msjsdiag.debugger-for-chrome
code --install-extension christian-kohler.npm-intellisense
code --install-extension kriegalex.vscode-cudacpp
code --install-extension llvm-vs-code-extensions.vscode-clangd

# Install vscode settings and keybindings
mkdir -p ~/.config/Code/User/ && cp vscode/*.json ~/.config/Code/User/

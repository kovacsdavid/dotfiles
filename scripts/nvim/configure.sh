#!/bin/bash
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
mkdir -p ~/.config/nvim
rsync -avhi ../../config/nvim/ ~/.config/nvim

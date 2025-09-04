sudo apt update && sudo apt upgrade
sudo apt install -y curl brightnessctl picom git stow i3 vim neovim \
    flameshot kitty tmux tree rofi zsh zsh-autosuggestions \
    zsh-syntax-highlighting python3 python3-pip feh textlive-fonts-extra \
    pulseaudio imagemagick
sudo snap install discord
PIP_BREAK_SYSTEM_PACKAGES=1 pip install bumblebee-status

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"


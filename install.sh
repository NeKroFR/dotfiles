#!/bin/bash

if ! command -v stow >/dev/null 2>&1; then
    echo "Error: stow is not installed"
    exit 1
fi

backup() {
    # Backup a file if it exists and is not a symlink
    local file="$HOME/$1"
    if [ -f "$file" ] && [ ! -L "$file" ]; then
        echo "Backing up $file"
        mkdir -p "$(dirname "$file.backup")"
        mv "$file" "$file.backup"
    fi
}

config_files=(
    ".gitconfig"
    ".tmux.conf"
    ".config/flameshot/flameshot.ini"
    ".config/gedit/accels"
    ".config/i3/config"
    ".config/kitty/current-theme.conf"
    ".config/kitty/kitty.conf"
    ".config/polybar/i3wmthemer_bar_launch.sh"
    ".config/polybar/polybar_config"
    ".config/rofi/config.rasi"
)

for file in "${config_files[@]}"; do
    backup "$file"
done

create_config_dirs() {
    local dirs=(
        "$HOME/.config/flameshot"
        "$HOME/.config/gedit"
        "$HOME/.config/i3"
        "$HOME/.config/kitty"
        "$HOME/.config/polybar"
        "$HOME/.config/rofi"
    )
    for dir in "${dirs[@]}"; do
        mkdir -p "$dir"
    done
}

create_config_dirs

cd "$HOME/dotfiles" || { echo "Failed to change directory to $HOME/dotfiles"; exit 1; }

packages_list=$(cat <<'EOF'
# You can comment out any package with a '#'.
flameshot
gedit
git
i3
kitty
polybar
rofi
tmux
EOF
)

echo "$packages_list" | while IFS= read -r pkg; do
    [[ "$pkg" =~ ^#.*$ || -z "$pkg" ]] && continue
    echo "Stowing $pkg..."
    stow -v --adopt --target="$HOME" "$pkg" || stow -v --target="$HOME" "$pkg"
done

echo "Verifying symlinks..."
for file in "${config_files[@]}"; do
    if [ -L "$HOME/$file" ]; then
        echo "✓ $file is properly linked"
    else
        echo "✗ $file is NOT linked"
    fi
done

echo "Dotfiles installation complete!"

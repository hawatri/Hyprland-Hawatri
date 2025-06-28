#!/bin/bash
# 💫 https://github.com/JaKooLit 💫 #
# Nordic Theme & Single Wallpaper Setup (Offline) #

engine=(
    unzip
    gtk-engine-murrine
)

## WARNING: DO NOT EDIT BEYOND THIS LINE IF YOU DON'T KNOW WHAT YOU ARE DOING! ##
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Change the working directory to the parent directory of the script
PARENT_DIR="$SCRIPT_DIR/.."
cd "$PARENT_DIR" || { echo "${ERROR} Failed to change directory to $PARENT_DIR"; exit 1; }

# Source the global functions script
if ! source "$(dirname "$(readlink -f "$0")")/Global_functions.sh"; then
  echo "Failed to source Global_functions.sh"
  exit 1
fi

# Set the name of the log file to include the current date and time
LOG="Install-Logs/install-$(date +%d-%H%M%S)_nordic-theme.log"

# installing engine needed for gtk themes
for PKG1 in "${engine[@]}"; do
    install_package "$PKG1" "$LOG"
done

# Install Nordic theme packages
printf "${NOTE} Installing ${SKY_BLUE}Nordic theme packages${RESET}...\n"
nordic_packages=(
    nordic-theme
    nordic-icon-theme
    nordic-cursor-theme
)

for nordic_pkg in "${nordic_packages[@]}"; do
    install_package "$nordic_pkg" "$LOG"
done

# Set up Nordic theme configuration for GTK
printf "${NOTE} Setting up ${SKY_BLUE}Nordic theme configuration${RESET}...\n"

GTK_CONFIG_DIR="$HOME/.config/gtk-3.0"
mkdir -p "$GTK_CONFIG_DIR"

# Create Nordic theme configuration for GTK
cat > "$GTK_CONFIG_DIR/settings.ini" << 'EOF'
[Settings]
gtk-theme-name=Nordic
gtk-icon-theme-name=Nordic
gtk-font-name=Inter 10
gtk-cursor-theme-name=Nordic
gtk-cursor-theme-size=24
gtk-toolbar-style=GTK_TOOLBAR_ICONS
gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
gtk-button-images=1
gtk-menu-images=1
gtk-enable-event-sounds=1
gtk-enable-input-feedback-sounds=0
gtk-xft-antialias=1
gtk-xft-hinting=1
gtk-xft-hintstyle=hintslight
gtk-xft-rgba=rgb
gtk-application-prefer-dark-theme=1
EOF

# Create Nordic theme configuration for Qt/KDE
mkdir -p "$HOME/.config/qt5ct"
cat > "$HOME/.config/qt5ct/qt5ct.conf" << 'EOF'
[Appearance]
icon_theme=Nordic
style=kvantum
EOF

mkdir -p "$HOME/.config/qt6ct"
cat > "$HOME/.config/qt6ct/qt6ct.conf" << 'EOF'
[Appearance]
icon_theme=Nordic
style=kvantum
EOF

echo "${OK} Nordic theme setup completed!" | tee -a "$LOG"

printf "\n%.0s" {1..2}
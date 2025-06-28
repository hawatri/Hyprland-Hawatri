#!/bin/bash
# 💫 Offline Hyprland Configuration Installation 💫 #
# Uses local HyprlandConfigExample with single theme setup

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
LOG="Install-Logs/install-$(date +%d-%H%M%S)_offline-dots.log"

printf "${NOTE} Installing ${SKY_BLUE}Offline Hyprland Configuration${RESET}....\n" | tee -a "$LOG"

# Check if HyprlandConfigExample exists
if [ ! -d "HyperlandConfigExample" ]; then
    echo "${ERROR} HyperlandConfigExample directory not found!" | tee -a "$LOG"
    exit 1
fi

# Create necessary directories
HYPR_CONFIG_DIR="$HOME/.config/hypr"
HYDE_CONFIG_DIR="$HOME/.config/hyde"
WALLPAPER_DIR="$HOME/.config/hypr/wallpapers"
SCRIPTS_DIR="$HOME/.local/share/bin"

mkdir -p "$HYPR_CONFIG_DIR"
mkdir -p "$HYDE_CONFIG_DIR"
mkdir -p "$WALLPAPER_DIR"
mkdir -p "$SCRIPTS_DIR"

echo "${OK} Created configuration directories" | tee -a "$LOG"

# Copy main Hyprland configuration files (simplified)
echo "${NOTE} Copying main Hyprland configuration..." | tee -a "$LOG"

# Copy and modify hyprland.conf (remove unnecessary exec-once commands)
cp "HyperlandConfigExample/hyprland.conf" "$HYPR_CONFIG_DIR/"
sed -i '/exec-once = kanata/d' "$HYPR_CONFIG_DIR/hyprland.conf"
sed -i '/exec-once = \[workspace 3 silent\] thorium-browser/d' "$HYPR_CONFIG_DIR/hyprland.conf"
sed -i '/exec-once = \[workspace 1 silent\] kitty/d' "$HYPR_CONFIG_DIR/hyprland.conf"
sed -i '/exec-once = \[workspace 2 silent\] dolphin/d' "$HYPR_CONFIG_DIR/hyprland.conf"

# Copy other configuration files
cp "HyperlandConfigExample/animations.conf" "$HYPR_CONFIG_DIR/"
cp "HyperlandConfigExample/monitors.conf" "$HYPR_CONFIG_DIR/"
cp "HyperlandConfigExample/nvidia.conf" "$HYPR_CONFIG_DIR/"
cp "HyperlandConfigExample/userprefs.conf" "$HYPR_CONFIG_DIR/"
cp "HyperlandConfigExample/windowrules.conf" "$HYPR_CONFIG_DIR/"

# Copy and simplify keybindings.conf (remove unnecessary bindings)
cp "HyperlandConfigExample/keybindings.conf" "$HYPR_CONFIG_DIR/"
# Remove theme switching and wallbash related keybindings
sed -i '/bind = \$mainMod+Shift, R, exec, pkill -x rofi || \$scrPath\/wallbashtoggle.sh/d' "$HYPR_CONFIG_DIR/keybindings.conf"
sed -i '/bind = \$mainMod+Shift, T, exec, pkill -x rofi || \$scrPath\/themeselect.sh/d' "$HYPR_CONFIG_DIR/keybindings.conf"
sed -i '/bind = \$mainMod+Shift, A, exec, pkill -x rofi || \$scrPath\/rofiselect.sh/d' "$HYPR_CONFIG_DIR/keybindings.conf"
sed -i '/bind = \$mainMod+Shift, X, exec, pkill -x rofi || \$scrPath\/themestyle.sh/d' "$HYPR_CONFIG_DIR/keybindings.conf"
sed -i '/bind = \$mainMod+Shift, W, exec, pkill -x rofi || \$scrPath\/swwwallselect.sh/d' "$HYPR_CONFIG_DIR/keybindings.conf"
sed -i '/bind = \$mainMod+Alt, Right, exec, \$scrPath\/swwwallpaper.sh -n/d' "$HYPR_CONFIG_DIR/keybindings.conf"
sed -i '/bind = \$mainMod+Alt, Left, exec, \$scrPath\/swwwallpaper.sh -p/d' "$HYPR_CONFIG_DIR/keybindings.conf"
sed -i '/bind = \$mainMod+Alt, Up, exec, \$scrPath\/wbarconfgen.sh n/d' "$HYPR_CONFIG_DIR/keybindings.conf"
sed -i '/bind = \$mainMod+Alt, Down, exec, \$scrPath\/wbarconfgen.sh p/d' "$HYPR_CONFIG_DIR/keybindings.conf"

# Copy themes directory
cp -r "HyperlandConfigExample/themes" "$HYPR_CONFIG_DIR/"

# Set up single theme (Nordic Blue)
echo "${NOTE} Setting up Nordic Blue theme..." | tee -a "$LOG"

# Copy Nordic Blue theme files
mkdir -p "$HYDE_CONFIG_DIR/themes/Nordic Blue"
cp -r "HyperlandConfigExample/hyde/themes/Nordic Blue"/* "$HYDE_CONFIG_DIR/themes/Nordic Blue/"

# Copy single wallpaper
cp "HyperlandConfigExample/hyde/themes/Nordic Blue/wallpapers/Nordic-Heroin.png" "$WALLPAPER_DIR/nordic-wallpaper.png"

# Create simplified hyde.conf
cat > "$HYDE_CONFIG_DIR/hyde.conf" << 'EOF'
hydeTheme="Nordic Blue"
rofiStyle="1"
enableWallDcol="0"
themeSelect="2"
EOF

# Copy wallbash directory (simplified)
mkdir -p "$HYDE_CONFIG_DIR/wallbash"
cp -r "HyperlandConfigExample/hyde/wallbash/Wall-Dcol" "$HYDE_CONFIG_DIR/wallbash/"

# Create essential scripts
echo "${NOTE} Creating essential scripts..." | tee -a "$LOG"

# Wallpaper script
cat > "$SCRIPTS_DIR/swwwallpaper.sh" << 'EOF'
#!/bin/bash
# Simple wallpaper script for single wallpaper setup

WALLPAPER_PATH="$HOME/.config/hypr/wallpapers/nordic-wallpaper.png"

if [ ! -f "$WALLPAPER_PATH" ]; then
    echo "Wallpaper not found at $WALLPAPER_PATH"
    exit 1
fi

swww img "$WALLPAPER_PATH" --transition-type any --transition-fps 60 --transition-duration 0.5
echo "Wallpaper set successfully!"
EOF

chmod +x "$SCRIPTS_DIR/swwwallpaper.sh"

# Volume control script
cat > "$SCRIPTS_DIR/volumecontrol.sh" << 'EOF'
#!/bin/bash
# Simple volume control script

case "$1" in
    -o)
        case "$2" in
            m) wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;
            i) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ ;;
            d) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- ;;
        esac
        ;;
    -i)
        case "$2" in
            m) wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle ;;
        esac
        ;;
esac
EOF

chmod +x "$SCRIPTS_DIR/volumecontrol.sh"

# Brightness control script
cat > "$SCRIPTS_DIR/brightnesscontrol.sh" << 'EOF'
#!/bin/bash
# Simple brightness control script

case "$1" in
    i) brightnessctl set 5%+ ;;
    d) brightnessctl set 5%- ;;
esac
EOF

chmod +x "$SCRIPTS_DIR/brightnesscontrol.sh"

# Screenshot script
cat > "$SCRIPTS_DIR/screenshot.sh" << 'EOF'
#!/bin/bash
# Simple screenshot script

case "$1" in
    s) grim -g "$(slurp)" - | wl-copy ;;
    sf) grim -g "$(slurp)" - | wl-copy -t image/png ;;
    m) grim -o $(hyprctl -j monitors | jq -r '.[] | select(.focused) | .name') - | wl-copy ;;
    p) grim - | wl-copy ;;
esac
EOF

chmod +x "$SCRIPTS_DIR/screenshot.sh"

# Other essential scripts
cat > "$SCRIPTS_DIR/dontkillsteam.sh" << 'EOF'
#!/bin/bash
# Don't kill steam script
hyprctl dispatch killactive
EOF

chmod +x "$SCRIPTS_DIR/dontkillsteam.sh"

cat > "$SCRIPTS_DIR/logoutlaunch.sh" << 'EOF'
#!/bin/bash
# Simple logout script
rofi -show power-menu -modi power-menu:rofi-power-menu
EOF

chmod +x "$SCRIPTS_DIR/logoutlaunch.sh"

cat > "$SCRIPTS_DIR/polkitkdeauth.sh" << 'EOF'
#!/bin/bash
# Polkit authentication script
/usr/lib/polkit-kde-authentication-agent-1 &
EOF

chmod +x "$SCRIPTS_DIR/polkitkdeauth.sh"

cat > "$SCRIPTS_DIR/resetxdgportal.sh" << 'EOF'
#!/bin/bash
# Reset XDG portal script
killall xdg-desktop-portal-hyprland
killall xdg-desktop-portal
sleep 2
/usr/lib/xdg-desktop-portal-hyprland &
sleep 2
/usr/lib/xdg-desktop-portal &
EOF

chmod +x "$SCRIPTS_DIR/resetxdgportal.sh"

cat > "$SCRIPTS_DIR/batterynotify.sh" << 'EOF'
#!/bin/bash
# Battery notification script
# This is a placeholder - implement battery monitoring if needed
echo "Battery notification script loaded"
EOF

chmod +x "$SCRIPTS_DIR/batterynotify.sh"

# Rofi launcher script
cat > "$SCRIPTS_DIR/rofilaunch.sh" << 'EOF'
#!/bin/bash
# Simple rofi launcher script
case "$1" in
    d) rofi -show drun ;;
    w) rofi -show window ;;
    f) rofi -show file-browser ;;
esac
EOF

chmod +x "$SCRIPTS_DIR/rofilaunch.sh"

# Clipboard script
cat > "$SCRIPTS_DIR/cliphist.sh" << 'EOF'
#!/bin/bash
# Simple clipboard script
case "$1" in
    c) cliphist list | rofi -dmenu | cliphist decode | wl-copy ;;
    *) cliphist list | rofi -dmenu | cliphist decode | wl-copy ;;
esac
EOF

chmod +x "$SCRIPTS_DIR/cliphist.sh"

# Keyboard switch script
cat > "$SCRIPTS_DIR/keyboardswitch.sh" << 'EOF'
#!/bin/bash
# Simple keyboard layout switch
current=$(hyprctl -j devices | jq -r '.keyboards[0].active_keymap')
if [ "$current" = "English (US)" ]; then
    hyprctl switchxkblayout at-translated-set-2-keyboard next
else
    hyprctl switchxkblayout at-translated-set-2-keyboard next
fi
EOF

chmod +x "$SCRIPTS_DIR/keyboardswitch.sh"

# Keybinds hint script
cat > "$SCRIPTS_DIR/keybinds_hint.sh" << 'EOF'
#!/bin/bash
# Simple keybinds hint
echo "Keybinds hint - implement as needed"
EOF

chmod +x "$SCRIPTS_DIR/keybinds_hint.sh"

# Window pin script
cat > "$SCRIPTS_DIR/windowpin.sh" << 'EOF'
#!/bin/bash
# Window pin script
hyprctl dispatch pin
EOF

chmod +x "$SCRIPTS_DIR/windowpin.sh"

# System monitor script
cat > "$SCRIPTS_DIR/sysmonlaunch.sh" << 'EOF'
#!/bin/bash
# System monitor launcher
if command -v btop &> /dev/null; then
    kitty --title "btop" btop
elif command -v htop &> /dev/null; then
    kitty --title "htop" htop
else
    kitty --title "top" top
fi
EOF

chmod +x "$SCRIPTS_DIR/sysmonlaunch.sh"

# Game mode script
cat > "$SCRIPTS_DIR/gamemode.sh" << 'EOF'
#!/bin/bash
# Game mode script
echo "Game mode - implement as needed"
EOF

chmod +x "$SCRIPTS_DIR/gamemode.sh"

echo "${OK} All essential scripts created" | tee -a "$LOG"

# Set proper permissions
chmod -R 755 "$HYPR_CONFIG_DIR"
chmod -R 755 "$HYDE_CONFIG_DIR"
chmod -R 755 "$SCRIPTS_DIR"

# Set up Waybar and Rofi configs with Nordic Blue theme
WAYBAR_CONFIG_DIR="$HOME/.config/waybar"
ROFI_CONFIG_DIR="$HOME/.config/rofi"
mkdir -p "$WAYBAR_CONFIG_DIR"
mkdir -p "$ROFI_CONFIG_DIR"

# Copy waybar.theme as config and style.css
cp "$HYDE_CONFIG_DIR/themes/Nordic Blue/waybar.theme" "$WAYBAR_CONFIG_DIR/config"
cp "$HYDE_CONFIG_DIR/themes/Nordic Blue/waybar.theme" "$WAYBAR_CONFIG_DIR/style.css"

# Copy rofi.theme as config.rasi
cp "$HYDE_CONFIG_DIR/themes/Nordic Blue/rofi.theme" "$ROFI_CONFIG_DIR/config.rasi"

echo "${OK} Offline Hyprland configuration installed successfully!" | tee -a "$LOG"
echo "${NOTE} Configuration location: $HYPR_CONFIG_DIR" | tee -a "$LOG"
echo "${NOTE} Theme location: $HYDE_CONFIG_DIR" | tee -a "$LOG"
echo "${NOTE} Scripts location: $SCRIPTS_DIR" | tee -a "$LOG"

printf "\n%.0s" {1..2} 
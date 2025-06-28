#!/bin/bash
# 💫 Wallpaper and Theme Setup Script 💫 #
# This script sets up a single wallpaper and Nordic theme for Hyprland

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration directories
HYPR_CONFIG_DIR="$HOME/.config/hypr"
WALLPAPER_DIR="$HOME/.config/hypr/wallpapers"
GTK_CONFIG_DIR="$HOME/.config/gtk-3.0"
KDE_CONFIG_DIR="$HOME/.config/kdeglobals"

echo -e "${BLUE}Setting up Nordic theme and single wallpaper...${NC}"

# Create necessary directories
mkdir -p "$WALLPAPER_DIR"
mkdir -p "$HYPR_CONFIG_DIR"

# Create wallpaper configuration script
cat > "$HYPR_CONFIG_DIR/wallpaper.sh" << 'EOF'
#!/bin/bash
# Wallpaper configuration script for Hyprland
# This script sets the wallpaper using swww

WALLPAPER_PATH="$HOME/.config/hypr/wallpapers/nordic-wallpaper.jpg"

# Check if wallpaper exists
if [ ! -f "$WALLPAPER_PATH" ]; then
    echo "Wallpaper not found at $WALLPAPER_PATH"
    echo "Please place your wallpaper as 'nordic-wallpaper.jpg' in the wallpapers folder"
    exit 1
fi

# Set wallpaper using swww
swww img "$WALLPAPER_PATH" --transition-type any --transition-fps 60 --transition-duration 0.5

echo "Wallpaper set successfully!"
EOF

# Make the wallpaper script executable
chmod +x "$HYPR_CONFIG_DIR/wallpaper.sh"

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
color_scheme_path=/usr/share/qt5ct/colors/nordic.conf
custom_palette=false
standard_dialogs=gtk2
style=Fusion

[Fonts]
fixed=@Variant(\0\0\0@\0\0\0\x12\0I\0n\0t\0e\0r\0@$\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)
general=@Variant(\0\0\0@\0\0\0\x12\0I\0n\0t\0e\0r\0@$\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)

[Interface]
activate_item_on_single_click=1
buttonbox_layout=0
cursor_flash_time=1000
dialog_buttons_have_icons=1
double_click_interval=400
gui_effects=General, AnimateMenu, AnimateCombo, AnimateTooltip, AnimateToolBox
keyboard_scheme=2
menus_have_icons=1
show_shortcuts_in_context_menus=1
stylesheets=@Invalid()
toolbutton_style=4
underline_shortcut=1
wheel_scroll_lines=3

[PaletteEditor]
geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\0\0\0\0\0\0\0\x2\x7f\0\0\x2\x13\0\0\0\0\0\0\0\0\0\0\x2\x7f\0\0\x2\x13\0\0\0\0\x2\0\0\0\a\x80\0\0\0\0\0\0\0\0\0\0\x2\x7f\0\0\x2\x13)

[SettingsWindow]
geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\0\0\0\0\0\0\0\x2\x7f\0\0\x2\x13\0\0\0\0\0\0\0\0\0\0\x2\x7f\0\0\x2\x13\0\0\0\0\x2\0\0\0\a\x80\0\0\0\0\0\0\0\0\0\0\x2\x7f\0\0\x2\x13)
EOF

# Create Nordic color scheme for Qt5
mkdir -p "$HOME/.config/qt5ct/colors"
cat > "$HOME/.config/qt5ct/colors/nordic.conf" << 'EOF'
[ColorEffects:Disabled]
ColorAmount=0.56
ColorEffect=0
ContrastAmount=0.65
ContrastEffect=1
IntensityAmount=0.1
IntensityEffect=2

[ColorEffects:Inactive]
ChangeSelectionColor=true
ColorAmount=0.025
ColorEffect=2
ContrastAmount=0.1
ContrastEffect=2
Enable=false
IntensityAmount=0
IntensityEffect=0

[Colors:Window]
BackgroundAlternate=#3b4252
BackgroundNormal=#2e3440
DecorationFocus=#5e81ac
DecorationHover=#81a1c1
ForegroundActive=#eceff4
ForegroundInactive=#4c566a
ForegroundLink=#5e81ac
ForegroundNegative=#bf616a
ForegroundNeutral=#d08770
ForegroundNormal=#eceff4
ForegroundPositive=#a3be8c
ForegroundVisited=#b48ead

[Colors:Button]
BackgroundAlternate=#3b4252
BackgroundNormal=#3b4252
DecorationFocus=#5e81ac
DecorationHover=#81a1c1
ForegroundActive=#eceff4
ForegroundInactive=#4c566a
ForegroundLink=#5e81ac
ForegroundNegative=#bf616a
ForegroundNeutral=#d08770
ForegroundNormal=#eceff4
ForegroundPositive=#a3be8c
ForegroundVisited=#b48ead

[Colors:Selection]
BackgroundAlternate=#5e81ac
BackgroundNormal=#5e81ac
DecorationFocus=#5e81ac
DecorationHover=#81a1c1
ForegroundActive=#eceff4
ForegroundInactive=#4c566a
ForegroundLink=#5e81ac
ForegroundNegative=#bf616a
ForegroundNeutral=#d08770
ForegroundNormal=#eceff4
ForegroundPositive=#a3be8c
ForegroundVisited=#b48ead

[Colors:Tooltip]
BackgroundAlternate=#3b4252
BackgroundNormal=#2e3440
DecorationFocus=#5e81ac
DecorationHover=#81a1c1
ForegroundActive=#eceff4
ForegroundInactive=#4c566a
ForegroundLink=#5e81ac
ForegroundNegative=#bf616a
ForegroundNeutral=#d08770
ForegroundNormal=#eceff4
ForegroundPositive=#a3be8c
ForegroundVisited=#b48ead

[Colors:Complementary]
BackgroundAlternate=#3b4252
BackgroundNormal=#2e3440
DecorationFocus=#5e81ac
DecorationHover=#81a1c1
ForegroundActive=#eceff4
ForegroundInactive=#4c566a
ForegroundLink=#5e81ac
ForegroundNegative=#bf616a
ForegroundNeutral=#d08770
ForegroundNormal=#eceff4
ForegroundPositive=#a3be8c
ForegroundVisited=#b48ead

[General]
ColorScheme=Nordic
Name=Nordic
shadeSortColumn=true

[KDE]
contrast=4

[Mouse]
cursor_size=24
EOF

# Create a README file with instructions
cat > "$WALLPAPER_DIR/README.md" << 'EOF'
# Wallpaper Setup

## Nordic Theme Wallpaper

Place your wallpaper image in this folder with the name `nordic-wallpaper.jpg`

The wallpaper will be automatically set when you run the wallpaper script.

## Usage

To set the wallpaper, run:
```bash
~/.config/hypr/wallpaper.sh
```

## Supported Formats

- JPG/JPEG
- PNG
- WebP
- Any format supported by swww

## Theme Information

This setup uses the Nordic color scheme:
- Primary: #2e3440 (Dark background)
- Secondary: #3b4252 (Lighter background)
- Accent: #5e81ac (Blue accent)
- Text: #eceff4 (Light text)
- Red: #bf616a
- Orange: #d08770
- Yellow: #ebcb8b
- Green: #a3be8c
- Purple: #b48ead
EOF

# Create a simple wallpaper placeholder (you can replace this with your actual wallpaper)
echo -e "${YELLOW}Creating placeholder wallpaper...${NC}"
echo -e "${GREEN}Please replace the placeholder wallpaper with your desired Nordic-themed wallpaper${NC}"

# Create a simple text-based placeholder (you can replace this with an actual image)
cat > "$WALLPAPER_DIR/nordic-wallpaper.jpg" << 'EOF'
# This is a placeholder file
# Please replace this with your actual Nordic-themed wallpaper image
# Supported formats: JPG, PNG, WebP
EOF

echo -e "${GREEN}✓ Nordic theme and wallpaper setup completed!${NC}"
echo -e "${BLUE}Configuration files created in:${NC}"
echo -e "  - ${YELLOW}$HYPR_CONFIG_DIR/wallpaper.sh${NC} (Wallpaper script)"
echo -e "  - ${YELLOW}$GTK_CONFIG_DIR/settings.ini${NC} (GTK theme)"
echo -e "  - ${YELLOW}$HOME/.config/qt5ct/${NC} (Qt theme)"
echo -e "  - ${YELLOW}$WALLPAPER_DIR/${NC} (Wallpaper directory)"
echo -e ""
echo -e "${GREEN}Next steps:${NC}"
echo -e "1. Place your Nordic-themed wallpaper as 'nordic-wallpaper.jpg' in $WALLPAPER_DIR"
echo -e "2. Run the wallpaper script: ${YELLOW}~/.config/hypr/wallpaper.sh${NC}"
echo -e "3. The Nordic theme will be applied automatically"
echo -e ""
echo -e "${BLUE}Note:${NC} You may need to install Nordic theme packages if not already installed:"
echo -e "  - nordic-theme (AUR)"
echo -e "  - nordic-icon-theme (AUR)"
</rewritten_file> 
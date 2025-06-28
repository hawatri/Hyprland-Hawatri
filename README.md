<div align="center">

# 🚀 **Hawatri's Arch - Hyprland Install Script** 🚀

<br/>
</div>

<div align="center">
<br>
  <a href="#-features-"><kbd> <br> Features <br> </kbd></a>&ensp;&ensp;
  <a href="#-installation-"><kbd> <br> Installation <br> </kbd></a>&ensp;&ensp;
  <a href="#-configuration-"><kbd> <br> Configuration <br> </kbd></a>&ensp;&ensp;
  <a href="#-troubleshooting-"><kbd> <br> Troubleshooting <br> </kbd></a>
 </div><br>

## ✨ Features

- **🔄 Fully Offline Installation** - No internet required after cloning
- **🎨 Single Theme Setup** - Nordic Blue theme with minimal configuration
- **⚡ Optimized Performance** - No animations, 0 gaps, thin borders
- **🖥️ Complete Desktop Environment** - Hyprland, Waybar, Rofi, and more
- **🎯 NVIDIA Support** - Automatic detection and driver installation
- **🔧 Modular Design** - Easy to customize and extend

### What's Included

- **Window Manager**: Hyprland with optimized configuration
- **Status Bar**: Waybar with Nordic Blue theme
- **Application Launcher**: Rofi with Nordic Blue theme
- **Terminal**: Kitty with Nordic Blue theme
- **File Manager**: Thunar (optional)
- **Login Manager**: SDDM with custom theme (optional)
- **Audio**: Pipewire setup
- **Themes**: Nordic GTK, Qt, and cursor themes

## 🚀 Installation

### Prerequisites

- Arch Linux (minimal/server installation recommended)
- Internet connection for initial package downloads
- Backup your system before installation (recommended)

### Quick Install

```bash
# Clone the repository
git clone https://github.com/your-username/Hyprland-Hawatri.git
cd Hyprland-Hawatri

# Make executable and run
chmod +x install.sh
./install.sh
```

### Installation Options

During installation, you'll be prompted to select:

- **NVIDIA Configuration** - Install NVIDIA drivers (if detected)
- **GTK Themes** - Install Nordic theme packages
- **Bluetooth** - Configure Bluetooth support
- **Thunar** - Install Thunar file manager
- **AGS** - Install AGS for desktop overview
- **XDG Portal** - Install screen sharing support
- **SDDM** - Install and configure SDDM login manager
- **Offline Configuration** - Install pre-configured Hyprland setup

## ⚙️ Configuration

### Default Settings

- **Animations**: Disabled for maximum performance
- **Gaps**: 0 (no gaps between windows)
- **Borders**: 1px thin borders
- **Theme**: Nordic Blue throughout
- **Wallpaper**: Nordic Heroin (included)

### Keybindings

- `Super + Enter` - Open terminal
- `Super + F` - Open file manager
- `Super + C` - Open code editor
- `Super + B` - Open browser
- `Super + R` - Application launcher
- `Super + Tab` - Window switcher
- `Super + Q` - Close window
- `Super + L` - Lock screen
- `Super + Backspace` - Logout menu

### Customization

All configuration files are located in:
- `~/.config/hypr/` - Hyprland configuration
- `~/.config/waybar/` - Waybar configuration
- `~/.config/rofi/` - Rofi configuration
- `~/.config/hyde/` - Theme management

## 🔧 Troubleshooting

### NVIDIA Issues

If you experience issues with NVIDIA:

1. Ensure you selected NVIDIA option during installation
2. Reboot after installation
3. Check if drivers are loaded: `nvidia-smi`
4. For external monitors, add to `~/.config/hypr/nvidia.conf`:
   ```
   env = WLR_DRM_DEVICES,/dev/dri/cardX
   ```

### Audio Issues

If audio doesn't work:

1. Ensure Pipewire is running: `systemctl --user status pipewire`
2. Check audio devices: `wpctl status`
3. Restart Pipewire: `systemctl --user restart pipewire`

### Login Issues

If stuck at login screen:

1. Press `Ctrl + Alt + F2` to access TTY
2. Login and check services: `systemctl status sddm`
3. Restart display manager: `sudo systemctl restart sddm`

## 📁 Project Structure

```
Arch-Hyprland/
├── install.sh                 # Main installation script
├── HyperlandConfigExample/    # Offline configuration files
│   ├── hyprland.conf         # Main Hyprland config
│   ├── keybindings.conf      # Keybindings
│   ├── themes/               # Theme configurations
│   └── hyde/                 # Theme management
├── install-scripts/          # Modular installation scripts
│   ├── dotfiles-offline.sh   # Offline config installer
│   ├── gtk_themes.sh         # Theme installation
│   ├── nvidia.sh            # NVIDIA driver setup
│   └── ...
└── README.md                 # This file
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### Development

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- **Hyprland Team** - For the amazing window manager
- **Nordic Theme** - For the beautiful theme
- **Arch Linux Community** - For the excellent documentation

## 📞 Support

If you encounter any issues:

1. Check the troubleshooting section above
2. Search existing issues
3. Create a new issue with detailed information

---

<div align="center">

**Built with ❤️ by Hawatri**

[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/your-username)

</div> 
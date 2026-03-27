# ROG Dashboard & Guardian for Linux (ASUS Laptops)

A lightweight, Zenity-based graphical interface and background thermal monitor specifically optimized for ASUS ROG/TUF laptops running **Debian 13 (Trixie)** with **Wayland**.

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Platform](https://img.shields.io/badge/platform-Debian%2013%20%7C%20Ubuntu-orange.svg)

## 🌟 Features

- **Performance Profiles**: Quickly switch between `Quiet`, `Balanced`, and `Turbo` modes via `asusctl`.
- **Graphics Control**: Manage your MUX Switch (`Hybrid`, `Dedicated`, `Integrated`) via `supergfxctl`.
- **Thermal Guardian**: A background service that monitors CPU temperatures and automatically kicks into `Turbo` mode if the system exceeds 80°C.
- **Battery Health**: Set an 80% charge limit to extend the lifespan of your battery.
- **Aura Lighting**: Simple controls for keyboard backlighting (Rainbow/Off).
- **Wayland Optimized**: Fixed issues with display refreshing and Zenity UI glitches common in Wayland environments.

## 📦 Installation

### Prerequisites
Ensure you have the official ASUS Linux tools installed on your system:
- `asusctl`
- `supergfxctl`

### Using the `.deb` Package (Recommended)
Download the latest release and install it using `apt` to automatically handle dependencies:

```bash
sudo apt update
sudo apt install ./rog-tools-custom.deb
```

### Manual Installation
If you prefer to run the scripts directly:

Clone the repo: git clone https://github.com/yourusername/rog-tools.git

Make scripts executable: chmod +x src/*.sh

Run the dashboard: ./src/rog_dashboard.sh

Starting the Thermal Guardian
To protect your laptop during heavy tasks (gaming/rendering), select "Start Guardian" from the menu. It will:

Monitor temps every 10 seconds.

Switch to Turbo at > 80°C.

Return to Balanced once cooled to < 60°C.

### ⚠️ Important Notes for Debian 13 Users
Logout Required: Switching Graphics Modes (e.g., to Dedicated) will force a logout to restart the Wayland compositor on the correct GPU.

Zenity UI: This version uses a simplified list structure to avoid "Option not available" errors found in newer GNOME/Zenity versions.

### 🤝 Contributing
Feel free to open issues or submit pull requests. If you have a different ASUS model and need specific thermal zone adjustments, please let me know!
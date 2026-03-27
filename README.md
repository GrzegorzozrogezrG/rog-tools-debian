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

## 🛠 Prerequisites: Installing ASUS Tools on Debian 13

Since `asusctl` and `supergfxctl` are not in the official Debian repositories, you need to add a dedicated repository or build them from source. 

### **The Easiest Way (grawity's repository)**
Grawity provides a repository that works well with Debian Testing/Unstable. Run these commands as root:

1. **Add the repository key:**
   ```bash
   sudo wget -O /usr/share/keyrings/grawity-asus.gpg https://pkg.pks.org.uk/repo/asus-linux/dists/debian/Release.key
   ```
2. **Add the source list:**
    ```bash
    echo "deb [signed-by=/usr/share/keyrings/grawity-asus.gpg] https://pkg.pks.org.uk/repo/asus-linux/debian testing main" | sudo tee /etc/apt/sources.list.d/asus-linux.list
    ```

3. **Install the tools**
    ```bash
    sudo apt update
    sudo apt install asusctl supergfxctl
    ```
4. **Enable services:**
    ```bash
    sudo systemctl enable --now asusd supergfxd
    ```


Note: If you encounter dependency issues, you might need to install rustc and cargo as these tools are written in Rust.


### **Troubleshooting: Manual Build from Source**
If the repository above doesn't support your specific architecture or if you face dependency issues, you must build the tools from source using the Rust toolchain.

1. **Install Build Essentials:**
   ```bash
   sudo apt install build-essential git cmake pkg-config libclang-dev libudev-dev libfontconfig1-dev
   ```
2. **Install the Rust Toolchain:**
    Do not use apt install rustc as it's often outdated for these tools.
    ```bash
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source $HOME/.cargo/env
    ```
3. **Clone and build asusctl:**
    ```bash
    git clone https://gitlab.com/asus-linux/asusctl.git
    cd asusctl
    make
    sudo make install
    ```
4. **Clone and Build supergfxctl:**
    ```bash
    git clone https://gitlab.com/asus-linux/supergfxctl.git
    cd supergfxctl
    make
    sudo make install
    ```
5. **after a manual build, you still need to enable the services via systemctl:**
    ```bash
    sudo systemctl enable --now asusd supergfxd
    ```

### Using the `.deb` Package (Recommended)
Download the latest release and install it using `apt` to automatically handle dependencies:

```bash
sudo apt update
sudo apt install ./rog-tools-custom_1.0.1.deb
```

### Manual Installation
If you prefer to run the scripts directly:

Clone the repo

Make scripts executable: chmod +x src/*.sh

Run the dashboard: ./src/rog_dashboard.sh

Starting the Thermal Guardian
To protect your laptop during heavy tasks (gaming/rendering), select "Start Guardian" from the menu. It will:

Monitor temps every 10 seconds.

Switch to Turbo at > 80°C.

Return to Balanced once cooled to < 60°C.


### 🔧 Service Setup
After installing the tools, ensure the background services are active:
```bash
sudo systemctl enable --now asusd supergfxd
```
## 🛠 Dependencies

This tool requires `zenity` for the graphical interface and `libnotify-bin` for system notifications. To install them, use the command for your distribution:

### **Debian / Ubuntu / Kali / Pop!_OS**
```bash
sudo apt update
sudo apt install zenity libnotify-bin asusctl supergfxctl
```


### ⚠️ Important Notes for Debian 13 Users
Logout Required: Switching Graphics Modes (e.g., to Dedicated) will force a logout to restart the Wayland compositor on the correct GPU.

Zenity UI: This version uses a simplified list structure to avoid "Option not available" errors found in newer GNOME/Zenity versions.

### 🤝 Contributing
Feel free to open issues or submit pull requests. If you have a different ASUS model and need specific thermal zone adjustments, please let me know!

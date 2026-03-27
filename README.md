# 🚀 ROG Tools for Debian (Strix G513RC)

A lightweight suite designed to manage cooling, GPU modes, and RGB lighting on the **ASUS ROG Strix G513RC** running Debian. This project replaces the need for heavy Windows software with native, efficient Linux scripts.

---

## ✨ Main Features

* **ROG Dashboard**: A graphical interface (Zenity) for quick access to hardware settings.
* **ROG Guardian**: An automated background script that monitors CPU temperatures and switches performance profiles.
* **MUX Switch Support**: One-click switching between `Hybrid` and `AsusMuxDgpu` (Dedicated) modes.
* **Aura Sync**: Quick presets for keyboard and lightbar RGB effects.
* **Battery Care**: Set a 80% charge threshold to extend battery lifespan.

---

## 📋 Prerequisites

This suite depends on the following tools:
* `asusctl` (v6.x+)
* `supergfxctl`
* `zenity`
* `libnotify-bin`

Install them on Debian using:
```bash
sudo apt update && sudo apt install asusctl supergfxctl zenity libnotify-bin
```

## 📦 Installation
Using the .deb package (Recommended)
```bash
sudo apt install ./rog-tools-v1.deb
```
## Manual Installation
Copy **rog_dashboard.sh** and **rog_guardian.sh** to **/usr/local/bin/**

Ensure they are executable: **chmod +x /usr/local/bin/rog-*.**

Add the .desktop file to ~/.local/share/applications/.

## 🎮 Usage
Launching the Dashboard
Search for "ROG Dashboard" in your application menu or run:

```bash
rog-dashboard
```
How "The Guardian" Works
The script monitors /sys/class/thermal/thermal_zone0/. If the temperature exceeds 75°C, it automatically sets the profile to Turbo. It reverts to Balanced once the system cools down.

## ⚠️ GPU Mode Warning
Switching to MUX (dGPU) mode will log you out of your current session. Save your work before switching!

🤝 Credits
Created by me... # rog-tools-debian

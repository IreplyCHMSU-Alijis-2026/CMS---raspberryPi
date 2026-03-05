# Raspberry Pi Digital Signage Player  
## Initial Setup & Testing

This repository contains the **initial infrastructure setup and testing configuration** for the Raspberry Pi digital signage edge device.

This phase focuses only on:

- Base OS configuration
- Wayland kiosk setup
- systemd service for local test server
- Chromium crash handling
- Display configuration
- Device lockdown behavior

This is the foundation before integrating the full CMS, WebSocket logic, and remote management.

---

# What This Initial Setup Achieves

After completing this setup, the Raspberry Pi:

- Boots automatically into Wayland
- Starts a Node.js test server via systemd
- Launches Chromium in kiosk mode
- Connects to a configurable endpoint
- Restarts automatically if Chromium crashes
- Restarts automatically if the Node server crashes
- Hides the mouse cursor
- Disables Alt+Tab and terminal shortcuts
- Prevents screen sleep
- Runs at native HDMI resolution (1024x768)

The device behaves like a locked-down digital signage appliance.

---

# Summary of `configs.md`

The `configs.md` document contains the detailed configuration and testing notes from this phase. It covers:

## 1. systemd Service Configuration

- Creation of `signages-server.service`
- Running `server.js` as a background service
- Automatic restart policy
- Correct user configuration
- Boot-time activation

## 2. Wayfire (Wayland) Configuration

- Autostarting the kiosk script
- Disabling DPMS (screen sleep)
- Forcing display scale to 1
- Removing unnecessary plugins to lock the system
- Enabling `hide-cursor` plugin

This section explains how Wayfire plugins control:

- Window switching
- Keyboard shortcuts
- Workspace management

And how removing them creates a true kiosk environment.

## 3. Kiosk Script Behavior

- Why a startup delay (`sleep 5`) is required
- Why `config.env` is sourced
- How Chromium crash recovery popups are prevented
- How the infinite restart loop ensures resilience
- Required Chromium flags for kiosk stability

## 4. Display & Scaling Fixes

- Native HDMI resolution setup
- Fixing Chromium rendering issues
- Ensuring no scaling artifacts under Wayland

## 5. Issues Encountered and Resolved

- systemd `217/USER` error
- Chromium not entering full screen
- Keyring popup issue
- Mouse cursor visibility
- Unexpected keyboard shortcuts still working
- Wayland scaling behavior

---

# Architecture (Initial Local Test Mode)

```
Raspberry Pi
│
├── systemd
│     └── signages-server.service
│           └── node server.js
│
├── Wayfire (Wayland)
│     └── autostart
│           └── kiosk.sh
│                 └── Chromium
│                       └── http://localhost:3000
│
└── HDMI Output (1024x768)
```

---

# Scope of This Phase

This is strictly the **base infrastructure phase**.

Not included yet:

- WebSocket state management
- Playlist manifest logic
- Emergency interrupt handling
- Remote CMS integration
- Tailscale remote connectivity
- Multi-device provisioning

Those will build on top of this stable kiosk foundation.

---

# Current Status

The Raspberry Pi is stable and operating as a hardened signage edge device suitable for further development and integration.

This concludes the initial setup and testing phase.
# Raspberry Pi Signage Player  
## Testing Summary (Wayland + systemd)

---

## Environment

- OS: Raspberry Pi OS (Full)
- Session: LXDE-pi-wayfire (Wayland)
- User: `vers`
- Display: 1024x768 @ 60Hz
- Browser: Chromium
- Test Endpoint: `http://localhost:3000`

---

## systemd Test Server

Service file:

`/etc/systemd/system/signages-server.service`

```ini
[Unit]
Description=Signage Test Server
After=network.target

[Service]
WorkingDirectory=/home/vers/signage/server
ExecStart=/usr/bin/node server.js
Restart=always
RestartSec=5
User=vers
Environment=NODE_ENV=production

[Install]
WantedBy=multi-user.target
```

### Result

- Server starts on boot  
- Auto-restarts on crash  
- Runs under correct user  

---

## Wayfire Configuration

`~/.config/wayfire.ini`

```ini
[autostart]
kiosk = /home/vers/signage/scripts/kiosk.sh

[idle]
dpms_timeout = -1

[output]
scale = 1

[core]
plugins = autostart hide-cursor
```

### Key Points

- `dpms_timeout = -1` prevents screen sleep  
- `scale = 1` fixes rendering/scaling issue  
- Removing other plugins disables:
  - Alt+Tab
  - Ctrl+Alt+T
  - Window switching  

Result: Fully locked kiosk environment.

---

## Kiosk Script Behavior (Summary)

The script:

- Waits 5 seconds for Wayland initialization  
- Loads `config.env` to get `ENDPOINT`  
- Prevents Chromium crash restore popup  
- Launches Chromium in kiosk mode  
- Restarts Chromium automatically if it crashes  

### Why `sleep 5`?

Wayland must initialize before Chromium launches to avoid crash loops.

### Why `source config.env`?

Wayfire autostart does not inherit shell environment variables.  
Sourcing ensures `ENDPOINT` is defined.

---

## Issues Resolved

### 1. systemd Error 217/USER
Cause: Incorrect user in service file  
Fix: Set `User=vers`

### 2. Chromium Not Fullscreen / Small in Corner
Cause: Scaling mismatch  
Fix:
- Set `scale = 1`
- Use correct HDMI resolution
- Use `--start-maximized`

### 3. Keyring Popup
Fix: `--password-store=basic`

### 4. Mouse Cursor Visible
Fix: `hide-cursor` plugin

### 5. Keyboard Shortcuts Still Working
Fix: Remove `switcher` and `command` plugins

---

## Current Architecture

```
Raspberry Pi
│
├── systemd → signages-server.service → node server.js
│
├── Wayfire
│     └── autostart → kiosk.sh
│           └── Chromium → localhost:3000
│
└── HDMI Output (1024x768)
```

---

## Final State

- Auto-boot
- Auto-start server
- Auto-start Chromium
- Crash auto-recovery
- No cursor
- No Alt+Tab
- No escape shortcuts
- No screen sleep

System behaves as a locked-down digital signage appliance.
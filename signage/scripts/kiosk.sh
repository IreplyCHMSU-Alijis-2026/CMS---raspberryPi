#!/bin/bash

# Wait for X11 desktop to load
sleep 5

# Source your config
source /home/$(whoami)/signage/config/config.env

# Disable screen blanking & power saving
xset s off
xset -dpms
xset s noblank

# Fix Chromium crash recovery
sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' ~/.config/chromium/Default/Preferences 2>/dev/null || true
sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/' ~/.config/chromium/Default/Preferences 2>/dev/null || true

unclutter -idle 0 &

# Launch Chromium in kiosk
while true; do
  chromium \
    --kiosk \
    --start-maximized \
    --disable-gpu \
    --disable-software-rasterizer \
    --disable-accelerated-video-decode \
    --disable-accelerated-2d-canvas \
    --use-gl=swiftshader \
    --noerrdialogs \
    --disable-infobars \
    --autoplay-policy=no-user-gesture-required \
    --password-store=basic \
    --disable-session-crashed-bubble \
    --no-first-run \
    --disable-restore-session-state \
    "$ENDPOINT"

  sleep 2
done


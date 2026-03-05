#!/bin/bash

# this sleep is needed because if wayland is not ready, chromium will fail to launch and crash loop
sleep 5

# source the config file to get the ENDPOINT variable
source /home/$(whoami)/signage/config.env

# crash loop prevention: set exited_cleanly to true and exit_type to Normal in the Chromium preferences file
sed -i 's/"exited_cleanly":false/"exited_cleanly":true/' ~/.config/chromium/Default/Preferences 2>/dev/null || true
sed -i 's/"exit_type":"Crashed"/"exit_type":"Normal"/' ~/.config/chromium/Default/Preferences 2>/dev/null || true

# Launch Chromium
while true; do
  chromium \
    --kiosk \
    --ozone-platform=wayland \
    --start-maximized \
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
# The loop will restart Chromium if it crashes, with a 2-second delay to prevent rapid crash loops.



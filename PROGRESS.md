# Development Notes – Raspberry Pi Signage Player

This document records the major configuration changes, challenges encountered during development, and the solutions implemented while setting up the Raspberry Pi digital signage player.

---

# 1. Wayland to X11 Migration

## Issue

The initial setup attempted to use **Wayland-based compositors** such as:

- Wayfire
- Labwc
- seatd

However, multiple problems were encountered:

- Chromium kiosk mode failed to consistently load the webpage.
- Media playback sometimes failed.
- Audio routing behaved inconsistently.
- Debugging the Wayland compositor environment was difficult.

Additionally, kiosk scripts designed for X11 did not behave reliably under Wayland.

## Solution

The system was migrated back to **X11**, which is currently more stable for kiosk-based signage setups.

Actions taken:

- Removed Wayland-related packages
- Removed `seatd`
- Removed `labwc`
- Disabled Wayland compositor services
- Reconfigured the system to start **X11 using `startx`**

After the migration:

- Chromium kiosk mode worked reliably.
- Video playback worked correctly.
- HDMI audio functioned properly.

---

# 2. Chromium Autoplay Restrictions

## Issue

Chromium blocks media playback without user interaction by default.  
This prevented videos from playing automatically when the kiosk page loaded.

The browser displayed the error:
NotAllowedError: play() failed because the user didn't interact with the document first
### Solution

Chromium was launched with the following flag:

### Solution

Chromium was launched with the following flag:
--autoplay-policy=no-user-gesture-required


This allows videos to play automatically in kiosk mode.

---

## HDMI Audio Output Issue

### Problem

Initially only the following device appeared:

This allows videos to play automatically in kiosk mode.

---

## HDMI Audio Output Issue

### Problem

Initially only the following device appeared:
bcm2835 Headphones


Attempts to use HDMI produced errors such as:
Playback open error: -524


### Investigation

Available audio devices were checked using:
aplay -l


HDMI devices were detected:
vc4hdmi0
vc4hdmi1


However audio still failed to play.

### Solution

After removing Wayland components and running the system with X11, HDMI audio began working normally through Chromium.

---

## Black Screen During Video Playback

### Problem

In kiosk mode, video sometimes produced **audio but no visible video**.

### Possible causes

- hardware acceleration issues
- compositor conflicts
- video decoding problems

### Solution

The issue was resolved after migrating fully to X11 and restarting the system.

Video playback worked normally afterward.

---

## Mouse Cursor Visible in Kiosk Mode

### Problem

The mouse cursor remained visible on the screen, which is undesirable for signage displays.

### Solution

The `unclutter` utility was installed to hide the cursor automatically.

Installation:
sudo apt install unclutter

Usage example:
unclutter -idle 0.5 -root


---

# Current Status

Completed setup:

- Raspberry Pi OS configured
- X11 desktop environment running
- Chromium kiosk mode working
- automatic browser restart implemented
- HDMI audio working
- endpoint successfully loads content
- health monitoring script implemented

Scheduling functionality will be tested once backend scheduling is available.
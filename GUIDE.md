# Git Workflow Guide

## First Time Setup

```bash
git clone <your-repo-url>
cd <repo-folder>
check
````

---

## GO to a Feature Branch

```bash
git checkout main
git pull origin main
git checkout -b scripts/<feature-name>
```

Example:

```bash
git checkout -b scripts/monitoring
```

---

## Work on Your Files

Create or edit scripts inside the project directory.

---

## Save Changes

```bash
git add .
git commit -m "Add watchdog script"
```

---

## Push to Repository

```bash
git push origin scripts/monitoring
```

---

## Create Pull Request

* Go to the repository on GitHub
* Click "Compare & pull request"
* Add a description
* Submit the pull request
* Wait for approval before merging

---

## Update an Existing Pull Request
- No need for another PR just add and commit
```bash
git add .
git commit -m "Fix watchdog issue"
git push
```

---

## After Pull Request is Merged

```bash
git checkout main
git pull origin main
git branch -d scripts/monitoring
```

---

## Rules

* Do not push directly to main
* Always create a new branch for each feature
* One branch should contain one feature only 
* In this case we call them **scripts**

---

## Quick Workflow Summary

```bash
git checkout main
git pull
git checkout -b scripts/name
git add .
git commit -m "message"
git push origin scripts/name
```

---

## Optional Useful Commands

```bash
git status
git diff
```

---

# CONTRIBUTING GUIDE

* All changes must be done in a feature branch
* Branch naming format must be `scripts/<name>`
* Each feature must have its own branch
* All work must go through a pull request
* Do not merge your own pull request without approval
* Keep commits clear and descriptive

---

# Pull Request Template

## Title

Short description of the scripts

## What this does

Explain what the script or change does

## How to test

Steps to verify the scripts works

## Notes

Optional additional details

```
```

# SCRIPT STRUCTURE AND RESPONSIBILITIES

All scripts are organized into the following directories. Each teammate should work within one category.

## scripts/maintenance

- Purpose: System upkeep and housekeeping tasks to keep the Raspberry Pi clean and stable over time.

## Examples of scripts:

- Log cleanup (delete old logs, rotate logs)

- Disk cleanup (remove temp files, cache)

- Auto-update scripts (optional system updates)

- Backup scripts (backup configs or important files)

## Goal:
- Ensure the system does not run out of storage and remains maintainable long-term.

## scripts/monitoring

- Purpose: Collect and report system information for visibility and diagnostics.

## Examples of scripts:

- Health monitoring (CPU, RAM, disk, temperature)

- Network monitoring (connectivity status, bandwidth usage)

- Service status checks (Chromium, Node server, SSH)

- Log generation (daily or hourly reports)

## Goal:
- Provide insight into system performance and detect potential issues early.

## scripts/reliability

- Purpose: Ensure the kiosk system stays running and recovers automatically from failures.

## Examples of scripts:

- Watchdog scripts (restart Chromium if it crashes)

- Auto-restart services if they stop

- Network recovery (reconnect WiFi if disconnected)

- Endpoint checker (reload kiosk if endpoint is down)

## Goal:
- Keep the kiosk running continuously with minimal manual intervention.

# Claude Code Notification

Plays a sound when Claude Code is done and needs your input (only when Claude Code is NOT the focused window).

## Setup

1. Put `notify.ps1` and `settings.json` in your `.claude` folder
2. If you already have a `settings.json` file, merge the contents

## Customization

You can change the sound by changing "chimes.wav" to anything in your `C:\Windows\Media` folder.

## Requirements

- Windows only (uses Win32 API and PowerShell)
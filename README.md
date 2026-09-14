# hyprland-dotfiles

Personal [Hyprland](https://hypr.land) configuration, written in the new Lua
config format. It's a mirror of `~/.config/hypr`, tuned for a single-monitor
setup with an Italian keyboard layout and a set of custom keybinds for
managing windows across virtual workspaces (screens).

## What's in here

- **Italian keyboard layout** (`kb_layout = "it"`)
- **Natural (inverted) mouse scroll**
- **Custom workspace / window keybinds**, described below
- The rest of the stock CachyOS Hyprland config (animations, decorations,
  colors, window rules, monitors, autostart) as a starting point

## Keybinds

`SUPER` is the Windows/Cmd key. "Screen" below means a Hyprland **workspace**
(a virtual desktop), not a physical monitor.

| Keys | Action |
| --- | --- |
| `SUPER + [0-9]` | Switch to workspace N |
| `CTRL + SUPER + [0-9]` | Move the active window to workspace N, **without** switching your view |
| `SHIFT + SUPER + [0-9]` | Move the active window to workspace N **and** follow it (your view switches too) |
| `SHIFT + SUPER + arrow` | Resize the active window towards the pressed direction (hold to keep resizing) |
| `SUPER + D` | Detach the active window from tiling (toggle floating), so it can be moved/resized freely |
| `SUPER + ALT + F` | Maximize the active window (this used to be on `SUPER + D`) |
| `SUPER + ALT + arrow` | Move/swap the active window in the tiling layout in that direction (this used to be on `SHIFT + SUPER + arrow`) |
| `SUPER + ALT + [0-9]` | Alias to focus workspace N (kept for compatibility) |

Everything else (mouse drag/resize, scratchpad, launcher, media keys, monitor
scroll, etc.) is untouched from the stock config — see
[`hypr/config/binds.lua`](hypr/config/binds.lua) for the full list.

> Note: a few stock keybinds were relocated to make room for the ones above
> (`SUPER + D` was "maximize", `SHIFT + SUPER + arrow` was "move window in
> tiling direction"). Both are still available, just on `SUPER + ALT + ...`
> instead.

## Requirements

- [Hyprland](https://hypr.land) built with Lua config support (`hl.*` API)
- `bash` for the installer

## Installation

```bash
git clone https://github.com/djehutyy/hyprland-dotfiles.git ~/hyprland-dotfiles
cd ~/hyprland-dotfiles
./install.sh
```

`install.sh` is interactive: it lists every file under [`hypr/`](hypr), lets
you pick which ones to install (by number, or `all` for everything) instead
of overwriting your whole `~/.config/hypr` blindly, backs up any file it's
about to replace into `~/.config/hypr-backup-<timestamp>`, and optionally
runs `hyprctl reload` at the end if Hyprland is currently running.

This is handy if you only want to grab e.g. the keybinds
(`config/binds.lua`) or the input settings (`config/inputs.lua`) without
touching monitor/wallpaper settings that are specific to another machine.

## Repository structure

Mirrors `~/.config/hypr`:

```
hypr/
├── hyprland.lua              entrypoint, requires everything below
├── xdph.conf                 xdg-desktop-portal-hyprland config
└── config/
    ├── binds.lua              keybinds (workspaces, tiling, resize, ...)
    ├── inputs.lua             keyboard layout, mouse, touchpad, gestures
    ├── monitors.lua           monitor layout
    ├── workspaces.lua         workspace rules
    ├── variables.lua          shared variables (apps, monitor names, ...)
    ├── animations.lua
    ├── colors.lua
    ├── decorations.lua
    ├── misc.lua
    ├── windowrules.lua
    └── autostart.lua
    └── environment.lua
```

## License

Personal config, shared as-is — use whatever's useful, no warranty.

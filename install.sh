#!/usr/bin/env bash
# Interactive installer for this Hyprland config.
# Lets you choose which files to apply into ~/.config/hypr instead of
# overwriting everything blindly (useful on a machine with different
# monitors/wallpapers/etc.).

set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/hypr"
DEST_DIR="$HOME/.config/hypr"
BACKUP_DIR="$HOME/.config/hypr-backup-$(date +%Y%m%d-%H%M%S)"

if [ ! -d "$SRC_DIR" ]; then
    echo "Error: $SRC_DIR not found. Run this script from the repo root." >&2
    exit 1
fi

mapfile -t FILES < <(cd "$SRC_DIR" && find . -type f | sed 's|^\./||' | sort)

echo "Hyprland dotfiles installer"
echo "============================"
echo "Source: $SRC_DIR"
echo "Target: $DEST_DIR"
echo
echo "Available files:"
for i in "${!FILES[@]}"; do
    printf "  %2d) %s\n" "$((i + 1))" "${FILES[$i]}"
done
echo
echo "Enter the numbers of the files to install (space separated),"
echo "type 'all' to install everything, or 'q' to quit."
read -rp "> " selection

if [ "$selection" = "q" ]; then
    echo "Aborted."
    exit 0
fi

selected=()
if [ "$selection" = "all" ]; then
    selected=("${FILES[@]}")
else
    for n in $selection; do
        if ! [[ "$n" =~ ^[0-9]+$ ]] || [ "$n" -lt 1 ] || [ "$n" -gt "${#FILES[@]}" ]; then
            echo "Skipping invalid selection: $n" >&2
            continue
        fi
        selected+=("${FILES[$((n - 1))]}")
    done
fi

if [ "${#selected[@]}" -eq 0 ]; then
    echo "Nothing selected. Aborted."
    exit 0
fi

echo
echo "About to install:"
for f in "${selected[@]}"; do
    echo "  - $f"
done
read -rp "Proceed? [y/N] " confirm
if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 0
fi

mkdir -p "$DEST_DIR"
for f in "${selected[@]}"; do
    dest_file="$DEST_DIR/$f"
    if [ -f "$dest_file" ]; then
        mkdir -p "$BACKUP_DIR/$(dirname "$f")"
        cp "$dest_file" "$BACKUP_DIR/$f"
    fi
    mkdir -p "$(dirname "$dest_file")"
    cp "$SRC_DIR/$f" "$dest_file"
    echo "Installed $f"
done

if [ -d "$BACKUP_DIR" ]; then
    echo
    echo "Existing files backed up to: $BACKUP_DIR"
fi

if command -v hyprctl >/dev/null 2>&1 && [ -n "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]; then
    read -rp "Reload Hyprland now? [y/N] " reload
    if [[ "$reload" =~ ^[Yy]$ ]]; then
        hyprctl reload
        echo "Reloaded."
    fi
else
    echo "Hyprland doesn't seem to be running here; reload manually later with 'hyprctl reload'."
fi

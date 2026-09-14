# hyprland-dotfiles

La mia configurazione Hyprland (layout tastiera IT, keybind per workspace/tiling, resize, ecc.).

## Uso

Su una nuova macchina:

```bash
git clone https://github.com/djehutyy/hyprland-dotfiles.git ~/hyprland-dotfiles
cd ~/hyprland-dotfiles
./install.sh
```

Lo script mostra l'elenco dei file di configurazione e permette di scegliere
quali installare (per numero, `all` per tutti), invece di sovrascrivere tutto
alla cieca. I file esistenti in `~/.config/hypr` vengono salvati in un backup
prima di essere sostituiti.

## Contenuto

Mirror di `~/.config/hypr`:

- `hyprland.lua` — entrypoint
- `xdph.conf` — config xdg-desktop-portal-hyprland
- `config/binds.lua` — keybind (workspace, tiling, resize, ecc.)
- `config/inputs.lua` — tastiera (layout IT), mouse, gesture
- `config/monitors.lua`, `config/workspaces.lua`, `config/variables.lua`
- `config/animations.lua`, `config/colors.lua`, `config/decorations.lua`, `config/misc.lua`, `config/windowrules.lua`, `config/autostart.lua`, `config/environment.lua`

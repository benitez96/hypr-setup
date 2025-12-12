
# Hyprland Setup (Arch Linux)

Setup automatizado y modular para tener un entorno **Hyprland + Wayland** en Arch Linux, orientado a:

- Uso diario de **programación/ofimática**
- **Seguridad** (navegador y ofimática aislados con Flatpak)
- Entorno **minimalista pero moderno** (Catppuccin, Ghostty, Waybar)
- Consola “vitaminizada”: zsh + Starship + herramientas CLI
- Configuración reproducible con un solo comando (`curl | bash`)

---

## Características principales

### Entorno gráfico

- **Compositor / WM**: Hyprland
- **Barra**: Waybar
  - Theme **Catppuccin** (Mocha/Latte)
  - **Switch de tema** oscuro/claro (icono de bombilla)
  - Módulo de WiFi con menú tipo TUI (`networkmanager_dmenu`)
- **Notificaciones**: Mako
- **Lanzador**: Fuzzel (Super+Space)
- **Terminal**: Ghostty (AUR, ligatures)
- **Gestor de archivos**:
  - Thunar (GUI)
  - lf (CLI)
- **Screenshots**:
  - grim + slurp + swappy + wl-clipboard
  - Script `screenshot` con modos `area` y `full`
- **Login manager**: greetd + tuigreet

### Apariencia

- Tema GTK: `adw-gtk3`
- Iconos: `Papirus`
- Cursor: `Bibata`
- Estilo general: **Catppuccin** + look moderno y limpio.

### Seguridad y aislamiento

- **Flatpak** con Flathub:
  - Navegador: **Brave** (`com.brave.Browser`)
  - Ofimática: **LibreOffice** (`org.libreoffice.LibreOffice`)
  - Gestión de permisos: **Flatseal** (`com.github.tchx84.Flatseal`)
  - Tema GTK para apps Flatpak: `org.gtk.Gtk3theme.adw-gtk3`

---

## Consola y herramientas CLI

- **Shell**: zsh (por defecto)
- **Prompt**: Starship con preset Catppuccin (Powerline)
- **Navegación**:
  - `zoxide` (cd inteligente)
- **Productividad**:
  - `fzf` (fuzzy finder)
  - `bat` (cat mejorado)
  - `eza` (ls moderno con iconos)
  - `ripgrep` (`rg`, grep moderno)
- **Sistema**:
  - `fastfetch` (info del sistema tipo neofetch pero moderno)
  - `btop` (monitor de recursos TUI muy completo)
- **Git / Docker**:
  - `lazygit`
  - `lazydocker` (AUR)
- **PDF helpers** (Ghostscript):
  - `pdfcompress-low input.pdf output.pdf`
  - `pdfcompress-medium input.pdf output.pdf`
  - `pdfmerge in1.pdf in2.pdf ... salida.pdf`

---

## Requisitos

- **Arch Linux** ya instalado y booteando.
- Usuario con `sudo` configurado.
- Conexión a internet.

> Nota: el script está pensado para ejecutarse **después** de terminar la instalación base de Arch (particionado, `arch-chroot`, bootloader, locale, etc.).

---

## Instalación rápida

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/benitez96/hypr-setup/main/install.sh)

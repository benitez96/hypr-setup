# Neovim Config

Config de Neovim 0.11+ basada en **snacks.nvim** como pieza central.

## Estructura

```
nvim/
├── init.lua                    # Bootstrap lazy.nvim
└── lua/
    ├── core/
    │   ├── options.lua         # Opciones generales
    │   ├── keymaps.lua         # Keymaps base
    │   └── autocmds.lua        # Autocommands
    └── plugins/
        ├── snacks.lua          # Snacks.nvim (picker, explorer, zen, etc)
        ├── lsp.lua             # LSP + Mason + nvim-cmp (autocompletado)
        ├── treesitter.lua      # Syntax highlighting inteligente
        ├── colorscheme.lua     # Catppuccin Mocha
        ├── git.lua             # Gitsigns + Diffview
        ├── formatting.lua      # Conform.nvim (format on save)
        ├── debugging.lua       # nvim-dap + DAP UI
        └── ui.lua              # Lualine, mini.nvim, oil, which-key, todo
```

## Plugins

| Plugin | Qué hace |
|---|---|
| **snacks.nvim** | Picker, explorer, zen mode, terminal, notifier, scratch, lazygit |
| **nvim-lspconfig** | Integración LSP nativa (vim.lsp.config) |
| **mason.nvim** | Instala LSP servers, formatters, linters |
| **nvim-cmp** | Autocompletado con snippets |
| **nvim-treesitter** | Syntax highlighting, textobjects, autotag |
| **catppuccin/nvim** | Tema de colores (Mocha) |
| **gitsigns.nvim** | Signos de git en el gutter |
| **diffview.nvim** | Diffs visuales |
| **conform.nvim** | Format on save |
| **nvim-dap** | Debugging (breakpoints, step over/into) |
| **oil.nvim** | Explorar archivos como buffer normal |
| **lualine.nvim** | Statusline |
| **mini.nvim** | surround, pairs, comment, indentscope |
| **which-key.nvim** | Muestra keymaps disponibles |
| **todo-comments.nvim** | Resalta TODO, FIXME, HACK, etc |

---

## Keymaps

### Navegación

| Tecla | Acción |
|---|---|
| `<C-h/j/k/l>` | Moverse entre ventanas |
| `<C-Arrows>` | Redimensionar ventanas |
| `j/k` | Se mueven por líneas visuales (gj/gk) |
| `<Esc>` | Limpia highlight de búsqueda |
| `<C-s>` | Guardar |
| `<C-q>` | Cerrar buffer |

### Archivos y Exploradores

| Tecla | Acción |
|---|---|
| `F3` | Abrir Snacks explorer |
| `-` | Abrir Oil.nvim (filesystem como buffer) |
| `<leader>ff` | Buscar archivos |
| `<leader>fg` | Buscar archivos git |
| `<leader>fc` | Buscar archivos de config |
| `<leader>fr` | Archivos recientes |
| `<leader>fp` | Proyectos |
| `<leader><space>` | Smart find files |
| `<leader>e` | File explorer (snacks) |

### Búsqueda

| Tecla | Acción |
|---|---|
| `<leader>/` | Grep en proyecto |
| `<leader>sg` | Grep |
| `<leader>sw` | Grep palabra seleccionada (normal + visual) |
| `<leader>sb` | Buscar líneas en buffer actual |
| `<leader>sB` | Grep en buffers abiertos |
| `<leader>sd` | Diagnósticos del proyecto |
| `<leader>sD` | Diagnósticos del buffer |
| `<leader>sR` | Retomar última búsqueda |

### Git

| Tecla | Acción |
|---|---|
| `<leader>gs` | Git status |
| `<leader>gd` | Git diff (hunks) |
| `<leader>gl` | Git log |
| `<leader>gb` | Git branches |
| `<leader>gS` | Git stash |
| `<leader>gf` | Git log del archivo |
| `<leader>gB` | Abrir archivo en GitHub (normal + visual) |
| `<leader>gg` | Lazygit |
| `<leader>hs` | Stage hunk |
| `<leader>hr` | Reset hunk |
| `<leader>hp` | Preview hunk |
| `<leader>hb` | Blame línea |
| `]c` / `[c` | Siguiente/anterior hunk de git |

### LSP

| Tecla | Acción |
|---|---|
| `gd` | Ir a definición |
| `gD` | Ir a declaración |
| `gr` | Referencias |
| `gI` | Implementaciones |
| `gy` | Ir a definición de tipo |
| `K` | Hover documentation |
| `gK` | Signature help |
| `<leader>cr` | Renombrar símbolo |
| `<leader>ca` | Code action |
| `<leader>cf` | Formatear documento |
| `<leader>ss` | Símbolos del archivo |
| `<leader>sS` | Símbolos del workspace |
| `[d` / `]d` | Diagnóstico anterior/siguiente |
| `<leader>cd` | Ver diagnósticos de la línea |

### Debugging

| Tecla | Acción |
|---|---|
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Breakpoint condicional |
| `<leader>dc` | Continuar / iniciar debug |
| `<leader>di` | Step into |
| `<leader>do` | Step over |
| `<leader>dO` | Step out |
| `<leader>dt` | Terminar debug |
| `<leader>dr` | Toggle REPL |
| `<leader>du` | Toggle DAP UI |

### Surround (mini.surround)

| Tecla | Acción |
|---|---|
| `gsa"` | Rodear con comillas |
| `gsa(` | Rodear con paréntesis |
| `gsa{` | Rodear con llaves |
| `gsd` | Borrar surround |
| `gsr` | Reemplazar surround |
| `gsf` | Buscar surround |
| `gsh` | Highlight surround |

### Zen Mode / Zen

| Tecla | Acción |
|---|---|
| `<leader>z` | Toggle zen mode |
| `<leader>Z` | Toggle zoom |
| `<leader>.` | Scratch buffer |
| `<leader>S` | Seleccionar scratch buffer |

### Terminal

| Tecla | Acción |
|---|---|
| `<C-/>` | Toggle terminal flotante |

### Toggles (`<leader>u`)

| Tecla | Acción |
|---|---|
| `<leader>us` | Spell check |
| `<leader>uw` | Wrap |
| `<leader>uL` | Relative number |
| `<leader>ul` | Line number |
| `<leader>ud` | Diagnostics |
| `<leader>uc` | Conceal level |
| `<leader>uT` | Treesitter highlight |
| `<leader>ub` | Dark background |
| `<leader>uh` | Inlay hints |
| `<leader>ug` | Indent guides |
| `<leader>uD` | Dim |
| `<leader>uC` | Cambiar colorscheme |

### Varios

| Tecla | Acción |
|---|---|
| `<leader>,` | Buffers abiertos |
| `<leader>:` | Historial de comandos |
| `<leader>n` | Historial de notificaciones |
| `<leader>bd` | Cerrar buffer |
| `<leader>cR` | Renombrar archivo |
| `<leader>un` | Cerrar todas las notificaciones |
| `<leader>sk` | Ver todos los keymaps |
| `<leader>si` | Ver íconos disponibles |
| `<leader>su` | Undo history |
| `]]` / `[[` | Siguiente/anterior referencia (palabra bajo cursor) |
| `<leader>y` | Copiar al clipboard del sistema |
| `<leader>p` | Pegar desde clipboard del sistema |

---

## Primeros pasos

### 1. Abrir Neovim

```bash
nvim
```

Lazy.nvim va a instalar todos los plugins automáticamente la primera vez.

### 2. Instalar LSP servers

```vim
:Mason
```

Desde ahí instalá los servers que necesités. Los que vienen pre-configurados:
- `lua_ls`, `ts_ls`, `jsonls`, `yamlls`, `bashls`, `pyright`, `html`, `cssls`, `tailwindcss`, `eslint`

### 3. Instalar parsers de Treesitter

Se instalan solos con `auto_install = true`. Para ver el estado:

```vim
:TSInstallInfo
```

### 4. Instalar formatters

```vim
:MasonToolInstallerInfo
```

Los formatters incluidos: `stylua`, `prettierd`, `shfmt`, `black`, `isort`, `eslint_d`

### 5. Explorar archivos

- `F3` → Snacks explorer (sidebar)
- `-` → Oil.nvim (editás el filesystem como un buffer, guardás con `:w`)

---

## Cómo agregar un nuevo LSP

En `lua/plugins/lsp.lua`, agregalo al objeto `servers`:

```lua
local servers = {
  -- ... existentes ...
  rust_analyzer = {},
  gopls = {},
}
```

Y en `mason-lspconfig.nvim` agregalo a `ensure_installed`:

```lua
ensure_installed = {
  -- ... existentes ...
  "rust_analyzer",
  "gopls",
},
```

## Cómo agregar un nuevo parser de Treesitter

En `lua/plugins/treesitter.lua`, agregalo a `ensure_installed`:

```lua
ensure_installed = {
  -- ... existentes ...
  "rust",
  "go",
},
```

## Cómo agregar un nuevo formatter

En `lua/plugins/formatting.lua`, agregalo a `formatters_by_ft`:

```lua
formatters_by_ft = {
  rust = { "rustfmt" },
  go = { "gofmt" },
},
```

Y en `mason-tool-installer`:

```lua
ensure_installed = {
  -- ... existentes ...
  "rustfmt",
  "gofmt",
},
```

---

## Notas

- **Neovim 0.11+** requerido (usa `vim.lsp.config` nativo)
- El tema es **Catppuccin Mocha**
- Clipboard usa `unnamedplus` (comparte con el sistema)
- Los archivos se formatean automáticamente al guardar (`format_on_save`)
- `which-key` te muestra los keymaps disponibles cuando tocás `<leader>`

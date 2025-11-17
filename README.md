# Neovim Config - 42 School

Config Neovim minimaliste basée sur [LazyVim](https://www.lazyvim.org/) pour l'école 42.

## ✨ Features

- **Theme**: Catppuccin Mocha
- **42 Header**: Header automatique avec `<F1>`
- **Norminette**: Formatter C conforme à la norme 42
- **Font**: Monaspace Argon Nerd Font

## 📦 Plugins Principaux

- [LazyVim](https://github.com/LazyVim/LazyVim) - Distribution Neovim
- [42-header.nvim](https://github.com/Diogo-ss/42-header.nvim) - Headers 42
- [conform.nvim](https://github.com/stevearc/conform.nvim) - Formatter avec c_formatter_42
- [catppuccin](https://github.com/catppuccin/nvim) - Theme

## 🚀 Installation

### Prérequis

```bash
# Neovim >= 0.9.0
brew install neovim

# c_formatter_42 (pour la norminette)
pip3 install --user c-formatter-42

# Assure-toi que le PATH Python user est dans ton shell
# Ajoute à ton ~/.zshrc ou ~/.bashrc si nécessaire:
# export PATH="$HOME/Library/Python/3.x/bin:$PATH"  # macOS
# export PATH="$HOME/.local/bin:$PATH"              # Linux
```

### Installation de la config

```bash
# Backup de l'ancienne config si elle existe
mv ~/.config/nvim ~/.config/nvim.backup

# Clone la config
git clone https://github.com/TON_USERNAME/nvim-config.git ~/.config/nvim

# Lance Neovim (les plugins s'installent automatiquement)
nvim
```

### Setup spécifique Mac 42

Sur les Mac de l'école, tu devras peut-être :

1. Installer Neovim via Homebrew (si pas déjà fait)
2. Installer `c_formatter_42` avec `--user` flag
3. Vérifier que `~/.local/bin` ou `~/Library/Python/3.x/bin` est dans ton PATH
4. Le formatter auto-save est désactivé par défaut (format manuel avec `<leader>cf`)

## ⚙️ Configuration 42

Dans `lua/plugins/42-tools.lua`, modifie ton user et mail :

```lua
opts = {
  user = "TON_LOGIN",
  mail = "TON_LOGIN@student.42lausanne.ch",
},
```

## ⌨️ Keymaps Essentiels

### Général
- `<leader>` = `Space`
- `<F1>` = Insérer header 42
- `<leader>cf` = Format avec norminette

### Navigation
- `<leader>e` = Explorer de fichiers
- `<leader>ff` = Find files
- `<leader>fg` = Live grep

### LSP
- `gd` = Go to definition
- `gr` = Go to references
- `K` = Hover documentation

## 📁 Structure

```
~/.config/nvim/
├── init.lua              # Point d'entrée
├── lua/
│   ├── config/
│   │   ├── autocmds.lua  # Autocommands
│   │   ├── keymaps.lua   # Keymaps custom
│   │   ├── lazy.lua      # Config lazy.nvim
│   │   └── options.lua   # Options Vim
│   └── plugins/
│       └── 42-tools.lua  # Plugins 42 + theme
└── .gitignore
```

## 🎨 Theme

Le theme Catppuccin Mocha fonctionne partout :
- **Arch/HyDE** : Match avec la config Hyprland/Kitty
- **Mac 42** : Fonctionne out-of-the-box avec GNOME

## 📝 Notes

- Le format automatique à la sauvegarde est **désactivé** par défaut (use `<leader>cf` pour formater)
- Les line numbers relatives sont désactivées (preference perso)
- Config testée sur Arch Linux (HyDE) et macOS (GNOME)
- La font Monaspace est optionnelle (fallback sur la font par défaut si absente)

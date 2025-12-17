-- Options are automatically loaded before lazy.nvim startup
-- Default options: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- Line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- Tabs (42 norm = tabs, not spaces)
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = false -- Use tabs, not spaces (42 norm)

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- UI
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- 42 Norm: 80 column indicator (subtle)
vim.opt.colorcolumn = "80"

-- Set subtle colorcolumn color (Catppuccin Surface0)
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#313244" }) -- Catppuccin Mocha Surface0
  end,
})

-- Clipboard (system clipboard)
vim.opt.clipboard = "unnamedplus"

-- GUI font (Monaspace Argon Nerd Font)
vim.opt.guifont = "MonaspiceAr Nerd Font Mono:h12"

-- Auto-save (like VS Code)
vim.opt.updatetime = 500
vim.opt.autowrite = true
vim.opt.autowriteall = true

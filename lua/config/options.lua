-- Options are automatically loaded before lazy.nvim startup
-- Default options: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- Line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- Tabs (default: spaces — C/H override en autocmds.lua)
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

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

-- Timing
vim.opt.updatetime = 500

-- Disable auto-save (LazyVim default) — Pedro saves with <C-s>
vim.opt.autowrite = false
vim.opt.autowriteall = false

-- GUI font (Monaspace Argon Nerd Font)
vim.opt.guifont = "MonaspiceAr Nerd Font Mono:h12"

-- Diagnostic floats avec bordures
vim.diagnostic.config({
	float = { border = "rounded" }
})

-- Rounded borders on all float windows (Neovim 0.11+)
vim.o.winborder = "rounded"

-- Float window colors (Catppuccin Mocha Mauve)
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e1e2e", fg = "#cdd6f4" })
		vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#1e1e2e", fg = "#cba6f7" })
	end,
})

-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Disable relative line numbers
vim.opt.relativenumber = false
vim.opt.number = true

-- Font (GUI Neovim) - Falls back to default if not available
if vim.fn.has("gui_running") == 1 then
  vim.opt.guifont = "Monaspice Ar Nerd Font Mono:h12"
end

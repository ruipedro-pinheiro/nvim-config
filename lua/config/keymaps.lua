-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set

-- ┌────────────────────────────────────────────────────────────────────────┐
-- │                         General Keymaps                                │
-- └────────────────────────────────────────────────────────────────────────┘

-- Better escape
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })
map("i", "jj", "<Esc>", { desc = "Exit insert mode" })

-- Save (with auto-format for C files)
map("n", "<C-s>", function()
	-- Format if it's a C file
	if vim.bo.filetype == "c" then
		require("conform").format({ timeout_ms = 3000, lsp_fallback = true })
	end
	vim.cmd("write")
end, { desc = "Format & Save" })

map("i", "<C-s>", function()
	-- Exit insert mode first
	vim.cmd("stopinsert")
	-- Format if it's a C file
	if vim.bo.filetype == "c" then
		require("conform").format({ timeout_ms = 3000, lsp_fallback = true })
	end
	vim.cmd("write")
end, { desc = "Format & Save" })

-- Quit
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa!<cr>", { desc = "Quit all (force)" })

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- ┌────────────────────────────────────────────────────────────────────────┐
-- │                         Window Navigation                              │
-- └────────────────────────────────────────────────────────────────────────┘

map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize windows
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- ┌────────────────────────────────────────────────────────────────────────┐
-- │                         Buffer Navigation                              │
-- └────────────────────────────────────────────────────────────────────────┘

map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

-- ┌────────────────────────────────────────────────────────────────────────┐
-- │                         Code Actions (42)                              │
-- └────────────────────────────────────────────────────────────────────────┘

-- Format with c_formatter_42
map("n", "<leader>cf", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format (42 norm)" })

-- Lint with norminette
map("n", "<leader>cl", function()
  require("lint").try_lint()
end, { desc = "Lint (norminette)" })

-- ┌────────────────────────────────────────────────────────────────────────┐
-- │                         Better Editing                                 │
-- └────────────────────────────────────────────────────────────────────────┘

-- Move lines up/down
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Stay in indent mode
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Don't yank on paste in visual mode
map("v", "p", '"_dP', { desc = "Paste without yanking" })

-- Keep cursor centered
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up centered" })
map("n", "n", "nzzzv", { desc = "Next search centered" })
map("n", "N", "Nzzzv", { desc = "Previous search centered" })

-- ┌────────────────────────────────────────────────────────────────────────┐
-- │                         Terminal                                       │
-- └────────────────────────────────────────────────────────────────────────┘

map("n", "<leader>tt", "<cmd>terminal<cr>", { desc = "Open terminal" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- ┌────────────────────────────────────────────────────────────────────────┐
-- │                         Quick Actions                                  │
-- └────────────────────────────────────────────────────────────────────────┘

-- Compile C file
map("n", "<F5>", "<cmd>!cc -Wall -Werror -Wextra % -o %:r<cr>", { desc = "Compile C file" })

-- Run compiled file
map("n", "<F6>", "<cmd>!./%:r<cr>", { desc = "Run compiled file" })

-- Make
map("n", "<F7>", "<cmd>!make<cr>", { desc = "Run make" })
map("n", "<F8>", "<cmd>!make re<cr>", { desc = "Run make re" })

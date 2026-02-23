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
		require("conform").format({ timeout_ms = 5000, lsp_fallback = true })
	end
	vim.cmd("write")
end, { desc = "Format & Save" })

map("i", "<C-s>", function()
	-- Exit insert mode first
	vim.cmd("stopinsert")
	-- Format if it's a C file
	if vim.bo.filetype == "c" then
		require("conform").format({ timeout_ms = 5000, lsp_fallback = true })
	end
	vim.cmd("write")
end, { desc = "Format & Save" })

-- Quit
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa!<cr>", { desc = "Quit all (force)" })

-- ┌────────────────────────────────────────────────────────────────────────┐
-- │                         System Clipboard                               │
-- └────────────────────────────────────────────────────────────────────────┘

map({"n", "v"}, "<leader>y", '"+y', { desc = "Yank to clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Yank line to clipboard" })
map({"n", "v"}, "<leader>p", '"+p', { desc = "Paste from clipboard" })
map({"n", "v"}, "<leader>P", '"+P', { desc = "Paste before from clipboard" })

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

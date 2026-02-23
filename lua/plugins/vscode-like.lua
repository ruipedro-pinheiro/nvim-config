-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║                      VS Code-like Experience                             ║
-- ╚══════════════════════════════════════════════════════════════════════════╝

return {
	-- ┌────────────────────────────────────────────────────────────────────────┐
	-- │                  Surround (Change quotes/brackets easily)              │
	-- └────────────────────────────────────────────────────────────────────────┘
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Examples:
				-- cs"' -> change "hello" to 'hello'
				-- ds" -> delete "hello" to hello
				-- ysiw" -> surround word with "
			})
		end,
	},

	-- ┌────────────────────────────────────────────────────────────────────────┐
	-- │                  Flash (Quick navigation like Ctrl+D)                  │
	-- └────────────────────────────────────────────────────────────────────────┘
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			modes = {
				search = {
					enabled = true,
				},
			},
		},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash jump",
			},
			{
				"S",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
		},
	},

	-- ┌────────────────────────────────────────────────────────────────────────┐
	-- │                  Persistence (Session management)                      │
	-- └────────────────────────────────────────────────────────────────────────┘
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {},
		keys = {
			{
				"<leader>qs",
				function()
					require("persistence").load()
				end,
				desc = "Restore Session",
			},
			{
				"<leader>ql",
				function()
					require("persistence").load({ last = true })
				end,
				desc = "Restore Last Session",
			},
		},
	},

	-- ┌────────────────────────────────────────────────────────────────────────┐
	-- │                  Harpoon (Quick file switching)                        │
	-- └────────────────────────────────────────────────────────────────────────┘
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>a", function() require("harpoon"):list():add() end, desc = "Harpoon add file" },
			{ "<C-e>", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Harpoon menu" },
			{ "<C-1>", function() require("harpoon"):list():select(1) end, desc = "Harpoon file 1" },
			{ "<C-2>", function() require("harpoon"):list():select(2) end, desc = "Harpoon file 2" },
			{ "<C-3>", function() require("harpoon"):list():select(3) end, desc = "Harpoon file 3" },
			{ "<C-4>", function() require("harpoon"):list():select(4) end, desc = "Harpoon file 4" },
		},
		config = function()
			require("harpoon"):setup()
		end,
	},

	-- ┌────────────────────────────────────────────────────────────────────────┐
	-- │                  vim-be-good (Practice vim motions)                    │
	-- └────────────────────────────────────────────────────────────────────────┘
	{
		"ThePrimeagen/vim-be-good",
		cmd = "VimBeGood",
	},

	-- ┌────────────────────────────────────────────────────────────────────────┐
	-- │                  Disable noice.nvim (overrides LSP hover borders)      │
	-- └────────────────────────────────────────────────────────────────────────┘
	{ "folke/noice.nvim", enabled = false },
}

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
	-- │                  Better UI (Notifications, Messages)                   │
	-- └────────────────────────────────────────────────────────────────────────┘
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		enabled = false, -- Disable if too invasive
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},
}

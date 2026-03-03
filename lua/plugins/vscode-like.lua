-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║                      VS Code-like Experience                           ║
-- ║  Removed: flash, persistence, harpoon (all LazyVim built-in/extras)   ║
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
        -- cs"' -> change "hello" to 'hello'
        -- ds" -> delete "hello" to hello
        -- ysiw" -> surround word with "
      })
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
  -- │                  Disable noice.nvim (use native LSP floats)            │
  -- └────────────────────────────────────────────────────────────────────────┘
  { "folke/noice.nvim", enabled = false },
}

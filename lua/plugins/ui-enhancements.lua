-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║                          UI Enhancements                               ║
-- ║  Removed: todo-comments, indent-blankline, trouble (LazyVim built-in)  ║
-- ╚══════════════════════════════════════════════════════════════════════════╝

return {
  -- ┌────────────────────────────────────────────────────────────────────────┐
  -- │                    Bracket Pair Colorization                           │
  -- └────────────────────────────────────────────────────────────────────────┘
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    config = function()
      local rainbow_delimiters = require("rainbow-delimiters")
      require("rainbow-delimiters.setup").setup({
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
          vim = rainbow_delimiters.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
          lua = "rainbow-blocks",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      })
    end,
  },

  -- ┌────────────────────────────────────────────────────────────────────────┐
  -- │                         Wakatime Integration                           │
  -- └────────────────────────────────────────────────────────────────────────┘
  {
    "wakatime/vim-wakatime",
    event = "VeryLazy",
  },
}

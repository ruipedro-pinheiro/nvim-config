-- Plugins pour 42
return {
  -- Header 42
  {
    "Diogo-ss/42-header.nvim",
    cmd = { "Stdheader" },
    keys = { "<F1>" },
    opts = {
      default_map = true,
      auto_update = true,
      user = "rpinheir",
      mail = "rpinheir@student.42lausanne.ch",
    },
  },

  -- Formatter norminette
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        c = { "c_formatter_42" },
      },
      formatters = {
        c_formatter_42 = {
          command = "c_formatter_42",
          -- Silently fail if not installed (useful on fresh Mac setup)
          require_cwd = false,
        },
      },
      -- Manual format only (safer on Mac 42)
      -- Uncomment to enable auto-format on save:
      -- format_on_save = {
      --   timeout_ms = 500,
      --   lsp_fallback = true,
      -- },
    },
  },

  -- Catppuccin theme (Mocha)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
    },
  },

  -- Configure LazyVim pour utiliser Catppuccin
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
}

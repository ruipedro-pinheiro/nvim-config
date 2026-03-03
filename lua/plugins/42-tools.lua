-- ╔══════════════════════════════════════════════════════════════════════════╗
-- ║                           42 Development Setup                         ║
-- ║  clangd/mason config comes from extra: lazyvim.plugins.extras.lang.clangd
-- ║  harpoon config comes from extra: lazyvim.plugins.extras.editor.harpoon2
-- ╚══════════════════════════════════════════════════════════════════════════╝

return {
  -- ┌────────────────────────────────────────────────────────────────────────┐
  -- │                         Catppuccin Theme                               │
  -- └────────────────────────────────────────────────────────────────────────┘
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
      background = { light = "latte", dark = "mocha" },
      transparent_background = false,
      term_colors = true,
      no_italic = true,
      no_bold = false,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = true,
        mini = { enabled = true },
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        telescope = { enabled = true },
        which_key = true,
      },
      -- Single source of truth for float colors (no more triple-declaration)
      highlight_overrides = {
        mocha = function(colors)
          return {
            FloatBorder = { fg = colors.mauve },
            NormalFloat = { bg = colors.mantle, fg = colors.text },
            CursorLineNr = { fg = colors.mauve, bold = true },
          }
        end,
      },
    },
  },

  { "LazyVim/LazyVim", opts = { colorscheme = "catppuccin-mocha" } },

  -- ┌────────────────────────────────────────────────────────────────────────┐
  -- │                           42 Header                                    │
  -- └────────────────────────────────────────────────────────────────────────┘
  {
    "Diogo-ss/42-header.nvim",
    cmd = { "Stdheader" },
    keys = { { "<F1>", "<cmd>Stdheader<cr>", desc = "Insert 42 Header" } },
    opts = {
      default_map = true,
      auto_update = true,
      user = "rpinheir",
      mail = "rpinheir@student.42lausanne.ch",
      asciiart = {
        "        :::      ::::::::",
        "      :+:      :+:    :+:",
        "    +:+ +:+         +:+  ",
        "  +#+  +:+       +#+     ",
        "+#+#+#+#+#+   +#+        ",
        "     #+#    #+#          ",
        "    ###   ########.ch    ",
      },
    },
  },

  -- ┌────────────────────────────────────────────────────────────────────────┐
  -- │                        C Formatter (42 Norm)                           │
  -- └────────────────────────────────────────────────────────────────────────┘
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      -- Global defaults: longer timeout for c_formatter_42, LSP fallback
      opts.default_format_opts = vim.tbl_deep_extend("force", opts.default_format_opts or {}, {
        timeout_ms = 3000,
        lsp_format = "fallback",
      })

      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.c = { "c_formatter_42" }
      opts.formatters_by_ft.cpp = { "c_formatter_42" }

      opts.formatters = opts.formatters or {}
      opts.formatters.c_formatter_42 = {
        command = vim.fn.expand("~/.local/bin/c_formatter_42"),
        stdin = true,
      }

      return opts
    end,
  },

  -- ┌────────────────────────────────────────────────────────────────────────┐
  -- │                         Treesitter Languages                           │
  -- └────────────────────────────────────────────────────────────────────────┘
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "c", "cpp", "make", "bash", "lua", "vim", "vimdoc", "markdown" },
    },
  },

  -- ┌────────────────────────────────────────────────────────────────────────┐
  -- │                    Function Line Counter (42 Norm)                     │
  -- └────────────────────────────────────────────────────────────────────────┘
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local function get_function_lines()
        local bufnr = vim.api.nvim_get_current_buf()
        local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
        if not ok or not parser then
          return ""
        end
        local cursor = vim.api.nvim_win_get_cursor(0)
        local row = cursor[1] - 1
        local col = cursor[2]
        local tree = parser:parse()[1]
        if not tree then
          return ""
        end
        local root = tree:root()
        local node = root:named_descendant_for_range(row, col, row, col)
        while node do
          if node:type() == "function_definition" then
            local body = nil
            for child in node:iter_children() do
              if child:type() == "compound_statement" then
                body = child
                break
              end
            end
            if body then
              local start_row = body:start()
              local end_row = body:end_()
              local line_count = end_row - start_row - 1
              if line_count < 0 then
                line_count = 0
              end
              local color = ""
              if line_count >= 25 then
                color = "%#DiagnosticError#"
              elseif line_count >= 20 then
                color = "%#DiagnosticWarn#"
              else
                color = "%#DiagnosticOk#"
              end
              return color .. "Fn:" .. line_count .. "/25" .. "%*"
            end
          end
          node = node:parent()
        end
        return ""
      end

      opts.sections = opts.sections or {}
      opts.sections.lualine_x = opts.sections.lualine_x or {}
      table.insert(opts.sections.lualine_x, 1, {
        get_function_lines,
        cond = function()
          local ft = vim.bo.filetype
          return ft == "c" or ft == "cpp"
        end,
      })
      return opts
    end,
  },
}

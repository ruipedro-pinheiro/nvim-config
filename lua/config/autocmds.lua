-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- LazyVim already provides: highlight_yank, resize_splits, last_loc,
-- close_with_q, checktime, wrap_spell, auto_create_dir, etc.

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- ┌────────────────────────────────────────────────────────────────────────┐
-- │                      Auto-lint C files with norminette                 │
-- └────────────────────────────────────────────────────────────────────────┘
local norminette_ns = vim.api.nvim_create_namespace("norminette")

local function run_norminette()
  local bufnr = vim.api.nvim_get_current_buf()
  local filepath = vim.api.nvim_buf_get_name(bufnr)

  if filepath == "" or (not filepath:match("%.c$") and not filepath:match("%.h$")) then
    return
  end

  vim.diagnostic.reset(norminette_ns, bufnr)

  local job_id = vim.fn.jobstart({ "norminette", "--no-colors", filepath }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if not data then
        return
      end

      local diagnostics = {}
      local ignore_errors = { "WRONG_SCOPE_COMMENT" }

      for _, line in ipairs(data) do
        local code, lnum, col, msg = line:match("Error:%s*(%w+)%s*%(line:%s*(%d+),?%s*col:%s*(%d+)%):%s*(.*)")
        if not lnum then
          code, lnum, msg = line:match("Error:%s*(%w+)%s*%(line:%s*(%d+)%):%s*(.*)")
          col = "1"
        end

        if lnum and code then
          local should_ignore = false
          for _, ignored in ipairs(ignore_errors) do
            if code == ignored then
              should_ignore = true
              break
            end
          end

          if not should_ignore then
            table.insert(diagnostics, {
              bufnr = bufnr,
              lnum = tonumber(lnum) - 1,
              col = math.max(0, tonumber(col) - 1),
              severity = vim.diagnostic.severity.WARN,
              source = "norminette",
              message = code .. (msg and (": " .. msg) or ""),
            })
          end
        end
      end

      vim.diagnostic.set(norminette_ns, bufnr, diagnostics)
    end,
    on_stderr = function(_, data)
      if data and data[1] ~= "" then
        vim.notify("norminette error: " .. table.concat(data, "\n"), vim.log.levels.WARN)
      end
    end,
  })

  -- Timeout: kill norminette if it hangs (10 seconds)
  if job_id > 0 then
    vim.defer_fn(function()
      if vim.fn.jobwait({ job_id }, 0)[1] == -1 then
        vim.fn.jobstop(job_id)
        vim.notify("norminette timed out", vim.log.levels.WARN)
      end
    end, 10000)
  end
end

-- User command for manual trigger (keymap: <leader>cn)
vim.api.nvim_create_user_command("Norminette", run_norminette, {})

augroup("NorminetteLint", { clear = true })
autocmd({ "BufWritePost", "BufReadPost" }, {
  group = "NorminetteLint",
  pattern = { "*.c", "*.h" },
  callback = function()
    if vim.fn.executable("norminette") == 1 then
      run_norminette()
    end
  end,
})

-- ┌────────────────────────────────────────────────────────────────────────┐
-- │                      42 filetype settings (C/H)                        │
-- └────────────────────────────────────────────────────────────────────────┘
augroup("FortyTwoIndent", { clear = true })
autocmd("FileType", {
  group = "FortyTwoIndent",
  pattern = { "c", "cpp" },
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.colorcolumn = "80"
  end,
})

-- ┌────────────────────────────────────────────────────────────────────────┐
-- │                      Remove trailing whitespace                        │
-- └────────────────────────────────────────────────────────────────────────┘
augroup("TrimWhitespace", { clear = true })
autocmd("BufWritePre", {
  group = "TrimWhitespace",
  pattern = { "*.c", "*.h" },
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

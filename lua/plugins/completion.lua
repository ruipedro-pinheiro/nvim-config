return {
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        default = function()
          return { "buffer", "path" }
        end,
        transform_items = function(_, items)
          return vim.tbl_filter(function(item)
            return item.kind ~= require("blink.cmp.types").CompletionItemKind.Snippet
          end, items)
        end,
      },
    },
  },
}

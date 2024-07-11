require("aerial").setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "[[", ":AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "]]", ":AerialNext<CR>", { buffer = bufnr })
  end,
  -- keymaps = {
  --   ["<M-{>"] = "actions.prev",
  --   ["<M-}>"] = "actions.next",
  --   ["<M-[[>"] = "actions.prev_up",
  --   ["<M-]]>"] = "actions.next_up",
  -- },
  layout = {
      default_direction = "prefer_left",
  }
})

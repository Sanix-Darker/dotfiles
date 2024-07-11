require'nvim-treesitter.configs'.setup {
  ensure_installed = {
      "typescript",
      "tsx",
      "prisma",
      "markdown",
      "markdown_inline",
      "svelte",
      "gitignore",
      "c",
      "lua",
      "vim",
      "vimdoc",
      "query",
      "python",
      "toml",
      "sql",
      "vue",
      "yaml",
      "zig",
      "go",
      "cpp",
      "bash",
      "css",
      "arduino",
      "clojure",
      "dockerfile",
      "gomod",
      "gosum",
      "graphql",
      "html",
      "json",
      "javascript",
      "jq",
      "make",
      "php",
      "ruby"
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    disable = function(_, bufnr)
        -- Disable in files with more than 10K
        return vim.api.nvim_buf_line_count(bufnr) > 10000
    end,
  },
  -- enable indentation
  indent = { enable = true },
  autotag = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "vI",
      node_incremental = "vI",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
}

-- setup context nvim
require'treesitter-context'.setup{
  enable = true,
  max_lines = 30,
  min_window_height = 0,
  line_numbers = true,
  multiline_threshold = 20,
  trim_scope = 'outer',
  mode = 'cursor',
  separator = nil,
  zindex = 20,
  on_attach = nil,
}

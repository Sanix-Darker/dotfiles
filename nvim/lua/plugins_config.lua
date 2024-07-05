-- plugins configurations and setups
-- local smart_term_esc_setup = {
--     key='<Esc>',
--     except={'nvim', 'fzf'}
-- }
local neoscroll_setup = {
    -- All these keys will be mapped to their corresponding default scrolling animation
    mappings = {
        '<C-u>', '<C-d>', '<C-b>', '<C-f>',
        '<C-y>', '<C-e>', 'zt', 'zz', 'zb'
    },
    hide_cursor = true,          -- Hide cursor while scrolling
    stop_eof = true,             -- Stop at <EOF> when scrolling downwards
    respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
    easing_function = nil,       -- Default easing function
    pre_hook = nil,              -- Function to run before the scrolling animation starts
    post_hook = nil,             -- Function to run after the scrolling animation ends
    performance_mode = false,    -- Disable "Performance Mode" on all buffers.
}
local scroll_map_setup = {
    ['<S-Up>'] = {'scroll', {'-vim.wo.scroll', 'true', '350', [['sine']]}},
    ['<S-Down>'] = {'scroll', { 'vim.wo.scroll', 'true', '350', [['sine']]}}
}
local mason_setup = {
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
}
local masonlspconfig_setup = {
    ensure_installed = lsp_servers,
    automatic_installation = true,
}
-- Disabling just for now
require('which-key').setup()

-- SourceGraph integration
-- Waiting for the mailing list
-- require("sg").setup()

-- for lsp-lines diagnostics clears
-- so taht if there is multiple elements in the error diag,
-- i ould still see them all
require("lsp_lines").setup()

-- for symbols
require("symbols-outline").setup({
  keymaps = {
    fold = "<C-space>",
    unfold = "<space>",
    fold_all = "W",
    unfold_all = "E",
    fold_reset = "R",
  }
})

-- sideway loading lsp status
require("fidget").setup {}

-- or REST client
-- require("rest-nvim").setup()

-- that use telescope under the hood
-- require("chatgpt").setup()

-- for treesitter
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

-- setup qbf
require('bqf').setup({'--bind', 'ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up'})

-- for areal minimap of code
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

---- for github actions
require('gh-actions').setup()

---- for search and replace on all a directory (text, not necessary a var/func..)
require('spectre').setup()

---- for diag listing
require("trouble").setup{}

---- for aider as pp assistant
---- require('aider').setup({
----   auto_manage_context = false,
----   default_bindings = false
---- })

---- Set lualine as statusline
---- See `:help lualine.txt`
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'tokyonight',
    component_separators = { left = '', right = '|'},
    section_separators = { left = '', right = ''},
    -- for the fancy arrow :
    -- component_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'buffers', 'searchcount'},
    lualine_x = {'fileformat', 'filetype'},
    lualine_y = {'filesize'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

---- hop to jump on any text base objects
require('hop').setup()

---- just so be sure it works
require('snips').setup({
    post_behavior = "yank"
})

require('gitsigns').setup()
--require("scrollbar.handlers.gitsigns").setup()
--require("scrollbar").setup({
--    handle = {
--        text = " ",
--        color = nil,
--        color_nr = 239, -- cterm
--        highlight = "CursorColumn",
--        hide_if_all_visible = true, -- Hides handle if all lines are visible
--    },
--})

---- for the neoscroll
require('neoscroll').setup(neoscroll_setup)
require('neoscroll.config').set_mappings(scroll_map_setup)

---- mason
require("mason").setup(mason_setup)
require("mason-lspconfig").setup(masonlspconfig_setup)

---- require("fzf-lua").setup({})

---- octo nvim to review pull requests inside nvim
require"octo".setup({
  picker = "fzf-lua",                      -- or "telescope"
  suppress_missing_scope = {
    projects_v2 = true,
  },
  mappings = {
    issue = {
      close_issue = { lhs = "<space>ic", desc = "close issue" },
      reopen_issue = { lhs = "<space>io", desc = "reopen issue" },
      list_issues = { lhs = "<space>il", desc = "list open issues on same repo" },
      reload = { lhs = "<C-r>", desc = "reload issue" },
      open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
      copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
      add_assignee = { lhs = "<space>aa", desc = "add assignee" },
      remove_assignee = { lhs = "<space>ad", desc = "remove assignee" },
      create_label = { lhs = "<space>lc", desc = "create label" },
      add_label = { lhs = "<space>la", desc = "add label" },
      remove_label = { lhs = "<space>ld", desc = "remove label" },
      goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
      add_comment = { lhs = "<space>ca", desc = "add comment" },
      delete_comment = { lhs = "<space>cd", desc = "delete comment" },
      next_comment = { lhs = "]c", desc = "go to next comment" },
      prev_comment = { lhs = "[c", desc = "go to previous comment" },
      react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
      react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
      react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
      react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
      react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
      react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
      react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
      react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
    },
    pull_request = {
      checkout_pr = { lhs = "<space>po", desc = "checkout PR" },
      merge_pr = { lhs = "<space>pm", desc = "merge commit PR" },
      squash_and_merge_pr = { lhs = "<space>psm", desc = "squash and merge PR" },
      rebase_and_merge_pr = { lhs = "<space>prm", desc = "rebase and merge PR" },
      list_commits = { lhs = "<space>pc", desc = "list PR commits" },
      list_changed_files = { lhs = "<space>pf", desc = "list PR changed files" },
      show_pr_diff = { lhs = "<space>pd", desc = "show PR diff" },
      add_reviewer = { lhs = "<space>va", desc = "add reviewer" },
      remove_reviewer = { lhs = "<space>vd", desc = "remove reviewer request" },
      close_issue = { lhs = "<space>ic", desc = "close PR" },
      reopen_issue = { lhs = "<space>io", desc = "reopen PR" },
      list_issues = { lhs = "<space>il", desc = "list open issues on same repo" },
      reload = { lhs = "<C-r>", desc = "reload PR" },
      open_in_browser = { lhs = "<C-b>", desc = "open PR in browser" },
      copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
      goto_file = { lhs = "gf", desc = "go to file" },
      add_assignee = { lhs = "<space>aa", desc = "add assignee" },
      remove_assignee = { lhs = "<space>ad", desc = "remove assignee" },
      create_label = { lhs = "<space>lc", desc = "create label" },
      add_label = { lhs = "<space>la", desc = "add label" },
      remove_label = { lhs = "<space>ld", desc = "remove label" },
      goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
      add_comment = { lhs = "<space>ca", desc = "add comment" },
      delete_comment = { lhs = "<space>cd", desc = "delete comment" },
      next_comment = { lhs = "]c", desc = "go to next comment" },
      prev_comment = { lhs = "[c", desc = "go to previous comment" },
      react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
      react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
      react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
      react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
      react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
      react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
      react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
      react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
      review_start = { lhs = "<space>vs", desc = "start a review for the current PR" },
      review_resume = { lhs = "<space>vr", desc = "resume a pending review for the current PR" },
    },
    review_thread = {
      goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
      add_comment = { lhs = "<space>ca", desc = "add comment" },
      add_suggestion = { lhs = "<space>sa", desc = "add suggestion" },
      delete_comment = { lhs = "<space>cd", desc = "delete comment" },
      next_comment = { lhs = "]c", desc = "go to next comment" },
      prev_comment = { lhs = "[c", desc = "go to previous comment" },
      select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
      select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
      select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
      select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
      close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
      react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
      react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
      react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
      react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
      react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
      react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
      react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
      react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
    },
    submit_win = {
      approve_review = { lhs = "<C-a>", desc = "approve review" },
      comment_review = { lhs = "<C-m>", desc = "comment review" },
      request_changes = { lhs = "<C-r>", desc = "request changes review" },
      close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
    },
    review_diff = {
      submit_review = { lhs = "<leader>vs", desc = "submit review" },
      discard_review = { lhs = "<leader>vd", desc = "discard review" },
      add_review_comment = { lhs = "<space>ca", desc = "add a new review comment" },
      add_review_suggestion = { lhs = "<space>sa", desc = "add a new review suggestion" },
      focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
      toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
      next_thread = { lhs = "]t", desc = "move to next thread" },
      prev_thread = { lhs = "[t", desc = "move to previous thread" },
      select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
      select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
      select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
      select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
      close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
      toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
      goto_file = { lhs = "gf", desc = "go to file" },
    },
    file_panel = {
      submit_review = { lhs = "<leader>vs", desc = "submit review" },
      discard_review = { lhs = "<leader>vd", desc = "discard review" },
      next_entry = { lhs = "j", desc = "move to next changed file" },
      prev_entry = { lhs = "k", desc = "move to previous changed file" },
      select_entry = { lhs = "<cr>", desc = "show selected changed file diffs" },
      refresh_files = { lhs = "R", desc = "refresh changed files panel" },
      focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
      toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
      select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
      select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
      select_first_entry = { lhs = "[Q", desc = "move to first changed file" },
      select_last_entry = { lhs = "]Q", desc = "move to last changed file" },
      close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
      toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
    },
  },
})

-- for autoclosing brackets
require('insx.preset.standard').setup()

-- require("nvim-tree").setup(
--     {
--         view = {
--             side = "left",
--         }
--     }
-- )

---- my way for debuguer
require('mydap')

--require("neodev").setup({
--  library = { plugins = { "nvim-dap-ui" }, types = true },
--  ...
--})

-- For PHP stuffs
require('phpnewbie')

-- Include autofold
-- local autof = require('autofold')
-- Automatically fold functions when entering them
vim.api.nvim_exec([[
  augroup LuaFunctionFolding
    autocmd!
    autocmd FileType * lua require'autofold'.unfold_functions()
  augroup END
]], false)

-- for dockdb.nvim plugin
require('mydockdb')

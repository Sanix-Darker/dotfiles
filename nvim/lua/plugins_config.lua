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
    automatic_installation = false,
}
-- be able to use the ESC in the floatTerm terminal
-- require('smart-term-esc').setup(smart_term_esc_setup)
-- Disabling just for now
require('which-key').setup()

-- for treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
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

-- for github actions
require('gh-actions').setup({
  --- The browser executable path to open workflow runs/jobs in
  ---@type string|nil
  browser = nil,
  --- Interval to refresh in seconds
  refresh_interval = 10,
  --- How much workflow runs and jobs should be indented
  indent = 2,
  icons = {
    workflow_dispatch = '⚡️',
    conclusion = {
      success = '✓',
      failure = 'X',
      startup_failure = 'X',
      cancelled = '⊘',
      skipped = '◌',
    },
    status = {
      unknown = '?',
      pending = '○',
      queued = '○',
      requested = '○',
      waiting = '○',
      in_progress = '●',
    },
  },
  highlights = {
    GhActionsRunIconSuccess = { link = 'LspDiagnosticsVirtualTextHint' },
    GhActionsRunIconFailure = { link = 'LspDiagnosticsVirtualTextError' },
    GhActionsRunIconStartup_failure = { link = 'LspDiagnosticsVirtualTextError' },
    GhActionsRunIconPending = { link = 'LspDiagnosticsVirtualTextWarning' },
    GhActionsRunIconRequested = { link = 'LspDiagnosticsVirtualTextWarning' },
    GhActionsRunIconWaiting = { link = 'LspDiagnosticsVirtualTextWarning' },
    GhActionsRunIconIn_progress = { link = 'LspDiagnosticsVirtualTextWarning' },
    GhActionsRunIconCancelled = { link = 'Comment' },
    GhActionsRunIconSkipped = { link = 'Comment' },
    GhActionsRunCancelled = { link = 'Comment' },
    GhActionsRunSkipped = { link = 'Comment' },
    GhActionsJobCancelled = { link = 'Comment' },
    GhActionsJobSkipped = { link = 'Comment' },
    GhActionsStepCancelled = { link = 'Comment' },
    GhActionsStepSkipped = { link = 'Comment' },
  },
  split = {
    relative = 'editor',
    position = 'right',
    size = 60,
    win_options = {
      wrap = false,
      number = false,
      foldlevel = nil,
      foldcolumn = '0',
      cursorcolumn = false,
      signcolumn = 'no',
    },
  },
})


-- for search and replace on all a directory (text, not necessary a var/func..)
require('spectre').setup({
  color_devicons = true,
  open_cmd = 'vnew',
  live_update = false, -- auto execute search again when you write to any file in vim
  line_sep_start = '┌-----------------------------------------',
  result_padding = '¦  ',
  line_sep       = '└-----------------------------------------',
  highlight = {
      ui = "String",
      search = "DiffChange",
      replace = "DiffDelete"
  },
  mapping={
    ['toggle_line'] = {
        map = "dd",
        cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
        desc = "toggle current item"
    },
    ['enter_file'] = {
        map = "<cr>",
        cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
        desc = "goto current file"
    },
    ['send_to_qf'] = {
        map = "<leader>q",
        cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
        desc = "send all item to quickfix"
    },
    ['replace_cmd'] = {
        map = "<leader>c",
        cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
        desc = "input replace vim command"
    },
    ['show_option_menu'] = {
        map = "<leader>o",
        cmd = "<cmd>lua require('spectre').show_options()<CR>",
        desc = "show option"
    },
    ['run_current_replace'] = {
      map = "<leader>rc",
      cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
      desc = "replace current line"
    },
    ['run_replace'] = {
        map = "<leader>R",
        cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
        desc = "replace all"
    },
    ['change_view_mode'] = {
        map = "<leader>v",
        cmd = "<cmd>lua require('spectre').change_view()<CR>",
        desc = "change result view mode"
    },
    ['change_replace_sed'] = {
      map = "trs",
      cmd = "<cmd>lua require('spectre').change_engine_replace('sed')<CR>",
      desc = "use sed to replace"
    },
    ['change_replace_oxi'] = {
      map = "tro",
      cmd = "<cmd>lua require('spectre').change_engine_replace('oxi')<CR>",
      desc = "use oxi to replace"
    },
    ['toggle_live_update']={
      map = "tu",
      cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
      desc = "update change when vim write file."
    },
    ['toggle_ignore_case'] = {
      map = "ti",
      cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
      desc = "toggle ignore case"
    },
    ['toggle_ignore_hidden'] = {
      map = "th",
      cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
      desc = "toggle search hidden"
    },
    ['resume_last_search'] = {
      map = "<leader>l",
      cmd = "<cmd>lua require('spectre').resume_last_search()<CR>",
      desc = "resume last search before close"
    },
    -- you can put your mapping here it only use normal mode
  },
  find_engine = {
    ['ag'] = {
      cmd = "ag",
      args = {
        '--vimgrep',
        '-s',
        '--hidden',
      },
      options = {
        ['ignore-case'] = {
          value= "-i",
          icon="[I]",
          desc="ignore case"
        },
        ['hidden'] = {
          value="--hidden",
          desc="hidden file",
          icon="[H]"
        },
      },
    },
  },
  replace_engine={
      ['sed']={
          cmd = "sed",
          args = nil,
          options = {
            ['ignore-case'] = {
              value= "--ignore-case",
              icon="[I]",
              desc="ignore case"
            },
          }
      },
      -- call rust code by nvim-oxi to replace
      ['oxi'] = {
        cmd = 'oxi',
        args = {},
        options = {
          ['ignore-case'] = {
            value = "i",
            icon = "[I]",
            desc = "ignore case"
          },
        }
      }
  },
  default = {
      find = {
          --pick one of item in find_engine
          cmd = "ag",
          options = {"ignore-case"}
      },
      replace={
          --pick one of item in replace_engine
          cmd = "sed"
      }
  },
  replace_vim_cmd = "cdo",
  is_open_target_win = true, --open file on opener window
  is_insert_mode = false  -- start open panel on is_insert_mode
})

-- for diag listing
require("trouble").setup{}

-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
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

-- require('neoclip').setup({
--   history = 100,
--   enable_persistent_history = false,
--   length_limit = 10000,
--   continuous_sync = false,
--   db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
--   filter = nil,
--   preview = true,
--   prompt = nil,
--   default_register = '"',
--   default_register_macros = 'q',
--   enable_macro_history = true,
--   content_spec_column = false,
--   on_select = {
--     move_to_front = false,
--     close_telescope = true,
--   },
--   on_paste = {
--     set_reg = false,
--     move_to_front = false,
--     close_telescope = true,
--   },
--   on_replay = {
--     set_reg = false,
--     move_to_front = false,
--     close_telescope = true,
--   },
--   on_custom_action = {
--     close_telescope = true,
--   },
--   keys = {
--     fzf = {
--       select = 'default',
--       paste = 'ctrl-p',
--       paste_behind = 'Enter',
--       custom = {},
--     },
--   },
-- })

-- hop to jump on any text base objects
require('hop').setup()

-- just to call the conflitcs lib itself
-- i don't know yet what to do witht this since am not using it more often
-- require('git-conflict').setup()

-- just so be sure it works
require('snips').setup({
    post_behavior = "yank"
})

-- setup for litee
-- require('litee.lib').setup()
-- require('litee.gh').setup()
-- neoscroll (for smooth scrolling)
--
-- for images previewing
-- require("chafa").setup({
--   render = {
--     min_padding = 5,
--     show_label = true,
--   },
--   events = {
--     update_on_nvim_resize = true,
--   },
-- })

-- require('gitsigns').setup()
-- require("scrollbar.handlers.gitsigns").setup()
-- like for the minimap
-- require("scrollbar").setup({
--     show = true,
--     show_in_active_only = false,
--     set_highlights = true,
--     folds = 1000, -- handle folds, set to number to disable folds if no. of lines in buffer exceeds this
--     max_lines = false, -- disables if no. of lines in buffer exceeds this
--     hide_if_all_visible = false, -- Hides everything if all lines are visible
--     throttle_ms = 100,
--     handle = {
--         text = " ",
--         color = nil,
--         color_nr = nil, -- cterm
--         highlight = "CursorColumn",
--         hide_if_all_visible = true, -- Hides handle if all lines are visible
--     },
--     marks = {
--         Cursor = {
--             text = "•",
--             priority = 0,
--             gui=nil,
--             color = nil,
--             cterm=nil,
--             color_nr = nil, -- cterm
--             highlight = "Normal",
--         },
--         Search = {
--             text = { "-" },
--             priority = 1,
--             gui=nil,
--             color = "#E5C07B",
--             cterm=nil,
--             color_nr = nil, -- cterm
--             highlight = "Search",
--         },
--         Error = {
--             text = { "*" },
--             priority = 2,
--             gui=nil,
--             color = "#E06C75",
--             cterm=nil,
--             color_nr = nil, -- cterm
--             highlight = "DiagnosticVirtualTextError",
--         },
--         Warn = {
--             text = { "~" },
--             priority = 3,
--             gui=nil,
--             color = "#BE5046",
--             cterm=nil,
--             color_nr = nil, -- cterm
--             highlight = "DiagnosticVirtualTextWarn",
--         },
--         Info = {
--             text = { "\"" },
--             priority = 4,
--             gui=nil,
--             color = "#282C34",
--             cterm=nil,
--             color_nr = nil, -- cterm
--             highlight = "DiagnosticVirtualTextInfo",
--         },
--         Hint = {
--             text = { "+" },
--             priority = 5,
--             gui=nil,
--             color = nil,
--             cterm=nil,
--             color_nr = nil, -- cterm
--             highlight = "DiagnosticVirtualTextHint",
--         },
--         Misc = {
--             text = { "=" },
--             priority = 6,
--             gui=nil,
--             color = "#3E4452",
--             cterm=nil,
--             color_nr = nil, -- cterm
--             highlight = "Normal",
--         },
--         GitAdd = {
--             text = "┆",
--             priority = 7,
--             gui=nil,
--             color = "#98C379",
--             cterm=nil,
--             color_nr = nil, -- cterm
--             highlight = "GitSignsAdd",
--         },
--         GitChange = {
--             text = "┆",
--             priority = 7,
--             gui=nil,
--             color = "#56B6C2",
--             cterm=nil,
--             color_nr = nil, -- cterm
--             highlight = "GitSignsChange",
--         },
--         GitDelete = {
--             text = "▁",
--             priority = 7,
--             gui=nil,
--             color = "#C678DD",
--             cterm=nil,
--             color_nr = nil, -- cterm
--             highlight = "GitSignsDelete",
--         },
--     },
--     excluded_buftypes = {
--         "terminal",
--     },
--     excluded_filetypes = {
--         "prompt",
--         "TelescopePrompt",
--         "noice",
--     },
--     autocmd = {
--         render = {
--             "BufWinEnter",
--             "TabEnter",
--             "TermEnter",
--             "WinEnter",
--             "CmdwinLeave",
--             "TextChanged",
--             "VimResized",
--             "WinScrolled",
--         },
--         clear = {
--             "BufWinLeave",
--             "TabLeave",
--             "TermLeave",
--             "WinLeave",
--         },
--     },
--     handlers = {
--         cursor = true,
--         diagnostic = true,
--         gitsigns = false, -- Requires gitsigns
--         handle = true,
--         search = false, -- Requires hlslens
--         ale = false, -- Requires ALE
--     },
-- })

-- require('snips.nvim')

-- for the neoscroll
require('neoscroll').setup(neoscroll_setup)
require('neoscroll.config').set_mappings(scroll_map_setup)

-- mason
require("mason").setup(mason_setup)
require("mason-lspconfig").setup(masonlspconfig_setup)

-- octo nvim to review pull requests inside nvim
-- require"octo".setup({
--   default_remote = {"upstream", "origin"}; -- order to try remotes
--   ssh_aliases = {},                        -- SSH aliases. e.g. `ssh_aliases = {["github.com-work"] = "github.com"}`
--   reaction_viewer_hint_icon = "";         -- marker for user reactions
--   user_icon = " ";                        -- user icon
--   timeline_marker = "";                   -- timeline marker
--   timeline_indent = "2";                   -- timeline indentation
--   right_bubble_delimiter = "";            -- bubble delimiter
--   left_bubble_delimiter = "";             -- bubble delimiter
--   github_hostname = "";                    -- GitHub Enterprise host
--   snippet_context_lines = 4;               -- number or lines around commented lines
--   gh_env = {},                             -- extra environment variables to pass on to GitHub CLI, can be a table or function returning a table
--   issues = {
--     order_by = {                           -- criteria to sort results of `Octo issue list`
--       field = "CREATED_AT",                -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
--       direction = "DESC"                   -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
--     }
--   },
--   pull_requests = {
--     order_by = {                           -- criteria to sort the results of `Octo pr list`
--       field = "CREATED_AT",                -- either COMMENTS, CREATED_AT or UPDATED_AT (https://docs.github.com/en/graphql/reference/enums#issueorderfield)
--       direction = "DESC"                   -- either DESC or ASC (https://docs.github.com/en/graphql/reference/enums#orderdirection)
--     },
--     always_select_remote_on_create = "false" -- always give prompt to select base remote repo when creating PRs
--   },
--   file_panel = {
--     size = 10,                             -- changed files panel rows
--     use_icons = true                       -- use web-devicons in file panel (if false, nvim-web-devicons does not need to be installed)
--   },
--   mappings = {
--     issue = {
--       close_issue = { lhs = "<space>ic", desc = "close issue" },
--       reopen_issue = { lhs = "<space>io", desc = "reopen issue" },
--       list_issues = { lhs = "<space>il", desc = "list open issues on same repo" },
--       reload = { lhs = "<C-r>", desc = "reload issue" },
--       open_in_browser = { lhs = "<C-b>", desc = "open issue in browser" },
--       copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
--       add_assignee = { lhs = "<space>aa", desc = "add assignee" },
--       remove_assignee = { lhs = "<space>ad", desc = "remove assignee" },
--       create_label = { lhs = "<space>lc", desc = "create label" },
--       add_label = { lhs = "<space>la", desc = "add label" },
--       remove_label = { lhs = "<space>ld", desc = "remove label" },
--       goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
--       add_comment = { lhs = "<space>ca", desc = "add comment" },
--       delete_comment = { lhs = "<space>cd", desc = "delete comment" },
--       next_comment = { lhs = "]c", desc = "go to next comment" },
--       prev_comment = { lhs = "[c", desc = "go to previous comment" },
--       react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
--       react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
--       react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
--       react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
--       react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
--       react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
--       react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
--       react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
--     },
--     pull_request = {
--       checkout_pr = { lhs = "<space>po", desc = "checkout PR" },
--       merge_pr = { lhs = "<space>pm", desc = "merge commit PR" },
--       squash_and_merge_pr = { lhs = "<space>psm", desc = "squash and merge PR" },
--       list_commits = { lhs = "<space>pc", desc = "list PR commits" },
--       list_changed_files = { lhs = "<space>pf", desc = "list PR changed files" },
--       show_pr_diff = { lhs = "<space>pd", desc = "show PR diff" },
--       add_reviewer = { lhs = "<space>va", desc = "add reviewer" },
--       remove_reviewer = { lhs = "<space>vd", desc = "remove reviewer request" },
--       close_issue = { lhs = "<space>ic", desc = "close PR" },
--       reopen_issue = { lhs = "<space>io", desc = "reopen PR" },
--       list_issues = { lhs = "<space>il", desc = "list open issues on same repo" },
--       reload = { lhs = "<C-r>", desc = "reload PR" },
--       open_in_browser = { lhs = "<C-b>", desc = "open PR in browser" },
--       copy_url = { lhs = "<C-y>", desc = "copy url to system clipboard" },
--       goto_file = { lhs = "gf", desc = "go to file" },
--       add_assignee = { lhs = "<space>aa", desc = "add assignee" },
--       remove_assignee = { lhs = "<space>ad", desc = "remove assignee" },
--       create_label = { lhs = "<space>lc", desc = "create label" },
--       add_label = { lhs = "<space>la", desc = "add label" },
--       remove_label = { lhs = "<space>ld", desc = "remove label" },
--       goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
--       add_comment = { lhs = "<space>ca", desc = "add comment" },
--       delete_comment = { lhs = "<space>cd", desc = "delete comment" },
--       next_comment = { lhs = "]c", desc = "go to next comment" },
--       prev_comment = { lhs = "[c", desc = "go to previous comment" },
--       react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
--       react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
--       react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
--       react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
--       react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
--       react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
--       react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
--       react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
--     },
--     review_thread = {
--       goto_issue = { lhs = "<space>gi", desc = "navigate to a local repo issue" },
--       add_comment = { lhs = "<space>ca", desc = "add comment" },
--       add_suggestion = { lhs = "<space>sa", desc = "add suggestion" },
--       delete_comment = { lhs = "<space>cd", desc = "delete comment" },
--       next_comment = { lhs = "]c", desc = "go to next comment" },
--       prev_comment = { lhs = "[c", desc = "go to previous comment" },
--       select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
--       select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
--       close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
--       react_hooray = { lhs = "<space>rp", desc = "add/remove 🎉 reaction" },
--       react_heart = { lhs = "<space>rh", desc = "add/remove ❤️ reaction" },
--       react_eyes = { lhs = "<space>re", desc = "add/remove 👀 reaction" },
--       react_thumbs_up = { lhs = "<space>r+", desc = "add/remove 👍 reaction" },
--       react_thumbs_down = { lhs = "<space>r-", desc = "add/remove 👎 reaction" },
--       react_rocket = { lhs = "<space>rr", desc = "add/remove 🚀 reaction" },
--       react_laugh = { lhs = "<space>rl", desc = "add/remove 😄 reaction" },
--       react_confused = { lhs = "<space>rc", desc = "add/remove 😕 reaction" },
--     },
--     submit_win = {
--       approve_review = { lhs = "<C-a>", desc = "approve review" },
--       comment_review = { lhs = "<C-m>", desc = "comment review" },
--       request_changes = { lhs = "<C-r>", desc = "request changes review" },
--       close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
--     },
--     review_diff = {
--       add_review_comment = { lhs = "<space>ca", desc = "add a new review comment" },
--       add_review_suggestion = { lhs = "<space>sa", desc = "add a new review suggestion" },
--       focus_files = { lhs = "<leader>ee", desc = "move focus to changed file panel" },
--       toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
--       next_thread = { lhs = "]t", desc = "move to next thread" },
--       prev_thread = { lhs = "[t", desc = "move to previous thread" },
--       select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
--       select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
--       close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
--       toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
--     },
--     file_panel = {
--       next_entry = { lhs = "j", desc = "move to next changed file" },
--       prev_entry = { lhs = "k", desc = "move to previous changed file" },
--       select_entry = { lhs = "<cr>", desc = "show selected changed file diffs" },
--       refresh_files = { lhs = "R", desc = "refresh changed files panel" },
--       focus_files = { lhs = "<leader>e", desc = "move focus to changed file panel" },
--       toggle_files = { lhs = "<leader>b", desc = "hide/show changed files panel" },
--       select_next_entry = { lhs = "]q", desc = "move to previous changed file" },
--       select_prev_entry = { lhs = "[q", desc = "move to next changed file" },
--       close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
--       toggle_viewed = { lhs = "<leader><space>", desc = "toggle viewer viewed state" },
--     }
--   }
-- })

-- for autoclosing brackets
require('insx.preset.standard').setup()

-- for dap configurations
-- require('dap-go').setup()
-- require('dap-python').setup()
--local dap = require('dap')
--local dapui = require("dapui")

--dapui.setup(
--  {
--    controls = {
--      element = "repl",
--      enabled = true,
--      icons = {
--        disconnect = "",
--        pause = "",
--        play = "",
--        run_last = "",
--        step_back = "",
--        step_into = "",
--        step_out = "",
--        step_over = "",
--        terminate = ""
--      }
--    },
--    element_mappings = {},
--    expand_lines = true,
--    floating = {
--      border = "single",
--      mappings = {
--        close = { "q", "<Esc>" }
--      }
--    },
--    force_buffers = true,
--    icons = {
--      collapsed = "",
--      current_frame = "",
--      expanded = ""
--    },
--    layouts = { {
--        elements = { {
--            id = "scopes",
--            size = 0.40
--          }, {
--            id = "breakpoints",
--            size = 0.25
--          }, {
--            id = "stacks",
--            size = 0.25
--          },{
--            id = "console",
--            size = 0.10
--          }
--          -- {
--          --   id = "watches",
--          --   size = 0.25
--          -- }
--      },
--        position = "left",
--        size = 50
--      }, {
--        elements = { {
--            id = "repl",
--            size = 1
--          } },
--        position = "bottom",
--        size = 15
--      } },
--    mappings = {
--      edit = "e",
--      expand = { "<CR>", "<2-LeftMouse>" },
--      open = "o",
--      remove = "d",
--      repl = "r",
--      toggle = "t"
--    },
--    render = {
--      indent = 1,
--      max_value_lines = 200
--    }
--  }
--)
--dap.adapters.python = function(cb, config)
--  if config.request == 'attach' then
--    ---@diagnostic disable-next-line: undefined-field
--    local port = (config.connect or config).port
--    ---@diagnostic disable-next-line: undefined-field
--    local host = (config.connect or config).host or '127.0.0.1'
--    cb({
--      type = 'server',
--      port = assert(port, '`connect.port` is required for a python `attach` configuration'),
--      host = host,
--      options = {
--        source_filetype = 'python',
--      },
--    })
--  else
--    cb({
--      type = 'executable',
--      command = 'env/bin/python',
--      args = { '-m', 'debugpy.adapter' },
--      options = {
--        source_filetype = 'python',
--      },
--    })
--  end
--end

--dap.configurations.python = {
--  {
--    -- The first three options are required by nvim-dap
--    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
--    request = 'launch';
--    name = "Launch file";
--    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options
--    program = "${file}"; -- This configuration will launch the current file if used.
--    pythonPath = function()
--      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
--      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
--      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
--      local cwd = vim.fn.getcwd()
--      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
--        return cwd .. '/env/bin/python'
--      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
--        return cwd .. '/.venv/bin/python'
--      else
--        return '/usr/bin/python3'
--      end
--    end;
--  },
--}

--dap.listeners.after.event_initialized["dapui_config"]=function()
--  dapui.open()
--end
--dap.listeners.before.event_terminated["dapui_config"]=function()
--  dapui.close()
--end
--dap.listeners.before.event_exited["dapui_config"]=function()
--  dapui.close()
--end

--vim.fn.sign_define('DapBreakpoint',{ text ='🟥', texthl ='', linehl ='', numhl =''})
--vim.fn.sign_define('DapStopped',{ text ='▶️', texthl ='', linehl ='', numhl =''})

--require("neodev").setup({
--  library = { plugins = { "nvim-dap-ui" }, types = true },
--  ...
--})
---- for dap virtual text
--require("nvim-dap-virtual-text").setup()

---- for highlights
--require('nvim-dap-repl-highlights').setup()

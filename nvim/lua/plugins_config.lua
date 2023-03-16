-- plugins configurations and setups
local smart_term_esc_setup = {
    key='<Esc>',
    except={'nvim', 'fzf'}
}
local neoscroll_setup = {
    -- All these keys will be mapped to their corresponding default scrolling animation
    mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
    '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
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
require('smart-term-esc').setup(smart_term_esc_setup)
-- Disabling just for now
require('which-key').setup()
-- hop to jump on any text base objects
-- require('hop').setup()
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

vim.cmd('source ~/.config/nvim/config.vim')

-- Uncomment this when debuging
-- require('dap-python').setup('*env*/bin/python')
-- require('dap-go').setup()
-- require("nvim-dap-virtual-text").setup { commented = true }
-- vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
-- vim.fn.sign_define('DapStopped', {text='🟢', texthl='', linehl='', numhl=''})
-- vim.fn.sign_define("DapBreakpointRejected", {text='❌', texthl='', linehl='', numhl=''})

_G.__luacache_config = {
    chunks = {
        enable = true,
        path = vim.fn.stdpath('cache')..'/luacache_chunks',
    },
    modpaths = {
        enable = true,
        path = vim.fn.stdpath('cache')..'/luacache_modpaths',
    }
}

-- Disabling just for now
-- require('which-key').setup()
require('hop').setup()
require('smart-term-esc').setup{
    key='<Esc>',
    except={'nvim', 'fzf'}
}

-- neoscroll
require('neoscroll').setup({
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
})

local t = {}
t['<S-Up>'] = {'scroll', {'-vim.wo.scroll', 'true', '350', [['sine']]}}
t['<S-Down>'] = {'scroll', { 'vim.wo.scroll', 'true', '350', [['sine']]}}
require('neoscroll.config').set_mappings(t)
-- neoscroll

-- for git conflicts resolutions
-- require('git-conflict').setup({
--   default_mappings = true, -- disable buffer local mapping created by this plugin
--   disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
--   highlights = { -- They must have background color, otherwise the default color will be used
--     incoming = 'DiffText',
--     current = 'DiffAdd',
--   }
-- })
-- for git conflicts resolutions


-- for snapshot from the source code
require('silicon').setup({
  font = 'Hack=20',
  theme = 'Dracula',
  shadow = {
    blur_radius = 5.3,
    offset_x = 7,
    offset_y = 7,
    color = '#555'
  },
  line_number = true,
  line_pad = 2,
  line_offset = 1,
  round_corner = true,
  window_controls = true,
})
-- >>>>>>>>>>>>>>>>>

-- impatient
-- a plugin to speed up the loading of nvim
require('impatient')
-- impatient
 -- set up an appropriate complation like lsp-nvim

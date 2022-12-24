vim.cmd('source ~/.config/nvim/config.vim')

-- [[ : sections backward or to the previous '{' in the first column.
-- ]] : sections forward or to the next '{' in the first column.
-- [] : sections backward or to the previous '}' in the first column.
-- ][ : sections forward or to the next '}' in the first column.

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
-- impatient
-- a plugin to speed up the loading of nvim
require('impatient')
-- >>>>>>>>>>>>>>>>>
-- Disabling just for now
require('which-key').setup()
-- hop to jump on any text base objects
require('hop').setup()
-- ti be able to use the ESC in the floatTerm terminal
require('smart-term-esc').setup{
    key='<Esc>',
    except={'nvim', 'fzf'}
}
-- neoscroll (for smooth scrolling)
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

local scroll_map = {}
scroll_map['<S-Up>'] = {'scroll', {'-vim.wo.scroll', 'true', '350', [['sine']]}}
scroll_map['<S-Down>'] = {'scroll', { 'vim.wo.scroll', 'true', '350', [['sine']]}}
require('neoscroll.config').set_mappings(scroll_map)
-- >>>>>>>>>>>>>>>

-- for git conflicts resolutions
-- require('git-conflict').setup({
--     default_mappings = true, -- disable buffer local mapping created by this plugin
--     disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
--     highlights = { -- They must have background color, otherwise the default color will be used
--         incoming = 'DiffText',
--         current = 'DiffAdd',
--     }
-- })
-- for git conflicts resolutions
-- just like hop to search and jump really quickly
-- require('leap').add_default_mappings()
-- >>>>>>>>>>>>>>>>>>>>>
-- for image preview inside the neovim editor
-- require('hologram').setup{
--     auto_display = true
-- }
-- >>>>>>>>>>>>>>>>>>>

-- mason utile for lsp
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
require("mason-lspconfig").setup({
    -- ensure_installed = lsp_servers,
    automatic_installation = false,
})

require('s_lspconfig')

vim.cmd('source ~/.config/nvim/config.vim')
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

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
require('impatient')
-- all set configurations
require('set_config')
-- to import plugins configurations
require('plugins_config')
-- lsp configurations
require('s_lspconfig')

vim.cmd('source ~/.config/nvim/config.vim')

require('dap-python').setup('*env*/bin/python')
require('dap-go').setup()

vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='🟢', texthl='', linehl='', numhl=''})

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

require('which-key').setup()
require('hop').setup()
require('smart-term-esc').setup{
    key='<Esc>',
    except={'nvim', 'fzf'}
}
require('impatient')

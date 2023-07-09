vim.cmd('source ~/.config/nvim/config.vim')

-- vim.api.nvim_create_autocmd('UIEnter', {
--   callback = function()
--     if vim.bo.filetype ~= '' then -- Check if the buffer has a filetype
--       return
--     end
--     if vim.api.nvim_buf_get_lines(0, 0, -1, false)[1] == '' then
--         vim.api.nvim_buf_delete(0, {force = true})
--     end
--   end,
-- })

-- [[ : sections backward or to the previous '{' in the first column.
-- ]] : sections forward or to the next '{' in the first column.
-- [] : sections backward or to the previous '}' in the first column.
-- ][ : sections forward or to the next '}' in the first column.

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

-- to speed up the start
require('impatient')
-- all set configurations
require('set_config')
-- to import plugins configurations
require('plugins_config')
-- for my keymaps
require('keymaps')
-- lsp configurations
require('lsp_config')

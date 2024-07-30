-- Disabling just for now
-- require('which-key').setup()

-- for lsp-lines diagnostics clears
-- so taht if there is multiple elements in the error diag,
-- i Would still see them all
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

-- Sideway loading lsp status
require("fidget").setup({})

-- or REST client
-- require("rest-nvim").setup()

-- for treesitter
-- require('mytreesitter')

-- setup qbf
require('bqf').setup({'--bind', 'ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up'})

-- for areal minimap of code
require('myaerial')

---- for github actions
require('gh-actions').setup()

---- for search and replace on all a directory (text, not necessary a var/func..)
-- require('spectre').setup()

---- for diag listing
require("trouble").setup{}

---- for aider as pp assistant
---- require('aider').setup({
----   auto_manage_context = false,
----   default_bindings = false
---- })

---- Set lualine as statusline
---- See `:help lualine.txt`
require('mylualine')

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
require('myneoscroll')

-- for auto doc (php-doc/js-doc/...)
require('neogen').setup({})

---- mason
require('mymason')
---- require("fzf-lua").setup({})

---- octo nvim to review pull requests inside nvim
-- require('myocto')

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
-- require('mydap')

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

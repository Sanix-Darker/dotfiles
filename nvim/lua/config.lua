-- config.vim converted in lua
-- Set runtimepath and packpath
vim.opt.runtimepath:prepend("~/.config/nvim/")
vim.opt.runtimepath:append("~/.config/nvim/after")
vim.opt.packpath = vim.opt.runtimepath:get()

vim.api.nvim_set_keymap('i', 'jk', '<ESC>', { noremap = true, silent = true })

-- Colorscheme
local ok, _ = pcall(vim.cmd, 'colorscheme tokyonight')
if not ok then
    vim.cmd('echomsg "Error: Loading theme!"')
end

-- General
vim.api.nvim_create_user_command('W', 'w !sudo tee % > /dev/null | edit!', {})

-- For command line to run alias in command mode inside vim editor
vim.env.BASH_ENV = "~/.vim_bash_env"

-- NERDTREE stuff
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeWinPos = "right"

-- function NERDTreeToggleAndRefresh()
--     if vim.g.NERDTree.IsOpen() then
--         vim.cmd('NERDTreeClose')
--     else
--         vim.cmd('NERDTreeFind')
--     end
-- end
vim.api.nvim_set_keymap('n', '<C-n>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })

-- Silicon settings
vim.g.silicon = {
    theme = 'Dracula',
    font = 'Hack',
    background = '#FFFFFF',
    ['shadow-color'] = '#555555',
    ['line-pad'] = 2,
    ['pad-horiz'] = 80,
    ['pad-vert'] = 100,
    ['shadow-blur-radius'] = 0,
    ['shadow-offset-x'] = 0,
    ['shadow-offset-y'] = 0,
    ['line-number'] = true,
    ['round-corner'] = true,
    ['window-controls'] = true,
}

vim.g.lasttab = 1
vim.api.nvim_create_autocmd('TabLeave', {
    pattern = '*',
    command = 'let g:lasttab = tabpagenr()'
})

-- Clean and erase the buffer
vim.api.nvim_set_keymap('n', 'cbu', ':%bd|e#|bd#<CR>', { noremap = true, silent = true })

-- Search in current files
vim.env.FZF_DEFAULT_COMMAND = 'ag --hidden --ignore bower_components --ignore __pycache__ --ignore env --ignore venv --ignore .git --ignore .cmd_history --ignore .cargo --ignore node_modules --ignore poetry.lock --ignore package-lock.json --ignore yarn.lock -g ""'
vim.env.FZF_DEFAULT_OPTS = '--bind "ctrl-d:preview-down,ctrl-u:preview-up"'
vim.env.BAT_THEME = 'base16-256'
vim.env.COLORTERM = 'truecolor'

-- Return to last edit position when opening files
-- Return to last edit position when opening files
vim.api.nvim_create_autocmd('BufReadPost', {
    pattern = '*',
    callback = function()
        local line = vim.fn.line
        if line("'\"") > 1 and line("'\"") <= line("$") then
            vim.cmd("normal! g'\"")
        end
    end
})

-- Delete trailing white space on save
function CleanExtraSpaces()
    local save_cursor = vim.fn.getpos(".")
    local old_query = vim.fn.getreg('/')
    vim.cmd('%s/\\s\\+$//e')
    vim.fn.setpos('.', save_cursor)
    vim.fn.setreg('/', old_query)
end
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*',
    callback = CleanExtraSpaces
})

-- Helper function for visual selection
function VisualSelection(direction, extra_filter)
    local saved_reg = vim.fn.getreg('"')
    vim.cmd('normal! vgvy')
    local pattern = vim.fn.escape(vim.fn.getreg('"'), "\\/.*'$^~[]")
    pattern = string.gsub(pattern, "\n$", "")
    if direction == 'gv' then
        CmdLine("Ack '" .. pattern .. "' ")
    elseif direction == 'replace' then
        CmdLine("%s" .. '/' .. pattern .. '/')
    end
    vim.fn.setreg('/', pattern)
    vim.fn.setreg('"', saved_reg)
end

-- Helper functions
vim.api.nvim_create_autocmd({'FocusGained', 'BufEnter'}, {
    pattern = '*',
    command = 'checktime'
})

-- Don't close window when deleting a buffer
vim.api.nvim_create_user_command('Bclose', function()
    local current_buf = vim.fn.bufnr('%')
    local alternate_buf = vim.fn.bufnr('#')
    if vim.fn.buflisted(alternate_buf) == 1 then
        vim.cmd('buffer #')
    else
        vim.cmd('bnext')
    end
    if vim.fn.bufnr('%') == current_buf then
        vim.cmd('new')
    end
    if vim.fn.buflisted(current_buf) == 1 then
        vim.cmd('bdelete! ' .. current_buf)
    end
end, {})

function CmdLine(str)
    vim.fn.feedkeys(":" .. str)
end

-- Set elements depending on filetype
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'yaml', 'yml'},
    command = 'set cursorcolumn'
})

-- PEP8 indentation for Python files
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    pattern = '*.py',
    command = 'set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix'
})

-- Activate rest plugin for rest files
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    pattern = '*.rest',
    command = 'set ft=rest'
})

-- Folding settings
vim.opt.foldmethod = 'manual'
vim.opt.foldnestmax = 1
vim.opt.termguicolors = true

-- Flagging Unnecessary Whitespace
vim.cmd('highlight BadWhitespace ctermbg=red guibg=darkred')
vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
    pattern = {'*.py', '*.pyw', '*.c', '*.h'},
    command = 'match BadWhitespace /\\s\\+$/'
})

-- Refresh i3 config after edit
vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = '~/.config/i3/config',
    command = ':silent !i3-msg restart; notify-send "Reloaded i3 :)"'
})

-- Format C code with ClangFormat
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'c',
    command = 'ClangFormatAutoEnable'
})
-- vim.g.clang_format.style_options = {
--     AccessModifierOffset = -4,
--     AllowShortIfStatementsOnASingleLine = true,
--     AlwaysBreakTemplateDeclarations = true,
--     Standard = 'C++11',
-- }

-- Map to <Leader>cf in C++ code
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'c', 'cpp', 'objc'},
    command = 'nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>'
})
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'c', 'cpp', 'objc'},
    command = 'vnoremap <buffer><Leader>cf :ClangFormat<CR>'
})
vim.api.nvim_create_autocmd('FileType', {
    pattern = {'c', 'cpp', 'objc'},
    command = 'map <buffer><Leader>x <Plug>(operator-clang-format)'
})

-- Transparent background adaptation
function AdaptColorscheme()
    vim.cmd('highlight clear CursorLine')
    vim.cmd('highlight Normal ctermbg=none')
    vim.cmd('highlight LineNr ctermbg=none')
    vim.cmd('highlight Folded ctermbg=none')
    vim.cmd('highlight NonText ctermbg=none')
    vim.cmd('highlight SpecialKey ctermbg=none')
    vim.cmd('highlight VertSplit ctermbg=none')
    vim.cmd('highlight SignColumn ctermbg=none')
end
vim.api.nvim_create_autocmd('ColorScheme', {
    pattern = '*',
    callback = AdaptColorscheme
})

vim.cmd('highlight Normal guibg=NONE ctermbg=NONE')
vim.cmd('highlight CursorColumn cterm=NONE ctermbg=NONE ctermfg=NONE')
vim.cmd('highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE')
vim.cmd('highlight CursorLineNr cterm=NONE ctermbg=NONE ctermfg=NONE')
vim.cmd('highlight clear LineNr')
vim.cmd('highlight clear SignColumn')
vim.cmd('highlight clear StatusLine')

vim.api.nvim_create_autocmd({'InsertLeave', 'VimEnter', 'BufEnter'}, {
    pattern = '*',
    command = 'set cursorline'
})
vim.api.nvim_create_autocmd({'InsertLeave', 'VimEnter', 'BufEnter'}, {
    pattern = '*',
    command = 'set nocursorcolumn'
})
vim.cmd('highlight CursorLine ctermbg=236 ctermfg=None')

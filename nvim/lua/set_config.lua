-- Enable filetype plugins
vim.api.nvim_command('filetype plugin indent on')
-- Enable syntax highlighting
vim.api.nvim_command('syntax enable on')

-- set
local set = vim.opt
set.completeopt = {'menu', 'menuone', 'noselect'}
-- Set to auto read when a file is changed from the outside
set.autoread = true
-- Turn on the Wild menu
set.wildmenu = true
-- A buffer becomes hidden when it is abandoned
set.hidden = true
set.hid = true
-- Always show current position
set.ruler = true
-- Ignore case when searching
set.ignorecase = true
-- When searching try to be smart about cases
set.smartcase = true
-- No Highlight search results
set.hlsearch = true
-- Don't redraw while executing macros (good performance config)
set.lazyredraw = true
-- For regular expressions turn magic on
set.magic = true
-- Show matching brackets when text indicator is over them
set.showmatch = true
-- Use spaces instead of tabs
set.expandtab = true
-- Be smart when using tabs ;)
set.smarttab = true
set.lbr = true
set.ai = true -- Auto indent
set.si = true -- Smart indent
set.wrap = true -- Wrap lines
-- Fort the splitTerm plugin
set.splitbelow = true
-- to set the number
set.number = true
set.relativenumber = true
-- Enable persistent undo so that undo history
-- persists across vim sessions
set.undofile = true
set.history = 300
set.colorcolumn = '1000'
-- Set 7 lines to the cursor - when moving vertically using j/k
set.so = 7
-- Avoid garbled characters in Chinese language windows OS
-- let en_US.UTF-8='en'
set.langmenu = 'en'
-- Ignore compiled files
set.wildignore = '*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store'
-- Height of the command bar
set.cmdheight = 1
-- Configure backspace so it acts as it should act
set.backspace = 'eol,start,indent'
set.whichwrap = '<,>,h,l'
-- How many tenths of a second to blink when matching brackets
set.mat = 2
set.tm = 500
-- Add a bit extra margin to the left
set.foldcolumn = '1'
-- Set utf8 as standard encoding and en_US as the standard language
set.encoding = 'utf8'
-- Use Unix as the standard file type
set.ffs = 'unix,dos,mac'
-- To keep the cursor on block
set.guicursor = 'i:block'
-- 1 tab == 4 spaces
set.shiftwidth = 4
set.tabstop = 4
-- Linebreak on 500 characters
set.tw = 500
-- Status line Always show the status line
set.laststatus = 3
-- set mouse= to disable the mouse
set.mouse = 'a'
set.undodir = '/home/dk/.config/nvim/undo'
set.winbar = '%=%m\\ %f'
-- for the tagbar refresh time
set.updatetime = 1
-- Specify the behavior when switching between buffers
set.switchbuf = 'useopen,usetab,newtab'
set.stal = 2
-- Enable folding
set.foldmethod = 'indent'
set.foldlevel = 99
-- For spell checking
-- set.spell = true

-- g
local g = vim.g
-- mapleader for extra commands combinations
g.mapleader = ','

-- syntax checking
g.syntastic_enable_signs  = 0
g.syntastic_auto_loc_list = 0
g.syntastic_check_on_open = 0
g.syntastic_check_on_wq   = 0

-- For the sticky header
g.context_enabled = 1

-- For the minimap plugin
-- let g:minimap_width = 10
-- let g:minimap_auto_start = 1
-- let g:minimap_auto_start_win_enter = 1
-- >>>>>>>>>>

-- For the fuzzy search
g.fzf_preview_window = 'right:50%'
g.fzf_layout = { window = { width = 0.9, height = 0.9}}

-- For simplyfolding
g.SimpylFold_docstring_preview=1


-- Vista stuffs
-- How each level is indented and what to prepend.
-- This could make the display more compact or more spacious.
-- e.g., more compact: ["▸ \", \""]
-- Note: this option only works for the kind renderer, not the tree renderer.
g.vista_icon_indent = {"╰─▸ ", "├─▸ "}
-- Executive used when opening vista sidebar without specifying it.
-- See all the avaliable executives via `:echo g:vista#executives`.
g.vista_default_executive = 'ctags'
-- Declare the command including the executable and options used to generate ctags output
-- for some certain filetypes.The file path will be appened to your custom command.
-- For example:
g.vista_ctags_cmd = {
    ["haskell"]="hasktags -x -o - -c"
}
-- To enable fzf's preview window set g:vista_fzf_preview.
-- The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
-- For example:
g.vista_fzf_preview = { 'right:40%' }
-- Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
g['vista#renderer#enable_icon'] = 1
-- The default icons can't be suitable for all the filetypes, you can extend it as you wish.
g['vista#renderer#icons'] = {
    ["function"]="\\uf794",
    ["variable"]="\\uf71b",
}
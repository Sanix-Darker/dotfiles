-- Enable filetype plugins
vim.api.nvim_command('filetype plugin indent on')
-- Enable syntax highlighting
vim.api.nvim_command('syntax enable on')

-- mapleader for extra commands combinations
vim.g.mapleader = ','

local set = vim.opt
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
set.undodir = '~/.config/nvim/undo'
set.winbar = '%=%m\\ %f'
-- for the tagbar refresh time
set.updatetime = 1
-- Specify the behavior when switching between buffers
set.switchbuf = 'useopen,usetab,newtab'
set.stal = 2
-- Enable folding
set.foldmethod = 'indent'
set.foldlevel = 99
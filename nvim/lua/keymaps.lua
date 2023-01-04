-- Some utils function like mapping
local map = function (mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- Toggle linter
map("n", "<C-k>", ":SyntasticCheck<cr>")
map("n", "<C-l>", ":SyntasticToggleMode<cr>")

-- Useful mappings for managing tabs
map("n", "tn", ":tabnew<CR>")
map("n", "to", ":tabonly<CR>")
map("n", "tc", ":tabclose<CR>")
map("n", "tm", ":tabmove<CR>")

-- for spliting screen
map("n", ";ws", ":split<cr>")
map("n", ";wv", ":vsplit<cr>")

-- Opens a new tab with the current buffer's path
-- Super useful when editing files in the same directory
map("n", "te", ":tabedit <C-r>=expand(\"%:p:h\")<cr>/")
-- tl To toggle to the last table where i was !
map("n", "tl", ":exe \"tabn \".g:lasttab<CR>")

-- Switch CWD to the directory of the open buffer
map("n", "cd", ":cd %:p:h<cr>:pwd<cr>")

-- map("n", "<leader>nf :call NERDTreeToggleInCurDir()<cr>
-- For the history of the file, where you at
map("n", "mm", ":MundoToggle<cr>")
-- For the :Ag search on the whole project
-- --hidden --ignore .git
map("n", "fg", ":Ag<CR>", { noremap = true }) -- noremap for non recursive
-- For the map("of the code
map("n", "vv", ":Vista!!<CR>")

-- To indent multiple time in visual mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- To search for ctags
map("n", "bg", ":Vista finder ctags<CR>")
-- To undo a git hunk change
map("n", "ZX", ":GitGutterUndoHunk<CR>")
-- To format the code
map("n", "fv", ":Neoformat<CR>")
-- To jump fastly on a word
map("n", "jj", ":HopWord<CR>")
-- Most efficient than the ? or /
map("n", "ll", ":Lines<CR>")
-- For the file search
map("n", "ff", ":Files<cr>")
-- To access all tabs in a single view as a popUp
map("n", "tt", ":Windows<cr>")
-- To access all marks i left from all opened files...
-- anywhere.
map("n", "tg", ":Marks<cr>")
-- To get th, history of all my opened files  
map("n", "hh", ":History<cr>")
-- To get th, whole history of the current buffer in term of commits
map("n", "hg", ":BCommit<cr>")
-- To get an, search from command history
map("n", "hc", ":Commands<cr>")
-- To get th, diffview history of the repo
map("n", "ft", ":DiffviewFileHistory<CR>")
-- For panes resizing
map("n", "+", ":vertical resize +5<CR>")
map("n", "_", ":vertical resize -5<CR>")
map("n", "=", ":resize +5<CR>")
map("n", "-", ":resize -5<CR>")
-- To open buffers
map("n", "bb", ":Buffers<CR>")
-- For git blame
map("n", "b", ":GitBlame<CR>")
-- To get +/- on changes inside a file from a project
map("n", "HH", ":GitGutterFold<CR>:GitGutterLineHighlightsToggle<CR>")
map("n", "<C-Space>", ":GitGutterPreviewHunk<CR>")
map("n", "hn", ":GitGutterNextHunk<CR>")
map("n", "hp", ":GitGutterPrevHunk<CR>")
-- This should go on terminal normal mode such as normal edition on neovim
map("t", "<Esc>", "<C-\\><C-n>")
-- For command execution directly in vim
-- map("n", "z :!
-- map("<Leader>s :<C-u>call gitblame#echo()<CR>
-- To open the nvim configuration
-- map("n", "co :tabnew ~/.config/nvim/config.vim<CR>

-- To actualize the vim configuration
map("n", "so", ":so %<CR><Esc>:e<CR>")
-- To clean the search hightlights
map("n", "no", ":nohlsearch<CR>")
-- To paste multiple times the same 
-- stuff or use P for the default behaviour
map("x", "p", "pgvy")
-- To Ctrl-BackSpace delete a whole previous word
map("x", "<C-H>", "dvbh")
map("n", "<C-H>", "dvbh")
-- To cut directly the current line
map("x", "X", "dd<Esc>")
map("n", "X", "dd")
map("n", "<Del>", "\"_dd")
-- To replace in the whole project a string by another one:
map("n", "RR", ":20Term bash <CR>clear<CR>find . -name '*.py' -exec ex +'%s/<old>/<new>/ge' -V1 -scwq! {} ';'")
-- To comment fastly
map("x", "Z", ":Commentary<CR>")
map("n", "Z", ":Commentary<CR>")
-- To duplicate the current line
map("x", "B", "yyp")
map("n", "B", "yyp")
-- Normal copy paste Shortcuts
map("v", "Y", "\"+y")
map("v", "P", "\"+p")

-- Disable/Uninstalled for now
-- For floating windows
-- map("n", "k :15Term 
-- map("n", "kb :15Term bash <CR>
map("n", "nk", ":FloatermNew --height=0.9 --width=0.9<CR>")
map("n", "kkk", ":FloatermKill<CR>")
map("n", "kk", ":FloatermToggle<CR>")

-- => Visual mode related
-- Visual mode pressing * or # searches for the current selection
-- Super useful! From an idea by Michael Naumann
map("v", "*", ":<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>", { silent = true })
map("v", "#", ":<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>", { silent = true })

-- => Moving around, tabs, windows and buffers
-- map("<Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map("n", "<space>", "/")
map("n", "<C-space>", "?")
-- Disable highlight when <leader><cr> is pressed
map("n", "<leader><cr>", ":noh<cr>", {silent = true})
-- Close the current buffer
map("n", "<leader>bd", ":Bclose<cr>:tabclose<cr>gT")
-- Close all the buffers
map("n", "<leader>ba", ":bufdo bd<cr>")
-- to switch between buffers
map("n", "<leader>l", ":bnext<cr>")
map("n", "<leader>h", ":bprevious<cr>")

-- """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
-- => Editing mappings
-- """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
-- Remap("VIM 0 to first non-blank character
map("n", "0", "^")

-- Move a line of text using ALT+[jk] or Command+[jk] on mac
map("n", "<M-j>", "mz:m+<cr>z")
map("v", "<M-j>", ":m'>+<cr>>mzgvz")
map("v", "<M-k>", ":m'<-2<cr><mzgvz")

-- """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
-- --=> Misc
-- """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
-- --Remove the Windows ^M - when the encodings gets messed up
map("n", "<Leader>m", "mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm")
-- Quickly open a buffer for scribble
map("n", "<leader>q", ":e ~/buffer<cr>")
-- Quickly open a markdown buffer for scribble
map("n", "<leader>x", ":e ~/buffer.md<cr>")
-- Toggle paste mode on and off
map("n", "<leader>pp", ":setlocal paste!<cr>")
map("n", "<S-Left>", "<S-Left>")
map("x", "<S-Left>", "<S-Left>")
map("n", "<S-Right>", "<S-Right>")
map("x", "<S-Right>", "<S-Right>")

--  inoremap ;; <Esc>
map("i", ";;", "<Esc>")

-- NVIM DAP
--Uncomment this when debuging
-- nnoremap DH :lua require'dap'.toggle_breakpoint()<CR>
-- nnoremap <S-k> :lua require'dap'.step_out()<CR>
-- nnoremap <S-l> :lua require'dap'.step_into()<CR>
-- nnoremap <S-j> :lua require'dap'.step_over()<CR>
-- nnoremap DS :lua require'dap'.close()<CR>
-- nnoremap DN :lua require'dap'.continue()<CR>
-- nnoremap DJ :lua require'dap'.down()<CR>
-- nnoremap D_ :lua require'dap'.disconnect();require'dap'.stop();require'dap'.run_last()<CR>
-- nnoremap DR :lua require'dap'.repl.open({}, 'vsplit')<CR><C-w>l
-- nnoremap DI :lua require'dap.ui.variables'.hover()<CR>
-- vnoremap DII :lua require'dap.ui.variables'.visual_hover()<CR>
-- nnoremap D? :lua require'dap.ui.variables'.scopes()<CR>
-- nnoremap DE :lua require'dap'.set_exception_breakpoints({"all"})<CR>
-- nnoremap DA :lua require'debugHelper'.attach()<CR>
-- nnoremap DA :lua require'debugHelper'.attachToRemote()<CR>
-- nnoremap DI :lua require'dap.ui.widgets'.hover()<CR>
-- nnoremap D? :lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>

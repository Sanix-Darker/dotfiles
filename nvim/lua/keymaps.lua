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
-- Opens a new tab with the current buffer's path
-- Super useful when editing files in the same directory
map("n", "te", ":tabedit <C-r>=expand(\"%:p:h\")<cr>/")
-- tl To toggle to the last table where i was !
map("n", "tl", ":exe \"tabn \".g:lasttab<CR>")

-- for spliting screen
map("n", ";s", ":split<cr>")
map("n", ";v", ":vsplit<cr>")

-- Switch CWD to the directory of the open buffer
map("n", "cd", ":cd %:p:h<cr>:pwd<cr>")

-- map("n", "<leader>nf :call NERDTreeToggleInCurDir()<cr>
-- For the history of the file, where you at
map("n", "mm", ":MundoToggle<cr>")
-- For the :Ag search on the whole project
-- --hidden --ignore .git
map("n", "<Leader>fg", ":Ag<CR>", { noremap = true }) -- noremap for non recursive
-- For the map("of the code
map("n", "vv", ":Vista!!<CR>")
map("n", "<Leader>w", ":w<CR>")
map("n", "<Leader>q", ":q<CR>")
map("n", "<Leader>e", ":e<CR>")

-- calculator mode
map("n", "<Leader>i", "i<C-r>=")

-- To indent multiple time in visual mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- to paste and select what we jut paste
map("n", "gp", "`[v`]")
-- For easyAlig--
map("x", "ga", ":EasyAlign*")

-- let's say i made a lot of changes in 
-- my file and i didn't save yet and i want to go back 
-- to the previous state of my file
map("n", "U", ":ea 1f<CR>")

-- To move text up and down like a pro
-- shortcuts to move texts up and down
map("n", "<A-S-j>", ":m .+1<CR>==")
map("n", "<A-S-k>", ":m .-2<CR>==")
map("i", "<A-S-j>", "<Esc>:m .+1<CR>==gi")
map("i", "<A-S-k>", "<Esc>:m .-2<CR>==gi")
map("v", "<A-S-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-S-k>", ":m '<-2<CR>gv=gv")

-- # Octo nvim shortcuts
map("n", "<Leader>prc", ":Octo pr create<CR>")
map("n", "<Leader>prl", ":Octo pr list<CR>")

map("n", "<Leader>rs", ":Octo review start<CR>")
map("n", "<Leader>rss", ":Octo review resume<CR>")
map("n", "<Leader>rsm", ":Octo review submit<CR>")
map("n", "<Leader>rd", ":Octo review discard<CR>")
map("n", "<Leader>rc", ":Octo review close<CR>")
-- Octo nvim

-- Commentary
map("v", "Z", ":Commentary<CR>")
map("n", "Z", "V:Commentary<CR>")

-- # rest-console
-- jq formating of the content of the current buffer
-- We set the modifiable for it then we pipe the output to jq 
-- for json
map("n", "=j",  ":set ma<CR>:%!jq<CR>")
-- for yaml 
map("n", "=y",  ":set ma<CR>:%!yq<CR>")
-- for rest-console Ctrl+j shortCut to format the output too
-- should be change depending on the output type, but for now 
-- as default will be json so jq
map("n", "<Leader>jk", ":call VrcQuery()<CR><C-w><C-w>:set ma<CR>:%!jq<CR><C-w><C-w>")
-- rest-console

-- To search for ctags
map("n", "<Leader>bg", ":Vista finder ctags<CR>")
-- To undo a git hunk change
map("n", "ZX", ":GitGutterUndoHunk<CR>", { noremap = true })
-- To format the code
map("v", "fv", ":Neoformat<CR>")
-- To jump fastly on a word
map("n", "<Leader>jj", ":HopWord<CR>")
-- Most efficient than the ? or /
map("n", "<Leader>ll", ":Lines<CR>")
-- For the file search
map("n", "<Leader>ff", ":Files<cr>")
-- To access all marks i left from all opened files...
map("n", "<Leader>mm", ":Marks<cr>")
-- To access all tabs in a single view as a popUp
map("n", "<Leader>tt", ":Windows<cr>")
-- To get th, history of all my opened files
map("n", "<Leader>hh", ":History<cr>")
-- To get th, whole history of the current buffer in term of commits
map("n", "<Leader>hg", ":BCommit<cr>")
-- To get an, search from command history
map("n", "<Leader>hc", ":Commands<cr>")
-- To open buffers
map("n", "<Leader>bb", ":Buffers<CR>")
-- To get th, diffview history of the repo
-- since this got remove as a plugin
-- map("n", "ft", ":DiffviewFileHistory<CR>")
-- For panes resizing
map("n", "+", ":vertical resize +5<CR>")
map("n", "_", ":vertical resize -5<CR>")
map("n", "=", ":resize +5<CR>")
map("n", "-", ":resize -5<CR>")

-- movements on the panes
map("n", "<space>h", "<C-W>h")
map("n", "<space>l", "<C-W>l")
map("n", "<space>k", "<C-W>k")
map("n", "<space>j", "<C-W>j")

-- let's add some registers shortcuts, 
-- i only need those 3
map("v", "<Leader>a", "\"ay") -- to add to register
map("v", "<Leader>A", "\"Ay") -- to append to the register
map("n", "<Leader>a", "\"ap")

map("v", "<Leader>c", "\"cy") -- to add to register
map("v", "<Leader>C", "\"Cy") -- to append to the register
map("n", "<Leader>c", "\"cp")
-- could be usefull to fastly edit and use registers
-- map("v", "<Leader>q", "\"qy")
-- map("v", "<Leader>Q", "\"Qy")
-- map("n", "<Leader>q", "\"qp")

-- will use numbers to go fast
-- register 1
map("v", "<Leader>1", "\"1y")
map("n", "<Leader>1", "\"1p")
-- register 2
map("v", "<Leader>2", "\"2y")
map("n", "<Leader>2", "\"2p")
-- register 3
map("v", "<Leader>3", "\"3y")
map("n", "<Leader>3", "\"3p")

map("v", "<Leader>x", "\"xy")
map("v", "<Leader>X", "\"Xy")
map("n", "<Leader>x", "\"xp")

-- For git blame using GitMessenger
map("n", "<Leader><space>", ":GitMessenger<CR>")

-- to copy the current path of a file in the clipboard(the empty registry)
map("n", "cp", ":let @\" = expand(\"%\")<cr>")

-- To get +/- on changes inside a file from a project
map("n", "<Leader>HH", ":GitGutterFold<CR>:GitGutterLineHighlightsToggle<CR>", { noremap = true })
map("n", "<C-Space>", ":GitGutterPreviewHunk<CR>", { noremap = true })
-- since the lsp can help me do that
-- map("n", "<Leader>hn", ":GitGutterNextHunk<CR>", { noremap = true })
-- map("n", "<Leader>hp", ":GitGutterPrevHunk<CR>", { noremap = true })
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
-- To cut directly the current line
-- to delete without saving in any register
map("x", "x", "\"_x")
map("n", "x", "\"_x")
map("x", "X", "\"_dd")
map("n", "X", "\"_dd")
map("n", "<Del>", "\"_dd")
-- To replace in the whole project a string by another one:
map("n", "RR", ":20Term bash <CR>clear<CR>find . -name '*.py' -exec ex +'%s/<old>/<new>/ge' -V1 -scwq! {} ';'")
-- To duplicate the current line
-- map("x", "B", "yyp")
-- map("n", "B", "yyp")
-- Normal copy paste Shortcuts
map("v", "Y", '"+y')
map("v", "P", '"+p')
map("n", "P", '"+p')

-- Disable/Uninstalled for now
-- For floating windows
-- map("n", "k :15Term
-- map("n", "kb :15Term bash <CR>
map("n", "<Leader>k", ":FloatermNew --height=0.9 --width=0.9<CR>")
-- map("n", "<Leader>kkk", ":FloatermKill<CR>") -- should be killed by exiting it directly
map("n", "<Leader><C-k>", ":FloatermToggle<CR>")
map("n", "<Leader>kn", ":FloatermNext<CR>")
map("n", "<Leader>kp", ":FloatermPrev<CR>")

-- => Visual mode related
-- Visual mode pressing * or # searches for the current selection
-- Super useful! From an idea by Michael Naumann
map("v", "*", ":<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>", { silent = true })
map("v", "#", ":<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>", { silent = true })

-- => Moving around, tabs, windows and buffers
-- map("<Space> to / (search) and Ctrl-<Space> to ? (backwards search)
-- map("n", "<space>", "/")
-- map("n", "<C-space>", "?")
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
-- map("n", "<leader>q", ":e ~/buffer<cr>")
-- Quickly open a markdown buffer for scribble
-- map("n", "<leader>x", ":e ~/buffer.md<cr>")
-- Toggle paste mode on and off
map("n", "<leader>pp", ":setlocal paste!<cr>")

-- Displays hover information about the symbol under the cursor
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
-- Jump to the definition
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
-- Jump to declaration
map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
-- Lists all the implementations for the symbol under the cursor
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
-- Jumps to the definition of the type symbol
map('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
-- Lists all the references 
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
-- map('n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>')
-- map('n','gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
map('n','<leader>gw','<cmd>lua vim.lsp.buf.document_symbol()<CR>')
map('n','<leader>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
-- map('n','<leader>ah','<cmd>lua vim.lsp.buf.hover()<CR>')
-- map('n','<leader>af','<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n','<leader>ee','<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
map('n','<leader>rr','<cmd>lua vim.lsp.buf.rename()<CR>')
map('n','<leader>=', '<cmd>lua vim.lsp.buf.format()<CR>')
-- map('n','<leader>ai','<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
-- map('n','<leader>ao','<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
-- Displays a function's signature information
map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
-- Renames all references to the symbol under the cursor
map('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
-- Selects a code action available at the current cursor position
map('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
map('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
-- Show diagnostics in a floating window
map('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
-- Move to the previous diagnostic
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
-- Move to the next diagnostic
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

--  inoremap ;; <Esc>
-- map("i", ";;", "<Esc>")

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

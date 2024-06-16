-- Some utils function like mapping
local map = function (mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- ShortCuts to switch from camelCase to snake_case and reverse too
map("v", "<Leader>cs", ':s/\\v([a-z]+)([A-Z])/\\1_\\l\\2/g<CR>', {noremap = true})
map("v", "<Leader>sc", ':s/\\v_(\\w)/\\u\\1/g<CR>', {noremap = true})

-- convert rows to columns( to convert columns in row it's just J )
map("v", "<Leader>J", ':s/ /\\r/g|+&&|\'[-;1,g/^/\'\'+m.|-j/g<CR>')

-- command mode with the edition like...
-- and enter in insert mode
-- map("n", ":", ":<C-f>")
-- map("v", ":", ":<C-f>")

-- execute using bash and get the output on the next line below what i just
map("v", "<Leader>xx", ":w !bash<CR>")

-- to fold or unfold code :
map("n", "<space><space>", "za")
map("v", "<space>", "zf")

-- To saved Obsession session
map("n", "<Leader>ss", ":Obsession<cr>")
-- To reload a saved session for the current directory
map("n", "ss", ":source Session.vim<cr>")

-- Toggle linter
map("n", "<C-k>", ":SyntasticCheck<cr>")
map("n", "<C-l>", ":SyntasticToggleMode<cr>")

-- Useful mappings for managing tabs
map("n", "tn", ":tabnew<CR>")
map("n", "to", ":tabonly<CR>")
map("n", "tc", ":tabclose<CR>")
map("n", "tm", ":tabmove<CR>")
--map("n", "<Leader>gt", ":tabprevious<CR>") -- to get back to the last visited  tab
map("n", "<Leader>gt", ":exe \"tabn \".g:lasttab<CR>") -- this is bettert
-- Opens a new tab with the current buffer's path
-- Super useful when editing files in the same directory
map("n", "te", ":tabedit <C-r>=expand(\"%:p:h\")<cr>/")

-- for spliting screen
map("n", ";b", ":split<cr>")
map("n", ";s", ":vsplit<cr>")

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

-- github actions status
map("n", "<Leader>gh", ":GhActions<CR>")

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
-- for json -> jq
map("v", "<Leader>jq",  ":%!jq<CR>")
-- for yaml -> yq
map("v", "<Leader>yq",  ":%!yq eval<CR>")
-- for html -> tidy, install with : https://github.com/htacg/tidy-html5/releases/tag/5.8.0
-- for xmllint, install with : sudo apt install libxml2-utils -y
map("v", "<Leader>hq",  ":%!xmllint --format - <CR>")
-- for rest-console Ctrl+j shortCut to format the output too
-- should be change depending on the output type, but for now
-- as default will be json so jq
map("n", "<Leader>jk", ":call VrcQuery()<CR><C-w><C-w>:set ma<CR>:%!jq<CR>:set filetype=json<CR><C-w><C-w>")

-- map("n", "<Leader>jk", "<Plug>RestNvim") -- run the request under the cursor
-- map("n", "<Leader>jp", "<Plug>RestNvimPreview") -- preview the request cURL command
-- map("n", "<Leader>jl", "<Plug>RestNvimLast") -- re-run the last request
-- -- rest-console


-- To search for ctags
map("n", "<Leader>bg", ":Vista finder ctags<CR>")
-- To format the code
map("v", "fv", ":Neoformat<CR>")
-- for clang formating
map("v", "<Leader>cf", ":ClangFormat<CR>")

-- To jump fastly on a word
map("n", "<Leader>jj", ":HopWord<CR>")
-- Most efficient than the ? or /
map("n", "<Leader>ll", ":Lines<CR>")
-- For the file search
map("n", "<Leader>ff", ":Files<cr>")
-- To access all marks i left from all opened files...
-- to add a new mark : ma (a is the mark)
-- to go to a mark : 'a (a is the mark)
-- to delete a mark : d'a (a is the mark)
map("n", "<Leader>mm", ":Marks<cr>")
-- To access all tabs in a single view as a popUp
map("n", "<Leader>tt", ":Windows<cr>")
-- to list all trouble diagnostics i have in the same file:
map("n", "<Leader>tr", ":TroubleToggle<CR>")
-- To get th, history of all my opened files
map("n", "<Leader>hh", ":History<cr>")
-- To get th, whole history of the current buffer in term of commits
map("n", "<Leader>gc", ":BCommit<cr>")
-- To get an, search from command history
map("n", "<Leader>hc", ":Commands<cr>")
-- To open buffers
map("n", "<Leader>bb", ":Buffers<CR>")
-- To get files changes from $(git status)
map("n", "<Leader>gs", ":GF?<CR>")
-- To get th, diffview history of the repo
-- since this got remove as a plugin
-- map("n", "ft", ":DiffviewFileHistory<CR>")
-- For panes resizing
map("n", "+", ":vertical resize +5<CR>")
map("n", "_", ":vertical resize -5<CR>")
map("n", "=", ":resize +5<CR>")
map("n", "-", ":resize -5<CR>")
-- custom zoom IN/OUT
map("n", "<Leader>)", ":resize +80<CR>:vertical resize +80<CR>")
-- There is no need to zoom out because all the other split screen will still
-- visibles
-- map("n", "<Leader>(", ":resize -10<CR>:vertical resize -20<CR>")

-- movements on the panes
map("n", "<space>h", "<C-W>h")
map("n", "<space>l", "<C-W>l")
map("n", "<space>k", "<C-W>k")
map("n", "<space>j", "<C-W>j")

-- let's add some registers shortcuts,
-- i only need those 3
-- map("v", "<Leader>a", "\"ay") -- to add to register
-- map("v", "<Leader>A", "\"Ay") -- to append to the register
-- map("n", "<Leader>a", "\"ap")

-- map("v", "<Leader>d", "\"dy") -- to add to register
-- map("v", "<Leader>D", "\"Dy") -- to append to the register
-- map("n", "<Leader>d", "\"dp")

-- map("v", "<Leader>c", "\"cy") -- to add to register
-- map("v", "<Leader>C", "\"Cy") -- to append to the register
-- map("n", "<Leader>c", "\"cp")
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
map("n", "cp", ":let @+=expand('%:p:h') . '/' . expand('%:t')<CR>")

-- to access the clipboard history
map("n", "<Leader>cc", ":reg <CR>")
map("v", "<Leader>cc", ":reg <CR>")

-- prev & nex chunks updates
map("n", "]c", ":Gitsigns next_hunk<CR>")
map("n", "[c", ":Gitsigns prev_hunk<CR>")
-- stage and unstage changes
map("n", "<Leader>as", ":Gitsigns stage_hunk<CR>")
map("n", "<Leader>sa", ":Gitsigns undo_stage_hunk<CR>")
-- To undo a git hunk change
map("n", "ZX", ":Gitsigns reset_hunk<CR>", { noremap = true })
-- To get +/- on changes inside a file from a project
map("n", "<Leader>HH", ":Gitsigns toggle_linehl<CR>:Gitsigns toggle_deleted<CR>", { noremap = true })
map("n", "<C-Space>", ":Gitsigns preview_hunk<CR>", { noremap = true })

-- since the lsp can help me do that
-- map("n", "<Leader>hn", ":GitGutterNextHunk<CR>", { noremap = true })
-- map("n", "<Leader>hp", ":GitGutterPrevHunk<CR>", { noremap = true })
-- This should go on terminal normal mode such as normal edition on neovim
map("t", "<Esc>", "<C-\\><C-n>")
-- When the terminal is open on Insert ode, i wanna be able to hit the same shortcut to
-- get back on Normal mode
-- For command execution directly in vim
-- map("n", "z :!
-- map("<Leader>s :<C-u>call gitblame#echo()<CR>
-- To open the nvim configuration
-- map("n", "co :tabnew ~/.config/nvim/config.vim<CR>

-- Down is really the next line
map('n', 'j', 'gj')
map('v', 'j', 'gj')
map('n', 'k', 'gk')
map('v', 'k', 'gk')

-- Stay on same position when searching word under cursor
map('n', '*', '*N')
map('n', '#', '#N')
map('n', 'g*', 'g*N')
map('n', 'g#', 'g#N')
map('x', '*', [["yy/\V<C-R>=escape(getreg('y'), '\/?')<CR><CR>N]])
map('x', '#', [["yy?\V<C-R>=escape(getreg('y'), '\/?')<CR><CR>N]])

-- global centering stuffs zz
local opts_center = {
    noremap = true,
    silent = true
}
-- On search, center the screen:
map('n', 'n', 'nzz', opts_center)
map('n', 'N', 'Nzz', opts_center)
map('n', '}', '}zz', opts_center)
map('n', '{', '{zz', opts_center)
map('n', '<C-o>', '<C-o>zz', opts_center)
map('n', '<C-i>', '<C-i>zz', opts_center)
map('n', '<tab>', '<tab>zz', opts_center)

-- Move to the end of yanked text after yank and paste
map('n', 'p', 'p`]')
map('v', 'y', 'y`]')
map('v', 'p', 'p`]')

-- Toggle between last 2 buffers
map('n', '<leader><tab>', '<c-^>')

-- Jump to definition in vertical split
map('n', '<Leader>]', '<C-W>s<C-]>')

-- Close all other buffers except current one
map('n', '<Leader>db', ':silent w <BAR> :silent %bd <BAR> e#<CR>')

-- To actualize the vim configuration
map("n", "so", ":so %<CR><Esc>:e<CR>")
-- To clean the search hightlights
map("n", "no", ":nohlsearch<CR>")
-- To paste multiple times the same
-- stuff or use P for the default behaviour
map("x", "p", "pgvy")
-- To cut directly the current line
-- to delete without saving in any register
map("x", "x", "\"_x<Esc>")
map("n", "x", "\"_x<Esc>")
map("x", "X", "\"_dd<Esc>")
map("n", "X", "\"_dd<Esc>")
map("n", "<Del>", "\"_dd<Esc>")
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
map("n", "<Leader>kk", ":FloatermNew --height=0.9 --width=0.9<CR>")
map("n", "<Leader>k<Space>", ":FloatermToggle<CR>")
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
map("n", "<leader>>", ":bnext<cr>")
map("n", "<leader><", ":bprevious<cr>")

-- $ and 0 are hard to access, so this is to select
-- to the last element in the line or the first
-- move around mode
-- map("n", "L", "$")
-- map("n", "H", "^")
-- -- visual mode selection
-- map("n", "vL", "v$h", {silent = true})
-- map("n", "vH", "v^w", {silent = true})

-- search and replace like an old school
-- then (to replace everywhere) [this works also for custom commands on the
-- quickfix]
-- :cdo %s/item/this/gc
map('v', '<leader>ss', ':vimgrep /@*/ `find . -type f` CR :copen CR')

-- nvim aaaa
-- map('n', '<leader>S', '<cmd>lua require("spectre").open()<CR>', {
--     desc = "Open Spectre"
-- })
-- map('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
--     desc = "Search current word"
-- })
-- map('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
--     desc = "Search current word"
-- })
-- map('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
--     desc = "Search on current file"
-- })

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
-- gD
-- Jump to declaration
-- map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
map('n', 'gD', '<cmd>tab split | lua vim.lsp.buf.definition()<CR>')
-- Lists all the implementations for the symbol under the cursor
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
-- Jumps to the definition of the type symbol
map('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
-- Lists all the references
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
-- map('n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>')
-- map('n','gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
map('n','<leader>gw','<cmd>lua vim.lsp.buf.document_symbol()<CR>')
map('n','<leader>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
map('n','<leader>ah','<cmd>lua vim.lsp.buf.hover()<CR>')
map('n','<leader>af','<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n','<leader>ee','<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
map('n','<leader>rr','<cmd>lua vim.lsp.buf.rename()<CR>')
map('n','<leader>=', '<cmd>lua vim.lsp.buf.format()<CR>')
-- map('n','<leader>ai','<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
-- map('n','<leader>ao','<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
-- Displays a function's signature information
map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
-- Selects a code action available at the current cursor position
-- map('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
map('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
-- Show diagnostics in a floating window
map('n', 'gll', '<cmd>lua vim.diagnostic.open_float()<cr>')
-- Move to the previous diagnostic
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
-- Move to the next diagnostic
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')

--  inoremap to hit normal keybinding in insert mode
-- map("i", "", "<C-o>")

-- NVIM DAP
map('n', '<Leader>dh', ":lua require'dap'.toggle_breakpoint()<CR>")
map('n', '<Leader>dk', ":lua require'dap'.step_out()<CR>")
map('n', '<Leader>dl', ":lua require'dap'.step_into()<CR>")
map('n', '<Leader>dj', ":lua require'dap'.down()<CR>")
map('n', '<Leader>do', ":lua require'dap'.step_over()<CR>")
map('n', '<Leader>ds', ":lua require'dap'.close()<CR>")
map('n', '<Leader>dn', ":lua require'dap'.continue()<CR>")
map('n', '<Leader>d_', ":lua require'dap'.disconnect();require'dap'.stop();require'dap'.run_last()<CR>")
map('n', '<Leader>dr', ":lua require'dap'.repl.open({}, 'vsplit')<CR><C-w>l")
map('n', '<Leader>di', ":lua require'dap.ui.variables'.hover()<CR>")
map('n', '<Leader>dii',":lua require'dap.ui.variables'.visual_hover()<CR>")
map('n', '<Leader>d?', ":lua require'dap.ui.variables'.scopes()<CR>")
map('n', '<Leader>de', ":lua require'dap'.set_exception_breakpoints({\"all\"})<CR>")
map('n', '<Leader>da', ":lua require'debugHelper'.attach()<CR>")
map('n', '<Leader>da', ":lua require'debugHelper'.attachToRemote()<CR>")
map('n', '<Leader>di', ":lua require'dap.ui.widgets'.hover()<CR>")
map('n', '<Leader>d?', ":lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>")
-- to eval expressions vnoremap <M-k> <Cmd>lua require("dapui").eval()<CR>

-- for multi line selection
-- Ctrl+c to quit the mode
-- Shift+V to select and go else where to do the same stuff
map('n', '<Space>v', ':call sml#mode_on()<CR>')

-- LeetCode
-- map('n', '<Leader>lel', ':LeetCodeList<CR>')
-- map('n', '<Leader>let', ':LeetCodeTest<CR>')
-- map('n', '<Leader>les', ':LeetCodeSubmit<CR>')
-- map('n', '<Leader>lei', ':LeetCodeSignIn<CR>')--

-- I need something quick for llm
-- we disable the diagnostic first
-- map('n', '<Leader>o', ':ToggleDiagOff<CR>')
-- map('n', '<Leader>O', ':ToggleDiagOn<CR>')
map('v', '<Leader>lm', ':Llm<CR>')

-- autofold keymaps
map(
    'n',
    "<Leader>FF",
    ":lua require'autofold'.toggle_function_folding()<CR>"
)

-- persistant hightligh
-- highlight selected lines
map('v', '<Leader>v', ":call matchadd('LineHighlight', '\\%'.line('.').'l')<CR>")
map('n', '<Leader>v', ":call matchadd('LineHighlight', '\\%'.line('.').'l')<CR>")
map('n', '<Leader>V', ":call clearmatches()<CR>")
map('v', '<Leader>V', ":call clearmatches()<CR>")

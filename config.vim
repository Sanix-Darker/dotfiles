set runtimepath^=~/.config/nvim/ runtimepath+=~/.config/nvim/after
let &packpath=&runtimepath
source ~/.config/nvim/plugins.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" To show hidden files
let NERDTreeShowHidden=1

" syntax checking
let g:syntastic_enable_signs  = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq   = 0
" <<<<<

" For the sticky header
let g:context_enabled = 1
" <<<<<

" For the minimap plugin
" let g:minimap_width = 10
" let g:minimap_auto_start = 1
" let g:minimap_auto_start_win_enter = 1
" >>>>>>>>>>

" For the fuzzy search
let g:fzf_preview_window = 'right:50%'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9  }  }
" <<<<<<<

" For the synthax
let b:ale_linters = ['flake8']
" Some fixers...
let b:ale_fixers = ['eslint']
let b:ale_fix_on_save = 1

" For simplyfolding
let g:SimpylFold_docstring_preview=1

" Vista stuffs
" How each level is indented and what to prepend.
" This could make the display more compact or more spacious.
" e.g., more compact: ["▸ \", \""]
" Note: this option only works for the kind renderer, not the tree renderer.
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'ctags'
" Declare the command including the executable and options used to generate ctags output
" for some certain filetypes.The file path will be appened to your custom command.
" For example:
let g:vista_ctags_cmd = {
\ 'haskell': 'hasktags -x -o - -c',
\ }
" To enable fzf's preview window set g:vista_fzf_preview.
" The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
" For example:
let g:vista_fzf_preview = ['right:40%']
" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1
" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }

" ------ for silicon and screenshot from the source code
" Generate an image of the current buffer and write it to /path/to/output.png
" :Silicon /path/to/output.png
" " Generate an image of the current buffer and write it to /path/to/output.png and clipboard.
" :Silicon /path/to/output.png --to-clipboard
" " Generate an image of the current buffer and write it to /path/to/<filename>.png
" :Silicon /path/to/
" " Generate an image of the current visual line selection and write it to /path/to/output.png
" :'<,'>Silicon /path/to/output.png
" " Generate an image of the current buffer, with the current visual line selection highlighted.
" :'<,'>Silicon! /path/to/output.png
let g:silicon = {
      \   'theme':              'Dracula',
      \   'font':                  'Hack',
      \   'background':         '#FFFFFF',
      \   'shadow-color':       '#555555',
      \   'line-pad':                   2,
      \   'pad-horiz':                 80,
      \   'pad-vert':                 100,
      \   'shadow-blur-radius':         0,
      \   'shadow-offset-x':            0,
      \   'shadow-offset-y':            0,
      \   'line-number':           v:true,
      \   'round-corner':          v:true,
      \   'window-controls':       v:true,
      \ }

nnoremap <leader>f <Esc>:cd %:p:h<CR><Esc>:Ag<CR>

" => Visual mode related
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" => Moving around, tabs, windows and buffers
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <C-space> ?
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>
" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT
" Close all the buffers
map <leader>ba :bufdo bd<cr>
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>
" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/
" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Toggle linter
nnoremap <C-k> :SyntasticCheck<cr>
nnoremap <C-l> :SyntasticToggleMode<cr>

" Useful mappings for managing tabs
nnoremap tn :tabnew<CR>
nnoremap to :tabonly<CR>
nnoremap tc :tabclose<CR>
" nnoremap <leader>nf :call NERDTreeToggleInCurDir()<cr>
" For the history of the file, where you at
nnoremap mm :MundoToggle<cr>
" For the :Ag search on the whole project
" --hidden --ignore .git
nnoremap fg :Ag<CR>
" For the map of the code
nnoremap vv :Vista!!<CR>
" For Emmet html and css
" documentation : https://docs.emmet.io/cheat-sheet/
" nnoremap em :Emmet 

" To indent multiple time in visual mode
vnoremap < <gv
vnoremap > >gv

" To search for ctags
nnoremap bg :Vista finder ctags<CR>
" To undo a git hunk change
nnoremap ZX :GitGutterUndoHunk<CR>
" To format the code
nnoremap fv :Neoformat<CR>
" To jump fastly on a word
nnoremap jj :HopWord<CR>
" To search in the current files
" For hidden files of fzf
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
" Most efficient than the ? or /
nnoremap ll :Lines<CR>
" For the file search
nnoremap ff :Files<cr>
" To access all tabs in a single view as a popUp
nnoremap tt :Windows<cr>
" To access all marks i left from all opened files...
" anywhere...
nnoremap tg :Marks<cr>
" To get the history of all my opened files  
nnoremap hh :History<cr>
" To get the whole history of the current buffer in term of commits
nnoremap hg :BCommit<cr>
" To get the diffview history of the repo
nnoremap ft :DiffviewFileHistory<CR>
" For the copy/paste power of yankring
nnoremap <silent> <F11> :YRShow<CR>
nnoremap + :vertical resize +5<CR>
nnoremap _ :vertical resize -5<CR>
nnoremap = :resize +5<CR>
nnoremap - :resize -5<CR>
" Clean and erase the buffer
nnoremap bbb :%bd\|e#\|bd#<cr>
" To open buffers
nnoremap bb :Buffers<CR>
" For git blame
nnoremap b :GitBlame<CR>
" To get +/- on changes inside a file from a project
nnoremap HH :GitGutterFold<CR>:GitGutterLineHighlightsToggle<CR>
nnoremap <C-Space> :GitGutterPreviewHunk<CR>
nnoremap hn :GitGutterNextHunk<CR>
nnoremap hp :GitGutterPrevHunk<CR>
" This should go on terminal normal mode such as normal edition on neovim
tnoremap <Esc> <C-\><C-n>
" For command execution directly in vim
" nnoremap z :!
" map <Leader>s :<C-u>call gitblame#echo()<CR>
" To open the nvim configuration
" nnoremap co :tabnew ~/.config/nvim/config.vim<CR>

" To actualize the vim configuration
nnoremap so :so $MYVIMRC<CR>
" To clean the search hightlights
nnoremap no :nohlsearch<CR>
" To paste multiple times the same 
" stuff or use P for the default behaviour
xnoremap p pgvy
" To Ctrl-BackSpace delete a whole previous word
xnoremap <C-H> dvbh
nnoremap <C-H> dvbh
" To cut directly the current line
xnoremap X dd
nnoremap X dd
nnoremap <Del> "_dd
" To replace in the whole project a string by another one:
nnoremap RR :20Term bash <CR>clear<CR>find . -name '*.py' -exec ex +'%s/<old>/<new>/ge' -V1 -scwq! {} ';'
" To comment fastly
xnoremap Z :Commentary<CR>
nnoremap Z :Commentary<CR>
" To duplicate the current line
xnoremap B yyp
nnoremap B yyp
" Disable/Uninstalled for now
" For floating windows
" nnoremap k :15Term 
" nnoremap kb :15Term bash <CR>
nnoremap nk :FloatermNew --height=0.9 --width=0.9<CR>
nnoremap kkk :FloatermKill<CR>
nnoremap kk :FloatermToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>z
vmap <M-j> :m'>+<cr>>mzgvz
vmap <M-k> :m'<-2<cr><mzgvz

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
    " autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader> for spelling
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>
" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>
" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au FocusGained,BufEnter * checktime

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

map <C-n> :call NERDTreeToggleAndRefresh()<CR>
function NERDTreeToggleAndRefresh()
  if g:NERDTree.IsOpen()
    :NERDTreeToggle
  else
    :NERDTreeFind
  endif
endfunction

" Use K to show documentation in preview window.
nnoremap <silent> KKK :call <SID>show_documentation()<CR>

function! s:SID()
    if ! exists('s:sid')
        let s:sid = matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
    endif
    return s:sid
endfunction
let s:SNR = '<SNR>'.s:SID().'_'

autocmd VimEnter * call NERDTreeAddKeyMap({
     \ 'key': 'w',
     \ 'callback': s:SNR.'toggle_width',
    \ 'quickhelpText': 'Toggle window width' })
function! s:toggle_width()
    let l:max = 0
    for l:z in range(1, line('$'))
        let l:len = len(getline(l:z))
        if l:len > l:max
            let l:max = l:len
        endif
    endfor
    exe 'vertical resize '.(l:max == winwidth('.') ? g:NERDTreeWinSize : l:max)
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . \" " . expand('<cword>')
  endif
endfunction

" set thosse elements depending on the filetype am inside
if has("autocmd")
    autocmd FileType yaml set cursorcolumn
    autocmd FileType yml set cursorcolumn
endif

try
    if has("autocmd")
        " Open last active file(s) if VIM is invoked without arguments.
        autocmd VimLeave * nested let buffernr = bufnr("$") |
            \ let buflist = [] |
            \ while buffernr > 0 |
            \	if buflisted(buffernr) |
            \	    let buflist += [ bufname(buffernr) ] |
            \	endif |
            \   let buffernr -= 1 |
            \ endwhile |
            \ if (!isdirectory($HOME . "/.config/nvim")) |
            \	call mkdir($HOME . "/.config/nvim") |
            \ endif |
            \ call writefile(reverse(buflist), $HOME . "/.config/nvim/buflist.txt")

        " To print the exception
        echomsg v:exception
    endif
catch
endtry

try
    if has("autocmd")
        autocmd VimEnter * nested if argc() == 0 && filereadable($HOME . "/.config/nvim/buflist.txt") |
            \	for line in readfile($HOME . "/.config/nvim/buflist.txt") |
            \	    if filereadable(line) |
            \		execute "tabedit " . line |
            \		set bufhidden=delete |
            \	    endif |
            \	endfor |
            \	tabclose 1 |
            \ endif

        " to print the exception
        echomsg v:exception
    endif
catch
endtry

try
    " Auto generate tags file on file write of *.c and *.h files
    autocmd BufWritePost *.c,*.h silent! !ctags . &
catch
endtry

" Enable folding with the spacebar
nnoremap <space> za

try
    if has("autocmd")
        " To add the proper PEP8 indentation
        au BufNewFile,BufRead *.py
            \ set tabstop=4 |
            \ set softtabstop=4 |
            \ set shiftwidth=4 |
            \ set textwidth=79 |
            \ set expandtab |
            \ set autoindent |
            \ set fileformat=unix

        " To activate the rest plugin if we're inside a rest file
        au BufNewFile,BufRead *.rest
            \ set ft=rest

        " We want everything fold depending on the synthax when we jump into it
        set foldmethod=syntax
        set foldnestmax=1

        "Flagging Unnecessary Whitespace
        highlight BadWhitespace ctermbg=red guibg=darkred
        au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

        " For the tagbag list of tags
        " au BufRead * :Vista<CR> <C-w> h
    endif
catch
endtry

" Format the code on save
" augroup fmt
"   autocmd!
"   autocmd BufWritePre * undojoin | Neoformat
" augroup END

" To preview images from specific extensions
" au BufRead *.png,*.jpg,*.jpeg :call DisplayImage()

" Uncomment this when debuging
" nnoremap DH :lua require'dap'.toggle_breakpoint()<CR>
" nnoremap <S-k> :lua require'dap'.step_out()<CR>
" nnoremap <S-l> :lua require'dap'.step_into()<CR>
" nnoremap <S-j> :lua require'dap'.step_over()<CR>
" nnoremap DS :lua require'dap'.close()<CR>
" nnoremap DN :lua require'dap'.continue()<CR>
" nnoremap DUI :lua require'dapui'.toggle()<CR>
" nnoremap DK :lua require'dap'.up()<CR>
" nnoremap DJ :lua require'dap'.down()<CR>
" nnoremap D_ :lua require'dap'.disconnect();require'dap'.stop();require'dap'.run_last()<CR>
" nnoremap DR :lua require'dap'.repl.open({}, 'vsplit')<CR><C-w>l
" nnoremap DI :lua require'dap.ui.variables'.hover()<CR>
" vnoremap DII :lua require'dap.ui.variables'.visual_hover()<CR>
" nnoremap D? :lua require'dap.ui.variables'.scopes()<CR>
" nnoremap DE :lua require'dap'.set_exception_breakpoints({"all"})<CR>
" nnoremap DA :lua require'debugHelper'.attach()<CR>
" nnoremap DA :lua require'debugHelper'.attachToRemote()<CR>
" nnoremap DI :lua require'dap.ui.widgets'.hover()<CR>
" nnoremap D? :lua local widgets=require'dap.ui.widgets';widgets.centered_float(widgets.scopes)<CR>

try
    if has("autocmd")
        " To refresh for i3 after the edition of its config file
        autocmd bufwritepost ~/.config/i3/config :silent !i3-msg restart; notify-send "Reloaded i3 :)"
    endif
catch
endtry

function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction
set statusline+=%{NearestMethodOrFunction()}

" By default vista.vim never run if you don't call it explicitly.
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc
"
try
    autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
catch
endtry

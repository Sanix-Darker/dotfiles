set runtimepath^=~/.config/nvim/ runtimepath+=~/.config/nvim/after
let &packpath=&runtimepath
source ~/.config/nvim/plugins.vim

" jk -> Esc to speed Up switching
inoremap jk <ESC>

try
	colorscheme onedark
catch
endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" For my command line to be running alias on command mode inside vim editor
let $BASH_ENV = "~/.vim_bash_env"

" To show hidden files
let NERDTreeShowHidden=1

" For the synthax
let b:ale_linters = ['flake8']
" Some fixers...
let b:ale_fixers = ['eslint']
let b:ale_fix_on_save = 1

" ------ for silicon and screenshot from the source code
" Generate an image of the current buffer and write it to /path/to/output.png
" :Silicon /path/to/output.png
" -- Generate an image of the current buffer and write it to /path/to/output.png and clipboard.
" :Silicon /path/to/output.png --to-clipboard
" -- Generate an image of the current buffer and write it to /path/to/<filename>.png
" :Silicon /path/to/
" -- Generate an image of the current visual line selection and write it to /path/to/output.png
" :'<,'>Silicon /path/to/output.png
" -- Generate an image of the current buffer, with the current visual line selection highlighted.
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

let g:lasttab = 1
au TabLeave * let g:lasttab = tabpagenr()

" Clean and erase the buffer
nnoremap cbu :%bd\|e#\|bd#<cr>

" To search in the current files
" For hidden files of fzf
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git --ignore node_modules --ignore poetry.lock --ignore yarn.lock -g ""'
" let $FZF_DEFAULT_OPTS = "--preview-window 'right:57%' --preview 'bat --style=numbers --line-range :300 {}'
" \ --bind ctrl-y:preview-up,ctrl-e:preview-down,
" \ctrl-b:preview-page-up,ctrl-f:preview-page-down,
" \ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down,
" \shift-up:preview-top,shift-down:preview-bottom,
" \alt-up:half-page-up,alt-down:half-page-down'
let $FZF_DEFAULT_OPTS="--bind \"ctrl-d:preview-down,ctrl-u:preview-up\""
" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun
autocmd BufWritePre * :call CleanExtraSpaces()

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

map <C-n> :call NERDTreeToggleAndRefresh()<CR>
function NERDTreeToggleAndRefresh()
    if g:NERDTree.IsOpen()
        :NERDTreeClose
    else
        :NERDTreeFind
    endif
endfunction

" set thosse elements depending on the filetype am inside
autocmd FileType yaml set cursorcolumn
autocmd FileType yml set cursorcolumn

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
au BufNewFile,BufRead *.rest set ft=rest

" We want everything fold depending on the synthax when we jump into it
set foldmethod=syntax
set foldnestmax=1

" Flagging Unnecessary Whitespace
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" To refresh for i3 after the edition of its config file
autocmd bufwritepost ~/.config/i3/config :silent !i3-msg restart; notify-send "Reloaded i3 :)"

function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction
set statusline+=%{NearestMethodOrFunction()}

" To format the C code
autocmd FileType c ClangFormatAutoEnable
" Clang-Formating
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11"}
" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)

" By default vista.vim never run if you don't call it explicitly.
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

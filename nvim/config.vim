set runtimepath^=~/.config/nvim/ runtimepath+=~/.config/nvim/after
let &packpath=&runtimepath
source ~/.config/nvim/plugins.vim

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
nnoremap bbb :%bd\|e#\|bd#<cr>

" To search in the current files
" For hidden files of fzf
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'

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

autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll

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
autocmd FileType yaml set cursorcolumn
autocmd FileType yml set cursorcolumn

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

autocmd VimEnter * nested if argc() == 0 && filereadable($HOME . "/.config/nvim/buflist.txt") |
    \	for line in readfile($HOME . "/.config/nvim/buflist.txt") |
    \	    if filereadable(line) |
    \		execute "tabedit " . line |
    \		set bufhidden=delete |
    \	    endif |
    \	endfor |
    \	tabclose 1 |
    \ endif

try
    " Auto generate tags file on file write of *.c and *.h files
    autocmd BufWritePost *.c,*.h silent! !ctags . &
catch
endtry

" Enable folding with the spacebar
" nnoremap <C-space> za

try
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
catch
endtry

" Format the code on save
" augroup fmt
"   autocmd!
"   autocmd BufWritePre * undojoin | Neoformat
" augroup END

" To refresh for i3 after the edition of its config file
autocmd bufwritepost ~/.config/i3/config :silent !i3-msg restart; notify-send "Reloaded i3 :)"

function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction
set statusline+=%{NearestMethodOrFunction()}

" By default vista.vim never run if you don't call it explicitly.
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc
"
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

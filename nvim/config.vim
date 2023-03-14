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

" Git Messegen colorscheme
hi gitmessengerPopupNormal term=None guifg=#eeeeee guibg=None ctermfg=255 ctermbg=None
hi gitmessengerHeader term=None guifg=#88b8f6 ctermfg=111
hi gitmessengerHash term=None guifg=#f0eaaa ctermfg=229
hi gitmessengerHistory term=None guifg=#fd8489 ctermfg=210
" to shyow diff for the current version am having
" can be current, all or None
let g:git_messenger_include_diff = 'current'
let g:git_messenger_always_into_popup = v:true
let g:git_messenger_max_popup_height = 25
let g:git_messenger_max_popup_width = 100
let g:git_messenger_extra_blame_args = ''
let g:git_messenger_floating_win_opts = { 'border': 'single' }

" Firenvim
" let g:firenvim_config = { 
"     \ 'globalSettings': {
"         \ 'alt': 'all',
"     \  },
"     \ 'localSettings': {
"         \ '.*': {
"             \ 'cmdline': 'neovim',
"             \ 'content': 'markdown',
"             \ 'priority': 0,
"             \ 'selector': 'textarea',
"             \ 'takeover': 'always',
"         \ },
"     \ }
" \ }
" function! s:IsFirenvimActive(event) abort
"   if !exists('*nvim_get_chan_info')
"     return 0
"   endif
"   let l:ui = nvim_get_chan_info(a:event.chan)
"   return has_key(l:ui, 'client') && has_key(l:ui.client, 'name') &&
"       \ l:ui.client.name =~? 'Firenvim'
" endfunction
" function! SetLinesForFirefox(timer)
"     " set lines=28 columns=70 laststatus=0
"     " exec 'resize -10'
" endfunction
" function! OnUIEnter(event) abort
"   if s:IsFirenvimActive(a:event)
"     set guifont=Hack:h14
"     call timer_start(1000, function("SetLinesForFirefox"))
"   endif
" endfunction

" " Already add the line below to the end of the file
" autocmd UIEnter * call OnUIEnter(deepcopy(v:event))


" Clean and erase the buffer
nnoremap cbu :%bd\|e#\|bd#<cr>

inoremap jk <ESC>
inoremap JK <ESC>
" vnoremap jk <ESC>

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

autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
" am getting weird warning errors when saving a tsx file, so am commenting this for now
" autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll

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
        :NERDTreeClose
    else
        :NERDTreeFind
    endif
endfunction

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
" Use K to show documentation in preview window.
nnoremap <silent> KKK :call <SID>show_documentation()<CR>

" set thosse elements depending on the filetype am inside
autocmd FileType yaml set cursorcolumn
autocmd FileType yml set cursorcolumn

" Open last active file(s) if VIM is invoked without arguments.
" autocmd VimLeave * nested let buffernr = bufnr("$") |
"     \ let buflist = [] |
"     \ while buffernr > 0 |
"     \	if buflisted(buffernr) |
"     \	    let buflist += [ bufname(buffernr) ] |
"     \	endif |
"     \   let buffernr -= 1 |
"     \ endwhile |
"     \ if (!isdirectory($HOME . "/.config/nvim")) |
"     \	call mkdir($HOME . "/.config/nvim") |
"     \ endif |
"     \ call writefile(reverse(buflist), $HOME . "/.config/nvim/buflist.txt")

" autocmd VimEnter * nested if argc() == 0 && filereadable($HOME . "/.config/nvim/buflist.txt") |
"     \	for line in readfile($HOME . "/.config/nvim/buflist.txt") |
"     \	    if filereadable(line) |
"     \		execute "tabedit " . line |
"     \		set bufhidden=delete |
"     \	    endif |
"     \	endfor |
"     \	tabclose 1 |
"     \ endif

" i want to disable capsLock when am leaving the insert mode
" because my keyboard doesn't help me knowing when the capsLock
" is on or not
function TurnOffCaps()  
    let capsState = matchstr(system('xset -q'), '00: Caps Lock:\s\+\zs\(on\|off\)\ze')
    if capsState == 'on'
        silent! execute ':!xdotool key Caps_Lock'
    endif
endfunction
au InsertLeave * call TurnOffCaps()

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
catch
endtry

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

set runtimepath^=~/.config/nvim/ runtimepath+=~/.config/nvim/after
let &packpath=&runtimepath
source ~/.config/nvim/plugins.vim

" Vundle Plugins
filetype off                  " required
" To have as default delimiter for the csv , and |
" let g:csv_delim_test = ',;|'
" All of your Plugins must be added before the following line
filetype plugin indent on    " required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Enable filetype plugins
filetype plugin on
filetype indent on

" For the autocompletion
set omnifunc=syntaxcomplete#Complete
" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" => VIM user interface
set nocompatible              " be iMproved, required
" Sets how many lines of history VIM has to remember
set history=300
set nowrap
set colorcolumn=1000
set relativenumber
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7
" Avoid garbled characters in Chinese language windows OS
" let en_US.UTF-8='en'
set langmenu=en
" Turn on the Wild menu
set wildmenu
" Ignore compiled files
set wildignore=*.o,*~,*.pyc
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
"Always show current position
set ruler
" Height of the command bar
set cmdheight=1
" A buffer becomes hidden when it is abandoned
set hid
" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" Ignore case when searching
set ignorecase
" When searching try to be smart about cases
set smartcase
" No Highlight search results
set hlsearch
" Don't redraw while executing macros (good performance config)
set lazyredraw
" For regular expressions turn magic on
set magic
" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2
" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
" Add a bit extra margin to the left
set foldcolumn=1
" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8
" Use Unix as the standard file type
set ffs=unix,dos,mac
" To keep the cursor on block
set guicursor=i:block
" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile
" Enable syntax highlighting
syntax enable
" Synthaxic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" Use spaces instead of tabs
set expandtab
" Be smart when using tabs ;)
set smarttab
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
" Linebreak on 500 characters
set lbr
set tw=500
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines
" Status line
" Always show the status line
set laststatus=3
" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
" set mouse= to disable the mouse
set mouse=a
" Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.config/nvim/undo
set winbar=%=%m\ %f
" for the tagbar refresh time
set updatetime=1
" To keep the statusline only global not per file
" set laststatus=3
" Fort the splitTerm plugin
set splitbelow
" to set the number
set number

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

" To activate emmet for html and css | since LSP html is already handled
" let g:user_emmet_mode='a'
" let g:user_emmet_install_global = 0
" autocmd FileType html,css EmmetInstall
" <<<

" To jump into a next error
" try
"     nmap <silent> [c :call CocAction('diagnosticNext')<cr>
"     nmap <silent> ]c :call CocAction('diagnosticPrevious')<cr>
" catch
" endtry

nnoremap <leader>f <Esc>:cd %:p:h<CR><Esc>:Ag<CR>
" For commentary on multilines
" noremap <leader>/ Commentary<cr>

" For the column scheme
try
    colorscheme onedark
    syntax on
catch
endtry

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
" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

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

" nvim $(git diff --name-only origin | fzf +m)

" To search for ctags
nnoremap bg :Vista finder ctags<CR>
" To undo a git hunk change
nnoremap ZX :GitGutterUndoHunk<CR>

" To format the code
nnoremap fv :Neoformat<CR>

" To jump fastly on a word
nnoremap jj :HopWord<CR>

" To search in the current files
" Most efficient than the ? or /
nnoremap ll :Lines<CR>
" For hidden files of fzf
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
" For the file search
nnoremap ff :FZF<cr>
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
nnoremap hh :GitGutterFold<CR>:GitGutterLineHighlightsToggle<CR>
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
" nnoremap so :so $MYVIMRC<CR>

" To clean the search hightlights
nnoremap no :nohlsearch<CR>

" To paste multiple times the same 
" stuff or use P for the default behaviour
xnoremap p pgvy

" To Ctrl-BackSpace delete a whole previous word
xnoremap <C-H> dvbh
nnoremap <C-H> dvbh
" nnoremap D <S-v>d
" nnoremap Y yy

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

" For tagBar jumping
" nnoremap >> :TagbarJumpNext<CR>
" nnoremap << :TagbarJumpPrev<CR>

" # For the fzf preview
" let g:fzf_preview_window = ['right:50%', 'ctrl-/']
" " Preview window on the upper side of the window with 40% height,
" " hidden by default, ctrl-/ to toggle
" let g:fzf_preview_window = ['up:40%:hidden', 'ctrl-/']
" " Empty value to disable preview window altogether
" let g:fzf_preview_window = []

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

" Shortcuts using <leader>
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
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

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

" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
" if has('nvim')
"   inoremap <silent><expr> <c-space> coc#refresh()
" else
"   inoremap <silent><expr> <c-@> coc#refresh()
" endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
""                              \: \<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" inoremap <expr> <cr> pumvisible() ? \"\<C-y>" : \"\<C-g>u\<CR>"
" inoremap <silent><expr> <cr> \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
" nmap <silent> [g <Plug>(coc-diagnostic-prev)
" nmap <silent> ]g <Plug>(coc-diagnostic-next)

" " Remap keys for applying codeAction to the current line.
" nmap <leader>ac  <Plug>(coc-codeaction)
" " Apply AutoFix to problem on the current line.
" nmap <leader>qf  <Plug>(coc-fix-current)

" GoTo code navigation.
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" inoremap <silent><expr> <down> coc#pum#visible() ? coc#pum#next(1) : \"\<down>"
" inoremap <silent><expr> <up> coc#pum#visible() ? coc#pum#prev(1) : \"\<up>"
" inoremap <silent><expr> <PageDown> coc#pum#visible() ? coc#pum#scroll(1) :\"\<PageDown>"
" inoremap <silent><expr> <PageUp> coc#pum#visible() ? coc#pum#scroll(0) : \"\<PageUp>"
" >>>
" inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : \"\<CR>"
" inoremap <silent><expr> <tab> coc#pum#visible() ? coc#pum#confirm() : \"\<tab>"

" For the synthax
let b:ale_linters = ['flake8']
" Some fixers...
let b:ale_fixers = ['eslint']
let b:ale_fix_on_save = 1

" Use K to show documentation in preview window.
nnoremap <silent> KKK :call <SID>show_documentation()<CR>

" nnoremap <C-[> <Esc><CR>

" To change rom horizontals to vertical views
" nnoremap <C-H> :windo wincmd H<CR>

" Use deoplete.
" let g:deoplete#enable_at_startup = 1

" Use the Ctrl
" nnoremap <Up>  <C-w>-
" nnoremap <Down>  <C-w>+
" nnoremap <Left>  <C-w> h
" nnoremap <Right> <C-w> l

" function! s:SID()
"     if ! exists('s:sid')
"         let s:sid = matchstr(expand('<sfile>'), '<SNR>\zs\d\+\ze_SID$')
"     endif
"     return s:sid
" endfunction
" let s:SNR = '<SNR>'.s:SID().'_'

" autocmd VimEnter * call NERDTreeAddKeyMap({
"      \ 'key': 'w',
"      \ 'callback': s:SNR.'toggle_width',
"     \ 'quickhelpText': 'Toggle window width' })
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

" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   elseif (coc#rpc#ready())
"     call CocActionAsync('doHover')
"   else
"     execute '!' . &keywordprg . \" " . expand('<cword>')
"   endif
" endfunction

" set thosse elements depending on the filetype am inside
if has("autocmd")
    autocmd FileType yaml set cursorcolumn
    autocmd FileType yml set cursorcolumn
endif

" if has("autocmd")
"     " Highlight the symbol and its references when holding the cursor.
"     autocmd CursorHold * silent call CocActionAsync('highlight')
" endif

" Symbol renaming.
" nmap <leader>rn <Plug>(coc-rename)
" Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

" if has("autocmd")
"     augroup mygroup
"       autocmd!
"       " Setup formatexpr specified filetype(s).
"       autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"       " Update signature help on jump placeholder.
"       autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"     augroup end
" endif

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" " Remap keys for applying codeAction to the current buffer.
" nmap <leader>ac  <Plug>(coc-codeaction)
" " Apply AutoFix to problem on the current line.
" nmap <leader>qf  <Plug>(coc-fix-current)

" " Map function and class text objects
" " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
" xmap if <Plug>(coc-funcobj-i)
" omap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap af <Plug>(coc-funcobj-a)
" xmap ic <Plug>(coc-classobj-i)
" omap ic <Plug>(coc-classobj-i)
" xmap ac <Plug>(coc-classobj-a)
" omap ac <Plug>(coc-classobj-a)

" " Remap <C-f> and <C-b> for scroll float windows/popups.
" if has('nvim-0.4.0') || has('patch-8.2.0750')
"   nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : \"\<C-f>"
"   nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : \"\<C-b>"
"   inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? \"\<c-r>=coc#float#scroll(1)\<cr>" : \"\<Right>"
"   inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? \"\<c-r>=coc#float#scroll(0)\<cr>" : \"\<Left>"
"   vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : \"\<C-f>"
"   vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : \"\<C-b>"
" endif

" " Use CTRL-S for selections ranges.
" " Requires 'textDocument/selectionRange' support of language server.
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)

" " Add `:Format` command to format current buffer.
" command! -nargs=0 Format :call CocAction('format')

" " Add `:Fold` command to fold current buffer.
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" " Add `:OR` command for organize imports of the current buffer.
" command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" " Add (Neo)Vim's native statusline support.
" " NOTE: Please see `:h coc-status` for integrations with external plugins that
" " provide custom statusline: lightline.vim, vim-airline.
" " set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" " Mappings for CoCList
" " Show all diagnostics.
" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions.
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" " Show commands.
" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document.
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols.
" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

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
    endif
catch
endtry

" let g:coc_disable_startup_warning = 1

try
    " Auto generate tags file on file write of *.c and *.h files
    autocmd BufWritePost *.c,*.h silent! !ctags . &
catch
endtry

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" For simplyfolding
let g:SimpylFold_docstring_preview=1
" python hightlights
let python_highlight_all=1

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

        " \" \" all other js html
        " au BufNewFile,BufRead *.js, *.html, *.css,*.vue
        "     \ set tabstop=2 |
        "     \ set softtabstop=2 |
        "     \ set shiftwidth=2

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
" to fix the pymode error for python
" let g:pymode_python = 'python3'

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
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
" How each level is indented and what to prepend.
" This could make the display more compact or more spacious.
" e.g., more compact: ["▸ ", ""]
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

" Don't ask me why but i had to do this to disable synthx toggling forward and backward like an idiot
nnoremap <CR> <cr>

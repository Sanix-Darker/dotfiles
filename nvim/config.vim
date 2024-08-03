" --------------------- NERDTREE stuff
" To show hidden files
let NERDTreeShowHidden=1

" To show the NerdTree on the right side
let g:NERDTreeWinPos = "right"
map <C-n> :call NERDTreeToggleAndRefresh()<CR>
function NERDTreeToggleAndRefresh()
    if g:NERDTree.IsOpen()
        :NERDTreeClose
    else
        :NERDTreeFind
    endif
endfunction
" Always show NERDTree on opening a new buffer
" au BufEnter * NERDTreeMirror
" au BufEnter * NERDTreeFind

" Close Vim if NERDTree is the last window
au bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" --------------------- NERDTREE stuff

" On save on a php file extension, i want to call this auto fixer :
" Define the PhpCsFixerFixFile function
function PhpCsFixerFixFile()
  silent !php-cs-fixer fix %
  "  Redraw the screen to avoid any Press ENTER prompt
  redraw!
endfunction
" Auto call PhpCsFixerFixFile on save for PHP files
" autocmd BufWritePost *.php call PhpCsFixerFixFile()
" Define a custom command to call PhpCsFixerFixFile
command! PhpCsFixer call PhpCsFixerFixFile()

" On save of the i3 config file, i want to notify at os level that was done.
" Auto command to restart i3 and send a notification on save of i3 config file
autocmd BufWritePost ~/.config/i3/config silent !i3-msg restart | execute 'silent !notify-send "Reloaded i3 :)"'

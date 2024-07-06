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

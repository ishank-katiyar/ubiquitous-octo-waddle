autocmd filetype python nnoremap <F8> :w <bar> :!python3 %<CR>
autocmd filetype python command! R execute ":w <bar> !python3 %" 
autocmd filetype python setlocal expandtab shiftwidth=4 tabstop=4

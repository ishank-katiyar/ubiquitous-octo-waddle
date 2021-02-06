autocmd filetype sh setlocal shiftwidth=4 tabstop=4 fileformat=unix
autocmd filetype sh nnoremap <F8> :w <bar> :!bash %<CR>
autocmd filetype sh command! R execute ":w <bar> !bash %" 

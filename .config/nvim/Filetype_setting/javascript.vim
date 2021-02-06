autocmd filetype javascript nnoremap <F8> :w <bar> :!node %<CR>
autocmd filetype javascript command! R execute ":w <bar> !node %" 
autocmd filetype javascript setlocal expandtab shiftwidth=4 tabstop=4

autocmd filetype cpp setlocal expandtab shiftwidth=1 tabstop=1

" {{{
" autocmd filetype cpp nnoremap <F8> :w <bar> !c1 % -o %:r<CR>
" autocmd filetype cpp nnoremap <F9> :w <bar> !c2 % -o %:r<CR>
" autocmd filetype cpp nnoremap <F6> :w <bar> !c3 % -o %:r<CR>
" autocmd filetype cpp nnoremap <F7> :w <bar> !c4 % -o %:r<CR>
" autocmd filetype cpp command! C1 execute ":w <bar> !c1 % -o %:r"
" autocmd filetype cpp command! C2 execute ":w <bar> !c2 % -o %:r"
" autocmd filetype cpp command! C3 execute ":w <bar> !c3 % -o %:r"
" autocmd filetype cpp command! C4 execute ":w <bar> !c4 % -o %:r"
" }}}

autocmd filetype cpp nnoremap <F8> :call COMPILE(1)<CR>
autocmd filetype cpp nnoremap <F9> :call COMPILE(2)<CR>
autocmd filetype cpp nnoremap <F6> :call COMPILE(3)<CR>
autocmd filetype cpp nnoremap <F7> :call COMPILE(4)<CR>
autocmd filetype cpp command! C1 :call COMPILE(1)
autocmd filetype cpp command! C2 :call COMPILE(2)
autocmd filetype cpp command! C3 :call COMPILE(3)
autocmd filetype cpp command! C4 :call COMPILE(4)
autocmd filetype cpp nnoremap <F10> :call RUNSAMPLE()<CR>
autocmd filetype cpp command! RA :call RUNSAMPLE()

function COMPILE(COMPILE_FLAG_NUMBER)
    execute ":w"
    let filename = expand('%:p')
    let filenameWithoutExtension = expand('%:t:r')
    " echo filename 
    " echo filenameWithoutExtension
    " echo a:COMPILE_FLAG_NUMBER
    execute ":10Term c" . a:COMPILE_FLAG_NUMBER . " " . filename . " -o" . filenameWithoutExtension
endfunction

function RUNSAMPLE() 
    let cnt = system ("find . -type f -name 'runsample.py' | wc -l")
    " echo cnt
    if cnt == 0
        silent call system ("cp /home/ishank/.config/nvim/Competitve_programming_helper/runsample.py .")
    endif
    let filename = expand ('%:p')
    " echo filename
    " call system ("VTerm python3 runsample.py --f " . filename) 
    execute ":VTerm python3 runsample.py --f " . filename
endfunction

" {{{
" highlight correct_ans guifg=#00ff00 guibg=None
" highlight wrong_ans guifg=#00ff00 guibg=None
" }}}

" previous setting {{{
" let INPUT = []
" let OUTPUT = []
" let V = 1
" let filled = 0
" 
" function Convert_to_string(list)
"     let result = ""
"     for i in a:list
"         let result .= ' ' . i
"     endfor
"     return result
" endfunction
" 
" function Convert_to_string1(list)
"     let result = ' "'
"     for i in a:list
"         let result .= i . '\'
"         let result .= 'n'
"     endfor
"     let result .= '"'
"     return result
" endfunction
" 
" function FILL_INPUT_OUTPUT()
"     let g:INPUT = []
"     let g:OUTPUT = []
"     let total_len = system ("jq '.tests|length' DATA_JSON.json")
"     " echo "total_len " . total_len
"     for i in range(0, total_len - 1)
"         call add (g:INPUT, Convert_to_string(systemlist("jq '.tests[" . i . "].input' DATA_JSON.json")))
"         call add (g:OUTPUT, Convert_to_string(systemlist("jq '.tests[" . i . "].output' DATA_JSON.json")))
"     endfor
"     let g:filled = 1
"     " echo g:INPUT
"     " echo g:OUTPUT
" endfunction
" 
" function RUN1(TESTCASE_NUMBER)
"     let str = "echo " . g:INPUT[a:TESTCASE_NUMBER - 1] . " | ./" . expand('%:r') 
"     echo system (str)
"     if g:V == 1
"         " {{{
"         " let out_file = "out_file" . a:TESTCASE_NUMBER
"         " call system ("echo " . g:INPUT[a:TESTCASE_NUMBER - 1] . " | ./" . expand('%:r') . " > " . out_file)
"         " let x = Convert_to_string1(systemlist ("cat " . out_file))
"         " echo x
"         " echo g:OUTPUT[a:TESTCASE_NUMBER - 1]
"         " if x == g:OUTPUT[a:TESTCASE_NUMBER - 1]
"         "     echo "  Test Passed!"
"         " else 
"         "     echo "  Test failed!"
"         " endif
"         " call system ("rm " . out_file)
"         " }}}
"         let out_file = "out_file" . a:TESTCASE_NUMBER
"         call system ("echo " . g:INPUT[a:TESTCASE_NUMBER - 1] . " | ./" . expand('%:r') . " > " . out_file)
"         let expe_file = "expe_file" . a:TESTCASE_NUMBER
"         call system ("echo " . g:OUTPUT[a:TESTCASE_NUMBER - 1] . " | cat > " . expe_file)
"         " echo "files:\n"
"         " echo system ("cat " . out_file)
"         " echo "files:\n"
"         " echo system ("cat " . expe_file)
"         call system ("diff -B -Z " . out_file . " " . expe_file)
"         if v:shell_error == 0
"             echohl CocListFgGreen
"             echo "  Test Passed!"
"             echohl None
"         else
"             echohl CocListFgRed
"             echo "  Test failed!"
"             echohl None
"         endif
"         call system ("rm " . out_file . " " . expe_file)
"     endif
" endfunction
" 
" function RUN2(TESTCASE_NUMBER)
"     let cnt = system ('find . -type f -name "IN' . a:TESTCASE_NUMBER . '" | wc -l')
"     if cnt == 0
"         echo " Test case " . a:TESTCASE_NUMBER . " not found!"
"         return
"     endif
"     let str = "./" . expand('%:r') . " < IN" . a:TESTCASE_NUMBER
"     echo system (str)
" endfunction
" 
" function RUN(TESTCASE_NUMBER)
"     if g:filled == 0
"         call FILL_INPUT_OUTPUT()
"     endif
"     echo "Output_" . a:TESTCASE_NUMBER . ":"
"     let LEN = len(g:INPUT)
"     if a:TESTCASE_NUMBER <= LEN
"         call RUN1(a:TESTCASE_NUMBER)
"     else 
"         call RUN2(a:TESTCASE_NUMBER)
"     endif
" endfunction
" 
" function RUN_ALL()
"     if g:filled == 0
"         call FILL_INPUT_OUTPUT()
"     endif
"     let total = len(g:INPUT)
"     " echo "total " . total
"     let rest = system ('find . -type f -name "IN*" | wc -l')
"     let rest -= system ('find . -type f -name "INT" | wc -l')
"     " echo "rest " . rest
"     let total += rest
"     if total == 0
"         echo "No test cases found!"
"         return
"     endif
"     " echo total
"     for i in range (1, total)
"         call RUN (i)
"     endfor
" endfunction
" 
" function GET_INPUT()
"     try
"         execute "!cd /home/ishank/Documents/CP/Extra/xyz/competitive-companion-example/ && npm start"
"     finally 
"         " execute "!echo ok"
"         execute "!mv /home/ishank/Documents/CP/Extra/xyz/competitive-companion-example/DATA_JSON.json ."
"         " sleep 5
"         call FILL_INPUT_OUTPUT()
"     endtry
" endfunction
" 
" autocmd filetype cpp command! GET :call GET_INPUT()
" autocmd filetype cpp command! RR :call FILL_INPUT_OUTPUT()
" autocmd filetype cpp nnoremap <F10> :call RUN_ALL()<CR>
" autocmd filetype cpp command! RA :call RUN_ALL()
" autocmd filetype cpp command! R execute "!./%:r" 
" autocmd filetype cpp command! R1 call RUN(1)
" autocmd filetype cpp command! R2 call RUN(2)
" autocmd filetype cpp command! R3 call RUN(3)
" autocmd filetype cpp command! R4 call RUN(4)
" autocmd filetype cpp command! R5 call RUN(5)
" autocmd filetype cpp command! R6 call RUN(6)
" autocmd filetype cpp command! R7 call RUN(7)
" 
" function START()
"     let g:filled = 0
"     let g:V = 1
" endfunction
" 
" function! END()
"     unlet INPUT
"     unlet OUTPUT
"     unlet V
"     unlet filled
" endfunction
" 
" augroup myBufferEnter
"     autocmd BufEnter *.cpp :call START()
" augroup END
" 
" augroup myBufferLeave
"     autocmd BufLeave *.cpp silent! :call END()
" augroup END
" }}}

" {{{
" function A(start, ...)
"     echohl Title
"         echo "start is " . a:start
"     echohl None
"     let index = 1
"     while index <= a:0
"         echo "  Arg " . index . " is " . a:{index}
"         let index = index + 1
"     endwhile
"     echo ""
" endfunction
" }}}

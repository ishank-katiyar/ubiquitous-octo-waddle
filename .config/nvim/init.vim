call plug#begin()

Plug 'preservim/nerdtree'

Plug 'ryanoasis/vim-devicons'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'ap/vim-css-color'

Plug 'preservim/nerdcommenter'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'vimlab/split-term.vim'

Plug 'rafi/awesome-vim-colorschemes'

" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'npm install --frozen-lockfile'}

Plug 'jackguo380/vim-lsp-cxx-highlight'

Plug 'dense-analysis/ale'

Plug 'luochen1990/rainbow'

Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'

Plug 'alvan/vim-closetag'

Plug 'jiangmiao/auto-pairs'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'MaxMEllon/vim-jsx-pretty'

call plug#end()


" auto-close-tag setting {{{
let g:closetag_filenames = '*.html,*.xhtml,*.phtml, *.js'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'html,xhtml,phtml'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
let g:closetag_xhtml_filetypes = 'xhtml,jsx'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
"
let g:closetag_regions = {
    \ 'typescript.tsx': 'jsxRegion,tsxRegion',
    \ 'javascript.jsx': 'jsxRegion',
    \ }

" Shortcut for closing tags, default is '>'
"
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
"
let g:closetag_close_shortcut = '<leader>>'
" }}}


" react plugin setting {{{
let g:vim_jsx_pretty_colorful_config = 1
" }}}


" ALE setting {{{
let b:ale_linters = ['cpplint', 'langserver', 'phan', 'php', 'phpcs', 'phpmd', 'phpstan', 'psalm', 'bandit', 'flake8', 'jedils', 'mypy', 'prospector', 'pycodestyle', 'pydocstyle', 'pyflakes', 'pylama', 'pylint', 'pyls', 'pyre', 'pyright', 'vulture']
" let g:ale_php_langserver_use_global = 1
" let g:ale_php_langserver_executable = '/home/ishank/Documents/CP/Codechef/Random/Intership/Round_2/src/vendor/bin/php-language-server.php'
let g:ale_linters_explicit = 1
" let g:ale_fixers = {'php': ['php_cs_fixer', 'phpcbf']}
let g:airline#extensions#ale#enabled = 1
" }}}


" Rainbow setting {{{
let g:rainbow_active = 1
" }}}


"NerdCommenter {{{
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
"}}}


"NerdTree {{{
" NERDTress File highlighting
map <leader>z :NERDTreeToggle<CR>

function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

" call NERDTreeHighlightFile('cpp', 'green', 'none', 'green', '#151515')
" call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
" call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
" call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
" call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
" call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
" call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
"}}}


"COC setting {{{
" if executable('intelephense')
"   augroup LspPHPIntelephense
"     au!
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'intelephense',
"         \ 'cmd': {server_info->[&shell, &shellcmdflag, 'intelephense --stdio']},
"         \ 'whitelist': ['php'],
"         \ 'initialization_options': {'storagePath': '/tmp/intelephense'},
"         \ 'workspace_config': {
"         \   'intelephense': {
"         \     'files': {
"         \       'maxSize': 1000000,
"         \       'associations': ['*.php', '*.phtml'],
"         \       'exclude': [],
"         \     },
"         \     'completion': {
"         \       'insertUseDeclaration': v:true,
"         \       'fullyQualifyGlobalConstantsAndFunctions': v:false,
"         \       'triggerParameterHints': v:true,
"         \       'maxItems': 100,
"         \     },
"         \     'format': {
"         \       'enable': v:true
"         \     },
"         \   },
"         \ }
"         \})
"   augroup END
" endif
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
"}}}


" Airline settings {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'
"}}}


"Cpp syntax highlighting {{{
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
"}}}


"Syntastic setting {{{
" let g:syntastic_cpp_checkers = ['cpplint']
" let g:syntastic_c_checkers = ['cpplint']
" let g:syntastic_cpp_cpplint_exec = 'cpplint'
" The following two lines are optional. Configure it to your liking!
" let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"}}}


"Toggling comment {{{
map ,, :call NERDComment(0, "toggle")<CR>
"}}}


"YCM settings {{{
"let g:ycm_key_list_select_completion=[]
"let g:ycm_key_list_previous_completion=[]
"let g:ycm_global_ycm_extra_conf = "~/.config/nvim/plugged/YouCompleteMe/.ycm_c-c++_conf.py"
"let g:ycm_global_ycm_extra_conf = "~/.config/nvim/plugged/YouCompleteMe/.ycm_extra_conf.py"
"let g:ycm_filetype_blacklist = { 'cpp': 1 }
"}}}


"Basic Settings {{{
"set nocompatible
set updatetime=100
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set smarttab
set number relativenumber
set noswapfile
set wrap!
set mouse=a
set clipboard=unnamedplus
set shellcmdflag=-ic
set shell=/bin/bash
set ignorecase
set termguicolors
set cursorline 
" set cursorcolumn
set splitbelow splitright
set wildmode=longest,list,full
set nostartofline
set encoding=utf-8
set autoread 
" set hidden
" set filetype on
"}}}


"Folding method {{{
" set foldmethod=marker
" set foldcolumn=2
set foldmethod=indent
set foldnestmax=3
set nofoldenable
"}}}


"Set colorscheme {{{
" colorscheme gruvbox
" colorscheme onedark
colorscheme solarized8
" }}}

" Importing aliases from ~/.bash_aliases file {{{
let $BASH_ENV = "~/.bash_aliases"
"}}}


"Indentation in Visual Mode {{{
vmap < <gv
vmap > >gv
"}}}


"Moving between Buffers and splits {{{
nnoremap <A-l> :bn<CR>
nnoremap <A-h> :bp<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
"}}}


" Terminal Mode Setting {{{
tnoremap <ESC> <C-\><C-N>
"}}}


"Cursor settings {{{
au InsertEnter * set guicursor=a:hor20-Cursor
au InsertLeave * set guicursor& 
"}}}


"Opening terminal {{{
nnoremap <F5> :!alacritty&<CR><CR>
"}}}


source /home/ishank/.config/nvim/Filetype_setting/cpp.vim
source /home/ishank/.config/nvim/Filetype_setting/javascript.vim
source /home/ishank/.config/nvim/Filetype_setting/python3.vim
source /home/ishank/.config/nvim/Filetype_setting/bash.vim
source /home/ishank/.config/nvim/Filetype_setting/css.vim

" Experiement {{{
autocmd BufWritePre *.js Format
" autocmd VimEnter * NERDTreeToggle
" nnoremap <Esc> :w<Esc>
" nnoremap <tab> <C-i>
" }}}
" hi Normal guibg=NONE ctermbg=NONE
au BufNewFile,BufRead /*.rasi setf css

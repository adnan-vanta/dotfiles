syntax on
filetype plugin indent on

" Use new regular expression engine
set re=0

set nu
set relativenumber
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
set autoindent
set ruler

" Keep persistent undo history
set undofile

" Keep temp files outside of workspace
set directory=~/.vim/_tmp
set backupdir=~/.vim/backup
set undodir=~/.vim/_tmp

" Display the status line always
set laststatus=2

" Below two options pertain to tab-completion in command line
set wildmenu
set wildmode=full

" No need to redraw during macro iterations
set lazyredraw

" Help with identifying cursor location
set cursorline

" Keep windows a minimum size; Keep selected window a (greater) minimum size
set winminwidth=20
set winwidth=120

" Lightly enforce max 80 chars per line
set colorcolumn=80

" allow tmux to send scroll event to vim?
set mouse=a

" smooth scroll
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 5, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 5, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 5, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 5, 4)<CR>

" Sometimes syntax highlighting can get out of sync in large JSX and TSX files.
" Forces vim to rescan the entire buffer when highlighting
" autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
" autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" Jenkinsfile syntax highlighting
au BufNewFile,BufRead Jenkinsfile setf groovy

" ctrlP
set wildignore+=*/tmp/*,*.so,*.swp,*.zip " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
let g:ctrlp_use_caching = 0

" prettier on-save
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

" nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

" From coc.vim
" Give more space for displaying messages.
set cmdheight=2

" From coc.vim
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" From coc.vim
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" From coc.vim
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" From coc.vim
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" From coc.vim
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" From coc.vim
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" From coc.vim
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" From coc.vim
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" From coc.vim
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'dense-analysis/ale'
Plug 'preservim/nerdcommenter'
Plug 'neoclide/coc.nvim' , { 'branch' : 'release' }
Plug 'jremmen/vim-ripgrep'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'terryma/vim-smooth-scroll'
" Initialize plugin system
call plug#end()

" Remap leader key
let mapleader='-'
let maplocalleader='\\'

" Custom mappings
inoremap jk <esc>
nnoremap <leader>q :q<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>t :NERDTree<cr>
nnoremap <leader>f :NERDTreeFind<cr>
nnoremap <leader>p :set paste!<cr>
nnoremap <leader><space> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
nnoremap <leader>ev :vsp $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>r :tabn<cr>
nnoremap <leader>R :tabp<cr>
nnoremap <leader>> 20<C-w>><cr>
nnoremap <leader>< 20<C-w><<cr>
nnoremap <leader>d <C-d>
nnoremap <leader>u <C-u>
nnoremap / /\c
nnoremap <silent> <leader>cp :let @+ = expand("%")<CR>
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
vnoremap <C-g> "hy:Rg <C-r>h

let g:sierra_Sunset = 1
colorscheme sierra
" make bg transparent
hi Normal guibg=NONE ctermbg=NONE


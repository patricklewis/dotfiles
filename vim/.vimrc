set nocompatible                " choose no compatibility with legacy vi
set number                      " display line numbers
set ttyfast                     " optimize for fast terminal connections
set hidden                      " hide closed buffers instead of abandoning them

"" netrw
let g:netrw_liststyle = 3

"" Whitespace
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)

"" Searching
set hlsearch                    " highlight matches
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

"" Folding
set foldmethod=syntax
set foldlevelstart=99

"set wildignore+=*/vendor/*
"set wildignore+=*/tmp/*
"set wildignore+=*/cache*

call plug#begin()

Plug 'airblade/vim-gitgutter'
Plug 'benmills/vimux'
Plug 'dyng/ctrlsf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'edkolev/tmuxline.vim'
Plug 'ervandew/supertab'
"Plug 'godlygeek/tabular'
"Plug 'honza/vim-snippets'
Plug 'janko-m/vim-test'
Plug 'jparise/vim-graphql'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim'
"Plug 'junegunn/rainbow_parentheses.vim'
Plug 'justinmk/vim-sneak'
"Plug 'kien/tabman.vim'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'mbbill/undotree'
Plug 'mhinz/vim-grepper'
Plug 'michaeljsmith/vim-indent-object'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-notes'

"" Language-specific Plugs
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'

"" Colorschemes
Plug 'dracula/vim', { 'as': 'dracula' }

call plug#end()

"" Colorscheme
set background=dark
colorscheme dracula

"" Truecolor
if has('termguicolors')
  set termguicolors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

"" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme='dracula'
let g:airline#extensions#tabline#enabled = 1

"" Undotree
map <silent> <Leader>u :UndotreeToggle<CR>

"" Fugitive
map <Leader>gc :Gcommit<CR>
map <Leader>gd :Git diff --cached<CR>
map <Leader>gs :Gstatus<CR>

"" FZF
map <silent> <Leader>ff :FZF<CR>
map <silent> <Leader>fb :Buffers<CR>
map <silent> <Leader>fh :History<CR>
map <silent> <Leader>f: :History:<CR>
map <silent> <Leader>fl :Lines<CR>
map <silent> <Leader>fL :BLines<CR>
map <silent> <Leader>ft :Tags<CR>
map <silent> <Leader>fT :BTags<CR>
map <silent> <Leader>fw :Windows<CR>

"" NERDTree
map <Leader>t :NERDTreeToggle<CR>

"" Tagbar
map <Leader>T :TagbarToggle<CR>

"" Copy to OS X clipboard
set clipboard=unnamed

"" vim-better-whitespace
let g:better_whitespace_filetypes_blacklist=['ctrlsf', 'diff', 'gitcommit', 'unite', 'qf', 'help']

"" vim-test
let g:test#strategy = 'vimux'
nmap <silent> <leader>rn :TestFile --next-failure<CR>
nmap <silent> <leader>ro :TestFile --only-failures<CR>
nmap <silent> <leader>rt :TestFile<CR>
nmap <silent> <leader>rT :TestNearest<CR>

"" vim-grepper
let g:grepper = { 'tools': ['rg', 'git'] }
nnoremap <leader>git :Grepper -tool git<CR>
nnoremap <leader>rg :Grepper -tool rg<CR>

"" ctrlsf.vim
let g:ctrlsf_indent = 2
let g:ctrlsf_populate_qflist = 1
nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

"" Vimux mappings
let g:VimuxHeight = 40

" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>

" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>

" Inspect runner pane
map <Leader>vi :VimuxInspectRunner<CR>

" Close vim tmux runner opened by VimuxRunCommand
map <Leader>vq :VimuxCloseRunner<CR>

" Interrupt any command running in the runner pane
map <Leader>vx :VimuxInterruptRunner<CR>

" Fix ctrl-k conflict with ultisnips
inoremap <c-x><c-k> <c-x><c-k>

" Supertab
let g:SuperTabDefaultCompletionType = "context"

autocmd FileType *
  \ if &omnifunc != '' |
  \   call SuperTabChain(&omnifunc, "<c-p>") |
  \ endif

" Asynchronous Lint Engine
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
hi ALEWarning cterm=underline

" Improve performance with vim-vue
let g:vue_disable_pre_processors=1

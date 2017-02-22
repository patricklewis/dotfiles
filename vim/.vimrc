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
Plug 'easymotion/vim-easymotion'
Plug 'ervandew/supertab'
"Plug 'godlygeek/tabular'
"Plug 'honza/vim-snippets'
"Plug 'jgdavey/vim-turbux'
Plug 'janko-m/vim-test'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim'
"Plug 'junegunn/rainbow_parentheses.vim'
"Plug 'kien/tabman.vim'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree'
"Plug 'mhinz/vim-signify'
Plug 'mhinz/vim-grepper'
Plug 'michaeljsmith/vim-indent-object'
Plug 'ntpeters/vim-better-whitespace'
Plug 'rstacruz/sparkup'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'

"" Language-specific Plugs
Plug 'cakebaker/scss-syntax.vim'
Plug 'hail2u/vim-css3-syntax'
Plug 'hdima/python-syntax'
Plug 'juvenn/mustache.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'othree/html5.vim'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'plasticboy/vim-markdown'
Plug 'slim-template/vim-slim'
Plug 'sunaku/vim-ruby-minitest'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'

"" Colorschemes
Plug 'chriskempson/base16-vim'

call plug#end()

"" Colorscheme
set background=dark
colorscheme base16-monokai

"" Truecolor
if has('termguicolors')
  set termguicolors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

"" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme='base16'
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

"" Fix terminal timeout when pressing escape
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

"NeoVim handles ESC keys as alt+key, set this to solve the problem
if has('nvim')
   set ttimeout
   set ttimeoutlen=0
end

"" Turbux
"let g:turbux_command_prefix = 'bundle exec'
"let g:no_turbux_mappings = 1
"map <leader>rt <Plug>SendTestToTmux
"map <leader>rT <Plug>SendFocusedTestToTmux

"" Neoterm
"map <leader>rt :call neoterm#test#run('file')<CR>
"map <leader>rT :call neoterm#test#run('current')<CR>
"let g:neoterm_raise_when_tests_fail = 1

"" vim-test
let test#strategy = 'vimux'
nmap <silent> <leader>rt :TestFile<CR>
nmap <silent> <leader>rT :TestNearest<CR>

"" vim-grepper
let g:grepper = { 'tools': ['rg', 'pt', 'git'] }
nnoremap <leader>git :Grepper -tool git<CR>
nnoremap <leader>pt :Grepper -tool pt<CR>
nnoremap <leader>rg :Grepper -tool rg<CR>

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

" Load JavaScript library syntax
let g:used_javascript_libs = 'angularjs,angularui,angularuirouter,lodash,react'
let g:jsx_ext_required = 0

" Supertab
let g:SuperTabDefaultCompletionType = "context"

autocmd FileType *
  \ if &omnifunc != '' |
  \   call SuperTabChain(&omnifunc, "<c-p>") |
  \ endif

" Asynchronous Lint Engine
let g:ale_sign_error = '✖✖'
let g:ale_sigin_warning = '⚠⚠'

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

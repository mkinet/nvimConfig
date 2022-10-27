" Original version :
" https://github.com/colbycheeze/dotfiles/blob/master/vimrc (around mai2018)
" Type :so % to refresh .vimrc after making changes
"
" Use Vim settings, rather then Vi settings. This setting must be as early as
" possible, as it has side effects.
set nocompatible

"  PLUGINS
"
call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-sensible'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'psf/black', { 'branch': 'stable' }
Plug 'Shougo/deoplete.nvim', {'do':':UpdateRemotePlugins'}
Plug 'zchee/deoplete-jedi'
Plug 'davidhalter/jedi-vim'
Plug 'neomake/neomake'
Plug 'ervandew/supertab'
Plug 'scrooloose/nerdcommenter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'dhruvasagar/vim-zoom'
Plug 'nvim-lualine/lualine.nvim'
Plug 'airblade/vim-rooter'
" If you want to have icons in your statusline choose one of these
Plug 'kyazdani42/nvim-web-devicons'
Plug 'junegunn/fzf'
" Plug 'janko-m/vim-test'
" Plug 'heavenshell/vim-pydocstring'
Plug 'tpope/vim-vinegar'
Plug 'mhinz/vim-grepper'
Plug 'ekalinin/Dockerfile.vim'
" Plug 'jeetsukumaran/vim-pythonsense'
Plug 'luochen1990/rainbow'
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'Chiel92/vim-autoformat'
" graphql syntax highlighting
Plug 'jparise/vim-graphql'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'will133/vim-dirdiff'
Plug 'mechatroner/rainbow_csv'
Plug 'wellle/context.vim'


" jupyter interaction
Plug 'hkupty/iron.nvim'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'GCBallesteros/vim-textobj-hydrogen'
Plug 'GCBallesteros/jupytext.vim'

call plug#end()

" Leader - ( Comma )
let mapleader = ","

" set backspace=2   " Backspace deletes like most programs in insert mode
" set ruler         " show the cursor position all the time
" Trigger autoread when changing buffers or coming back to vim in terminal.
au FocusGained,BufEnter * :silent! !

"Set default font in mac vim and gvim
set visualbell    " stop that ANNOYING beeping
" set wildmenu
set wildmode=list:longest,full

" Make searching better
set gdefault      " Never have to type /g at the end of search / replace again
nnoremap <silent> <leader><Space> :noh<cr> " Stop highlight after searching
" set incsearch
set showmatch

" Softtabs, 4 spaces
set softtabstop=4
set shiftround
set expandtab
" set autoindent

" Display extra whitespace
" set list listchars=tab:»·,trail:·,nbsp:·

" Make it obvious where 90 characters is
set textwidth=89
" set formatoptions=cq
set formatoptions=cqrn1
set wrapmargin=0
let &colorcolumn="".join(range(90,999),",")

" folding
set foldenable
set foldlevelstart=10   " open most folds by default
" foldlevelstart is the starting fold level for opening a new buffer. If it is
" set to 0, all folds will be closed. Setting it to 99 would guarantee folds
" are always open. So, setting it to 10 here ensures that only very nested
" blocks of code are folded when opening a buffer.
set foldmethod=indent   " fold based on indent level
set foldnestmax=5      " 10 nested fold max
" space open/closes folds
nnoremap <space> za
vnoremap <space> zf


"Use enter to create new lines w/o entering insert mode
nnoremap <leader><CR> O<Esc>j
"Below is to fix issues with the ABOVE mappings in quickfix window
autocmd CmdwinEnter * nnoremap <CR> <CR>
autocmd BufReadPost quickfix nnoremap <CR> <CR>

" Use tab to jump between blocks, because it's easier
nnoremap <tab> %
vnoremap <tab> %

" Always use vertical diffs
set diffopt+=vertical

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
    syntax on
endif


filetype plugin indent on

""" SYSTEM CLIPBOARD COPY & PASTE SUPPORT
set pastetoggle=<F2> "F2 before pasting to preserve indentation
"Copy paste to/from clipboard
vnoremap <leader>y "*y
map <silent><Leader><S-p> :set paste<CR>O<esc>"*]p:set nopaste<cr>"

""" MORE AWESOME HOTKEYS
"
"
" Run the w macro
nnoremap <leader>w @w

" bind K to grep word under cursor
" nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>
" Ag will search from project root
let g:ag_working_path_mode="r"

"Map Ctrl + S to save in any mode
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>
" Also map leader + s
map <leader>s <C-S>

" Quickly close windows
nnoremap <leader>q :x<cr>
nnoremap <leader>Q :q!<cr>

" <leader>= to re-balance
nnoremap <leader>= :wincmd =<cr>

" resize panes
nnoremap <silent> <Right> :vertical resize +5<cr>
nnoremap <silent> <Left> :vertical resize -5<cr>
nnoremap <silent> <Up> :resize +5<cr>
nnoremap <silent> <Down> :resize -5<cr>

"inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Stay in visual mode after indenting
vnoremap < <gv
vnoremap > >gv

" open new vertical buffer
nnoremap <leader>v :vnew<CR>
" open new horizontal buffer
nnoremap <leader>h :new<CR>

" open terminal window in insert mode vertical buffer to the right
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
nnoremap <leader>t :vnew<CR>:terminal<CR>i
" nnoremap <leader>ht :new<CR>:terminal<CR>i


" Color scheme (terminal)
set background=dark
" If you have vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
    set termguicolors
endif

" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Theme
syntax enable
" colorscheme
let g:gruvbox_contrast_dark = "hard"
colorscheme gruvbox
" set terminal background to #050000 for exact same colorscheme
highlight Normal ctermbg=0 guibg=#050000


" AUTOCOMMANDS - Do stuff
" groovy syntax highlighting for jenkinsfiles.
au BufNewFile,BufRead Jenkinsfile setf groovy

" Save whenever switching windows or leaving vim. This is useful when running
" the tests inside vim without having to save all files first.
au FocusLost,WinLeave * :silent! wa

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

"update dir to current file
autocmd BufEnter * silent! cd %:p:h

augroup vimrcEx
    autocmd!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it for commit messages, when the position is invalid, or when
    " inside an event handler (happens when dropping a file on gvim).
    autocmd BufReadPost *
                \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal g`\"" |
                \ endif

    " Set syntax highlighting for specific file types
    autocmd BufRead,BufNewFile *.md set filetype=markdown

    autocmd BufRead *.jsx set ft=jsx.html
    autocmd BufNewFile *.jsx set ft=jsx.html

    " Enable spellchecking for Markdown
    autocmd FileType markdown setlocal spell

    " Automatically wrap at 100 characters for Markdown
    autocmd BufRead,BufNewFile *.md setlocal textwidth=100

    " Automatically wrap at 100 characters and spell check git commit messages
    autocmd FileType gitcommit setlocal textwidth=100
    autocmd FileType gitcommit setlocal spell

    " Allow stylesheets to autocomplete hyphenated words
    autocmd FileType css,scss,sass,less setlocal iskeyword+=-
augroup END

" DEBUGGING
"
nnoremap <leader>b oimport pdb; pdb.set_trace()<Esc>
nnoremap <leader>B Oimport pdb; pdb.set_trace()<Esc>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autopep8
" let g:autopep8_disable_show_diff=1
" let g:autopep8_max_line_length=99
" autocmd FileType python noremap <leader>p :call Autopep8()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Black
let g:black_linelength=88
" black shortcut
autocmd FileType python noremap <leader>p :Black<CR>
" run black on save
autocmd BufWritePre *.py execute ':Black'
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fugitive Configuration

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" deoplete Configuration
let g:deoplete#enable_at_startup=1
" deoplete tab-complete. Supertab does this now.
"inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" deoplete-jedi Configuration
"
let g:python3_host_prog = '~/Developer/virtualenvs/nvim/bin/python'
let g:python_host_prog = '~/Developer/virtualenvs/nvim/bin/python'
let g:jedi#auto_vim_configuration = 1
let g:jedi#goto_assignments_command = ''  " dynamically done for ft=python.
let g:jedi#goto_definitions_command = ''  " dynamically done for ft=python.
let g:jedi#use_tabs_not_buffers = 0  " current default is 1.
let g:jedi#rename_command = '<Leader>r'
let g:jedi#usages_command = '<Leader>u'
let g:jedi#completions_enabled = 1
let g:jedi#smart_auto_mappings = 1

" Unite/ref and pydoc are more useful.
let g:jedi#documentation_command = '<Leader>w' " like in 'what?'
let g:jedi#auto_close_doc = 1
" Do not open a preview docstring window
let g:jedi#show_call_signatures = 2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" neomake Configuration
" let g:neomake_python_enabled_makers=['pylint']
let g:neomake_python_enabled_makers=['flake8']
let g:neomake_open_list = 2
let g:neomake_highlight_lines = 1

" autocmd! BufWritePost * Neomake

nnoremap <leader>l :Neomake<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" supertab configuration
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nerdcommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
"let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" quicker acces to toggle comment
nmap <leader><Tab> <leader>c<Space>
vmap <leader><Tab> <leader>c<Space>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-p> :TmuxNavigatePrevious<cr>

" Disable tmux navigator when zooming the Vim pane
let g:tmux_navigator_disable_when_zoomed = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
"
nnoremap <C-p> :FZF<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-tests
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-pydocstrings
"
" nmap <silent> <leader>D <Plug>(pydocstring)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-markdown-composer
"
let g:markdown_composer_external_renderer='pandoc --mathjax -f markdown -s -t html '
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" rainbow_parentheses
"
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" markdown preview
"
" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0
" example
nmap <leader>m <Plug>MarkdownPreviewToggle
"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autoformat
"
noremap <leader>f :Autoformat<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" context
"
" don't show context by default (makes screen flickering)
let g:context_enabled = 0
cmap ctx ContextToggle

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim-jupyter
"

" Jupytext
let g:jupytext_fmt = 'py'
let g:jupytext_style = 'hydrogen'

nmap <leader>i :IronRepl<CR>
" Send cell to IronRepl and move to next cell.
" Depends on the text object defined in vim-textobj-hydrogen
" You first need to be connected to IronRepl
nmap <leader>x ctrih/^# %%<CR><CR><leader><Space>

luafile $HOME/.config/nvim/plugins.lua

nmap <leader>n i<CR># %%<CR>




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-rooter
"
let g:rooter_patterns = ['.git']
" for non git fodlers use home
let g:rooter_change_directory_for_non_project_files = ''

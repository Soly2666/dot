" -----------------------------------------------------------------------------
" Auther: Islam EL-Banna @Soly2666
"
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
" -----------------------------------------------------------------------------
" -> General

set history=500                                             "Sets how many lines of history VIM has to remember
filetype plugin on                                          "Enable filetype plugins
filetype indent on                                          "Enable filetype plugins
set autoread                                                "Set to auto read when a file is changed from the outside
au FocusGained,BufEnter * checktime

"With a map leader it's possible to do extra key combinations
let mapleader = ","                                         "like <leader>w saves the current file
nmap <leader>w :w!<cr>                                      "Fast saving  :W sudo saves the file

command! W execute 'w !sudo tee % > /dev/null' <bar> edit!  "(useful for handling the permission-denied error)

set encoding=UTF-8
filetype plugin indent on                                   "Enabling Plugin & Indent
syntax on                                                   "Turning Syntax on
set autoread
set wildmenu
set number relativenumber                                   "Setting line numbers
set nu rnu
set spelllang=en_us
set spell
set backspace=indent,eol,start                              "Making sure backspace works
set noruler                                                 "Setting up rulers & spacing, tabs
set confirm
set shiftwidth=4
set autoindent
set smartindent
set tabstop=4
set softtabstop=4
set expandtab  
set hls is                                                  "Making sure search highlights words as we type them
set ic
set laststatus=2                                            "Setting the size for the command area, and airline status bar
set cmdheight=1

" -----------------------------------------------------------------------------
" -> VIM user interface

set so=7                                                    "Set 7 lines to the cursor - when moving vertically using j/k
let $LANG='en'                                              "Avoid garbled characters in Chinese language windows OS
set langmenu=en

source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

set wildmenu                                                "Turn on the Wild menu
set wildignore=*.o,*~,*.pyc                                 "Ignore compiled files

if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

set ruler                                                   "Always show current position
set cmdheight=2                                             "Height of the command bar
set hid                                                     "A buffer becomes hidden when it is abandoned
set backspace=eol,start,indent                              "Configure backspace so it acts as it should act
set whichwrap+=<,>,h,l
set ignorecase                                              "Ignore case when searching
set smartcase                                               "When searching try to be smart about cases
set hlsearch                                                "Highlight search results
set incsearch                                               "Makes search act like search in modern browsers
set lazyredraw                                              "Don't redraw while executing macros (good performance config)
set magic                                                   "For regular expressions turn magic on
set showmatch                                               "Show matching brackets when text indicator is over them
set mat=2                                                   "How many tenths of a second to blink when matching brackets
set noerrorbells                                            "No annoying sound on errors
set novisualbell                                            "No annoying sound on errors
set t_vb=
set tm=500
set foldcolumn=1                                            "Add a bit extra margin to the left

if has("gui_macvim")                                        "Properly disable sound on errors on MacVim
     autocmd GUIEnter * set vb t_vb=
endif

" -----------------------------------------------------------------------------
" -> Colors and Fonts

syntax enable                                               "Enable syntax highlighting

try
    colorscheme desert
catch
endtry

set background=dark

if has("gui_running")                                       "Set extra options when running in GUI mode
     set guioptions-=T
     set guioptions-=e
     set t_Co=256
     set guitablabel=%M\ %t
endif

set encoding=utf8                                           "Set utf8 as standard encoding and en_US as the standard language
set ffs=unix,dos,mac                                        "Use Unix as the standard file type

" -----------------------------------------------------------------------------
" -> Files, backups and undo

" Turn backup off, since most stuff is in SVN, git etc. anyway...
" set nobackup
" set nowb
" set noswapfile

" -----------------------------------------------------------------------------
" -> Text, tab and indent related
 
set expandtab                                               "Use spaces instead of tabs
set smarttab                                                "Be smart when using tabs ;)
set shiftwidth=4                                            "1 tab == 4 spaces
set tabstop=4

set lbr                                                     "Linebreak on 500 characters
set tw=500
set ai                                                      "Auto indent
set si                                                      "Smart indent
set wrap                                                    "Wrap lines

" -----------------------------------------------------------------------------
" -> Visual mode related

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


" -----------------------------------------------------------------------------
" -> Moving around, tabs, windows and buffers

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <C-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" -----------------------------------------------------------------------------
" -> Status line

set laststatus=2                                            "Always show the status line

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c


" -----------------------------------------------------------------------------
" -> Editing mappings

map 0 ^                                                     " Remap VIM 0 to first non-blank character

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

" -----------------------------------------------------------------------------
" -> Spell checking

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


" -----------------------------------------------------------------------------
" -> Misc
 
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>


" -----------------------------------------------------------------------------
" -> Helper functions

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE'
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")
    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif
    if bufnr("%") == l:currentBufNum
        new
    endif
    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"
    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")
    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif
    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" -------------------------------- Plugins (VimPlug) --------------------------
call plug#begin('~/.vim/plugged')  
" Tools
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'airblade/vim-gitgutter' 
    Plug 'junegunn/goyo.vim'  
    Plug 'preservim/nerdtree'
    Plug 'ryanoasis/vim-devicons'
" Syntax
    Plug 'tpope/vim-markdown'
    Plug 'ap/vim-css-color' "Displays a preview of colors with CSS 
    Plug 'vim-scripts/fountain.vim'
" Color-schemes
    Plug 'morhetz/gruvbox' "My favorite theme
call plug#end() 
 
" ---------------------------- General Settings ------------------------------
set encoding=UTF-8
filetype plugin indent on                                   "Enabling Plugin & Indent
syntax on                                                   "Turning Syntax on
set autoread
set wildmenu
set number relativenumber                                   "Setting line numbers
set nu rnu
set spelllang=en_us
set spell
set backspace=indent,eol,start                              "Making sure backspace works
set noruler                                                 "Setting up rulers & spacing, tabs
set confirm
set shiftwidth=4
set autoindent
set smartindent
set tabstop=4
set softtabstop=4
set expandtab  
set hls is                                                  "Making sure search highlights words as we type them
set ic
set laststatus=2                                            "Setting the size for the command area, and airline status bar
set cmdheight=1

" --------------------------- Syntax Mappings --------------------------------
au BufRead,BufNewFile *.fountain set filetype=fountain      "Enabling fountain syntax

" ---------------------------- Key Remapping ---------------------------------
map <C-n> :NERDTreeToggle<CR>
map <C-g> :Goyo<CR>
map <C-u> :source ~/.vimrc<CR>
map <C-b> :set spelllang=de_de<CR>
nnoremap <Up>    :resize +2<CR> 
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

" ----------------------------- Color Settings -------------------------------
colorscheme gruvbox  
let g:airline_theme='gruvbox'
set background=dark
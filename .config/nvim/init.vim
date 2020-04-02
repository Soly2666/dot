" -------------------------------- Plugins (VimPlug) --------------------------
call plug#begin()  
    "Adding some plug-ins that add functionality
    Plug 'airblade/vim-gitgutter' 
    Plug 'junegunn/goyo.vim'
    Plug 'vifm/vifm.vim' "using the vifm file manager rather than NERD Tree

    "Syntax
    Plug 'tpope/vim-markdown'
    Plug 'ap/vim-css-color' "Displays a preview of colors with CSS 
    Plug 'vim-scripts/fountain.vim'

    "Color schemes 
    Plug 'morhetz/gruvbox' "My favorite theme
    Plug 'kristijanhusak/vim-hybrid-material'
    Plug 'NLKNguyen/papercolor-theme'
    Plug 'jacoborus/tender.vim'
    Plug 'romainl/Apprentice'
    Plug 'nanotech/jellybeans.vim'
    Plug 'ajh17/Spacegray.vim'
call plug#end() 
 
" ----------------------------- General Settings ------------------------------
set encoding=UTF-8
filetype plugin indent on  "Enabling Plugin & Indent
syntax on  "Turning Syntax on
set autoread
set wildmenu
set number relativenumber  "Setting line numbers
set nu rnu
set spelllang=en_us
set spell
set backspace=indent,eol,start  "Making sure backspace works
set noruler  "Setting up rulers & spacing, tabs
set confirm
set shiftwidth=4
set autoindent
set smartindent
set tabstop=4
set softtabstop=4
set expandtab  
set hls is  "Making sure search highlights words as we type them
set ic
set laststatus=2 "Setting the size for the command area, and airline status bar
set cmdheight=1
set colorcolumn=81
set noemoji

" -------------------------------- Status Bar ---------------------------------
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m\
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c

" --------------------------- Syntax Mappings ---------------------------------
au BufRead,BufNewFile *.fountain set filetype=fountain "Enabling fountain syntax

" ---------------------------- Key Remapping ----------------------------------
nmap <Space> :w <bar> EditVifm ~<CR>
nmap <ENTER> :w <bar> Lex <bar> vertical resize 30<CR>
map <C-g> :Goyo<CR>
map <C-u> :source ~/.config/nvim/init.vim<CR>
map <C-b> :set spelllang=de_de<CR>
map <C-l> :set background=light <CR>
nmap <C-c> :colorscheme 
nnoremap <Up> :resize +2<CR> 
nnoremap <Down> :resize -2<CR>
nnoremap <Left> :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

" ----------------------------- Color Settings --------------------------------
colorscheme gruvbox  
set background=dark

hi! Normal ctermbg=NONE guibg=NONE 
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE 
"Making background transparent in Alacritty by default

" -------------------------------- Connect ------------------------------------
" https://makc.co
" https://github.com/makccr

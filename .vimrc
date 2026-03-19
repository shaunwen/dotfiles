" Manage plugins with vim-plug.
call plug#begin()
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'godlygeek/tabular'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'tpope/vim-commentary'
Plug 'pangloss/vim-javascript'    " JavaScript support
Plug 'leafgarland/typescript-vim' " TypeScript syntax
Plug 'maxmellon/vim-jsx-pretty'   " JS and JSX syntax
Plug 'jparise/vim-graphql'        " GraphQL syntax
Plug 'rust-lang/rust.vim'
Plug 'morhetz/gruvbox'
call plug#end()
" End of plugin management

set number
" Use OSX clipboard to copy and to paste
set clipboard=unnamed
syntax on
filetype plugin indent on
set background=dark
colorscheme gruvbox
set vb
" set cursor shape
" Reference chart of values:
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).	
let &t_SI = "\e[6 q"
let &t_SR = "\e[4 q"
let &t_EI = "\e[2 q"
set ttimeoutlen=10	" wait up to 10ms after Esc for special key

" Common keymap
noremap ; :
nnoremap L $
nnoremap H ^
let mapleader = " "

" Split window
nmap ss :split<CR><C-w>w
nmap sv :vsplit<CR><C-w>w
map sh <C-w>h
map sk <C-w>k
map sj <C-w>j
map sl <C-w>l

" Plugin: easymotion
map <Leader> <Plug>(easymotion-prefix)
" nmap <Leader>2s <Plug>(easymotion-s2)
" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1
" Smartsign (type `3` and match `3`&`#`)
let g:EasyMotion_use_smartsign_us = 1
hi EasyMotionTarget ctermbg=32 ctermfg=231 "x032_DeepSkyBlue3, x231_Grey100
hi EasyMotionShade  ctermbg=none ctermfg=none

let g:multi_cursor_select_all_word_key = '<S-C-a>'
let g:multi_cursor_select_all_key      = 'g<S-C-a>'

" Plugin: NERDTree
nnoremap <leader><leader>n :NERDTreeFocus<CR>
nnoremap <leader><leader>t :NERDTreeToggle<CR>
nnoremap <leader><leader>f :NERDTreeFind<CR>

" Plugin: FZF
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <C-t> :Files<CR>
nnoremap <silent> <C-g> :GFiles<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>g :Commits<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR>

if has("gui_running")
  syntax on
  set hlsearch
  colorscheme gruvbox
  set bs=2
  set ai
  set ruler
  set guifont=HackNerdFontComplete-Regular:h18
endif

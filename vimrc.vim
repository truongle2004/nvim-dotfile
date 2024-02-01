syntax on
set noerrorbells
set tabstop=4 softtabstop=4
set smartindent
set smarttab
set autoindent
set cindent
set shiftwidth=4
set expandtab
set nu
set ruler
set guifont=*
set backspace=indent,eol,start
set clipboard=unnamed


set shell=powershell.exe
set shellxquote=
let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command '
let &shellquote   = ''
let &shellpipe    = '| Out-File -Encoding UTF8 %s'
let &shellredir   = '| Out-File -Encoding UTF8 %s'
hi Normal guibg=NONE ctermbg=NONE





" git status
set statusline+=%{get(b:,'gitsigns_status','')}


nnoremap <C-Right> :tabnext<CR>
nnoremap <C-Left> :tabprevious<CR>
set nocompatible
autocmd filetype cpp nnoremap <F5> :w <bar> !g++ -std=c++17 -O2 -Wall % -o %:r && %:r.exe <CR>
set nocompatible              " be iMproved, required
set number
set relativenumber
call plug#begin(stdpath('config').'/plugged')
Plug 'ryanoasis/vim-devicons'                
Plug 'Pocco81/auto-save.nvim'
Plug 'voldikss/vim-floaterm'  
Plug 'preservim/nerdcommenter' 
Plug 'easymotion/vim-easymotion'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdTree'     
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch':'release'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jackguo380/vim-lsp-cxx-highlight'    
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }   
Plug 'Dhanus3133/LeetBuddy.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'Yggdroot/indentLine'
Plug 'lewis6991/gitsigns.nvim'
call plug#end()

colorscheme tokyonight-night


command! -nargs=1 ReloadFolder :e <args>
map  <Leader>w <Plug>(easymotion-bd-w)
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_auto_sameids = 1

let g:indentLine_enabled = 1

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument


" leetcode config

nnoremap <leader>lq :LBQuestions<CR>
nnoremap <leader>ll :LBQuestion<CR>
nnoremap <leader>lr :LBReset<CR>
nnoremap <leader>lt :LBTest<CR>
nnoremap <leader>ls :LBSubmit<CR>




nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader>m :NERDTree<CR>
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"


" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" exit terminal
cnoremap <C-x> q



" Assuming you're using CoC (Conqueror of Completion)
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"

" Enable compe and configure key mappings
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


" Clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>
let g:airline#extensions#tabline#enabled = 1
nmap <M-Right> :vertical resize +1<CR>    
nmap <M-Left> :vertical resize -1<CR>
nmap <M-Down> :resize +1<CR>
nmap <M-Up> :resize -1<CR>
lua <<EOF
local async = require "plenary.async"
require("leetbuddy").setup({
	language = "cpp"	,
})

require('gitsigns').setup()
EOF

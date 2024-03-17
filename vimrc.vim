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
set laststatus=2

set shell=powershell.exe
set shellxquote=
let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command '
let &shellquote   = ''
let &shellpipe    = '| Out-File -Encoding UTF8 %s'
let &shellredir   = '| Out-File -Encoding UTF8 %s'
hi Normal guibg=NONE ctermbg=NONE

set synmaxcol=3000    "Prevent breaking syntax hightlight when string too long. Max = 3000"
set lazyredraw
au! BufNewFile,BufRead *.json set foldmethod=indent " Change foldmethod for specific filetype



" git status
set statusline+=%{get(b:,'gitsigns_status','')}


nnoremap <C-Right> :tabnext<CR>
nnoremap <C-Left> :tabprevious<CR>
set nocompatible
" Compile and run C++ code with F5
autocmd FileType cpp nnoremap <F5> :w <bar> !g++ -std=c++17 -O2 -Wall % -o %:r.exe \| ./%:r.exe<CR>



set nocompatible              " be iMproved, required
set number
set relativenumber
call plug#begin(stdpath('config').'/plugged')
Plug 'xiyaowong/transparent.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'                
Plug 'Pocco81/auto-save.nvim'
Plug 'voldikss/vim-floaterm'  
Plug 'preservim/nerdcommenter' 
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdTree'     
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch':'release'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }   
Plug 'neovim/nvim-lspconfig'
Plug 'hinell/lsp-timeout.nvim'
" Plug 'editorconfig/editorconfig-vim'
" Plug 'lewis6991/gitsigns.nvim'
" Plug 'sindrets/diffview.nvim'
Plug 'joshdick/onedark.vim'
Plug 'Yggdroot/indentLine'
call plug#end()

colorscheme onedark

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''	

let g:airline#extensions#tabline#enabled = 0
command! -nargs=1 ReloadFolder :e <args>
map  <Leader>w <Plug>(easymotion-bd-w)


let g:indentLine_enabled = 1

augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

" move buffes
" Move to the next buffer
nnoremap <A-.> :bnext<CR>

" Move to the previous buffer
nnoremap <A-,> :bprevious<CR>


" eslint
let g:coc_global_extensions = ['coc-eslint','coc-prettier']
autocmd FileType javascript,json,yaml,yml,typescript,markdown setl formatprg=eslint\ --fix\ --stdin
autocmd FileType javascript,json,yaml,yml,typescript,markdown setl formatprg=prettier\ --write\ --stdin



command! -nargs=0 PyRun :terminal python %<CR>
command! -nargs=0 Action :lua vim.lsp.buf.code_action()<CR>
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument
command! -nargs=0 Eslint :CocCommand eslint.executeAutofix

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

nnoremap <silent> <leader>to    :FloatermNew<CR>
" Assuming you're using CoC (Conqueror of Completion)
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"

" Enable compe and configure key mappings
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


autocmd CursorHold * silent call CocActionAsync('highlight')



nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv


" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

" Clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>
let g:airline#extensions#tabline#enabled = 1
nmap <M-Right> :vertical resize +1<CR>    
nmap <M-Left> :vertical resize -1<CR>
nmap <M-Down> :resize +1<CR>
nmap <M-Up> :resize -1<CR>

lua <<EOF
local async = require "plenary.async"
local nvim_lsp = require('lspconfig')

nvim_lsp.tsserver.setup{
  on_attach = function(client)
    print('LSP started for TypeScript!')
  end,
  filetypes = { 'javascriptreact','javascript.jsx','javascript','typescript', 'typescriptreact', 'typescript.tsx' },
}
nvim_lsp.clangd.setup{
  on_attach = function(client)
    print('LSP started for C++!')
  end,
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'hpp', 'h' },
}
nvim_lsp.html.setup({})
nvim_lsp.cssls.setup({})
--require('gitsigns').setup()

-- Enable built-in LSP
if vim.fn.has('nvim-0.5') == 1 then
    -- Enable LSP
    vim.o.updatetime = 300
    -- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics()]]

    -- Python LSP configuration with Pyright
    local lspconfig = require('lspconfig')
    lspconfig.pyright.setup{}
end


EOF

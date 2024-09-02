local arrows = require('icons').arrows
local opt = vim.opt

opt.shell = "pwsh"
opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
opt.shellquote = ""
opt.shellxquote = ""
opt.termguicolors = true
opt.relativenumber = true
opt.number = true
opt.scrolloff = 10
opt.laststatus = 3

vim.o.foldtext = ""
vim.o.fillchars = "fold: "

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	command = "setlocal tabstop=4 shiftwidth=4 softtabstop=4",
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	command = "setlocal tabstop=2 shiftwidth=2 softtabstop=2",
})

opt.expandtab = true

opt.shada = ""
opt.autoindent = true
opt.wrap = false
opt.ignorecase = true
opt.smartcase = true
opt.cursorline = true
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.backspace = "indent,eol,start"
opt.clipboard:append("unnamedplus")
opt.splitright = true
opt.splitbelow = true
opt.swapfile = false
opt.splitbelow = true -- split windows below
opt.splitright = true -- split windows right
opt.colorcolumn = "80"
vim.o.wrap = true
-- Enable lazyredraw for better performance during macros and complex operations
-- vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]])
-- vim.diagnostic.config({
--     underline = true,
--     signs = true,
--     virtual_text = false,
--     float = {
--         show_header = true,
--         source = 'if_many',
--         border = 'rounded',
--         focusable = false,
--     },
--     update_in_insert = false, -- default to false
--     severity_sort = false,    -- default to false
-- })
vim.o.lazyredraw = true
-- Assume fast terminal connection
vim.o.ttyfast = true
-- Set the update time for writing to the swap file and triggering CursorHold events (in milliseconds)
vim.o.updatetime = 300
vim.o.termguicolors = true

vim.o.spelllang = "en_us"
vim.o.spell = true

-- Folding.
vim.o.foldcolumn = '1'
vim.o.foldlevelstart = 99
vim.o.foldmethod = 'expr'
vim.wo.foldtext = 'v:lua.vim.treesitter.foldtext()'
vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'


-- UI characters.
vim.opt.fillchars = {
    eob = ' ',
    fold = ' ',
    foldclose = arrows.right,
    foldopen = arrows.down,
    foldsep = ' ',
    msgsep = '─',
}

vim.api.nvim_set_keymap("t", "<C-x>", [[<C-\><C-n>]], { noremap = true, silent = true })

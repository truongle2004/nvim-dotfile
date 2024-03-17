local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)
vim.api.nvim_set_keymap('t', '<C-x>', '<C-\\><C-n>', {noremap = true, silent = true})
vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc')


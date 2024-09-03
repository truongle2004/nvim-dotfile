vim.api.nvim_create_user_command('Todos', function()
    require('fzf-lua').grep { search = [[TODO:|todo!\(.*\)]], no_esc = true }
end, { desc = 'Grep TODOs', nargs = 0 })

vim.api.nvim_create_user_command('Fixs', function()
    require('fzf-lua').grep { search = [[FIXME:|fixme!\(.*\)]], no_esc = true }
end, { desc = 'Grep TODOs', nargs = 0 })

vim.api.nvim_create_user_command('Hacks', function()
    require('fzf-lua').grep { search = [[HACK:|hack!\(.*\)]], no_esc = true }
end, { desc = 'Grep TODOs', nargs = 0 })

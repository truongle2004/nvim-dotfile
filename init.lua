---@diagnostic disable: undefined-global, missing-fields
-- load leader key first
vim.g.mapleader = " "

-- load color
-- vim.cmd.colorscheme("miss-dracula")
-- vim.cmd.colorscheme("retrobox")

local map = vim.keymap.set

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

---@type LazySpec
local plugins = 'plugins'
-- general setup
require("statusline")
require("winbar")
require("command")
require("lsp")
require("autocmds")

-- setup options and keymaps
require("core")

require("lazy").setup(plugins)


------------------------------------------------ place for creativity ---------------------------------------------

local function name_without_ext(str)
    if type(str) ~= "string" then
        print("error name_without_ext function!")
        print("paramater should be a string")
        return
    end
    return str:match("^(.*)%.%w+$")
end

function _G.get_file_name()
    local full_path = vim.fn.expand("%:p")  -- Get the full path
    return vim.fn.fnamemodify(full_path, ":t") -- Extract the filename
end

local function cpp_compile()
    local file_name = _G.get_file_name()

    local certainName = name_without_ext(file_name)

    local cpp_compile_and_execute_command = string.format("g++ %s.cpp -o %s.exe", certainName, certainName)

    local run_command = string.format("./%s.exe", certainName)

    -- Open a vertical split, run the compile command in a terminal, and then run the executable
    vim.cmd("vsplit | terminal")

    vim.cmd(string.format(":call jobsend(b:terminal_job_id, '%s && %s')", cpp_compile_and_execute_command, run_command))
end

------------------------------ run here -------------------------
vim.api.nvim_create_user_command("CompileCpp", cpp_compile, {})
vim.api.nvim_set_keymap("n", "<Leader>fn", ":CompileCpp<CR>", { noremap = true, silent = true })

map("n", "sx", ':lua require"treesitter-unit".select()<cr>')
map("n", "dx", ':lua require"treesitter-unit".delete()<cr>')
map("n", "cx", ':lua require"treesitter-unit".change()<cr>')

---------------------------------javascript booster----------------
map("n", "te", ":luafile ./lua/javascript-booster/init.lua<cr>")
-- map('n', '<leader>l', ':luafile ./lua/logme/init.lua<cr>')

---@diagnostic disable: undefined-global, missing-fields
local opt = vim.opt


vim.g.mapleader = " "
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
vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]])
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
vim.api.nvim_set_keymap("t", "<C-x>", [[<C-\><C-n>]], { noremap = true, silent = true })

local map = vim.keymap.set
map("n", "ff", ":lua vim.lsp.buf.format()<CR>")
map("i", "<C-j>", "<down>")
map("i", "<C-k>", "<up>")
map("i", "<C-h>", "<left>")
map("i", "<C-l>", "<right>")
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")
map("i", "jk", "<ESC>")
map("n", "<leader>m", ":NvimTreeToggle<CR>")
map("n", "<leader>n", ":NvimTreeFocus<CR>")
map("n", "<esc>", ":noh<cr>")
map("n", "<M-right>", ":vertical resize +1<CR>")
map("n", "<M-left>", ":vertical resize -1<CR>")
map("n", "<M-Down>", ":resize +1<CR>")
map("n", "<M-Up>", ":resize -1<CR>")
map("n", "ee", "$")
map("n", "<space>h", "<c-w>h")
map("n", "<space>j", "<c-w>j")
map("n", "<space>k", "<c-w>k")
map("n", "<space>l", "<c-w>l")
map("n", "<C-a>", "ggVG")
map("n", "<C-k>", "<C-u>")
map("v", "<C-k>", "<C-u>")
map("n", "<C-j>", "<C-d>")
map("v", "<C-j>", "<C-d>")
map("n", "<A-,>", ":bNext<CR>")
map("n", "<A-.>", ":bnext<CR>")
map("n", "<leader>ff", ":FzfLua files<cr>")
map("n", "<leader><leader>f", ":FzfLua grep_project<cr>")
map("v", "<leader>l", "$y<cr>")
map("n", "<leader>sc", ":source %<cr>")

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

-- vim.cmd [[colorscheme retrobox]]

require("lazy").setup({
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local conform = require("conform")

            conform.setup({
                formatters_by_ft = {
                    javascript = { "prettier" },
                    typescript = { "prettier" },
                    javascriptreact = { "prettier" },
                    typescriptreact = { "prettier" },
                    css = { "prettier" },
                    html = { "prettier" },
                    json = { "prettier" },
                    yaml = { "prettier" },
                    markdown = { "prettier" },
                    graphql = { "prettier" },
                    liquid = { "prettier" },
                    lua = { "stylua" },
                },
            })

            vim.keymap.set({ "n", "v" }, "<leader>mp", function()
                conform.format({
                    lsp_fallback = true,
                    async = false,
                    timeout_ms = 1000,
                })
            end, { desc = "Format file or range (in visual mode)" })
        end,
    },
    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },
    -- {
    --     "craftzdog/solarized-osaka.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     opts = {},
    --     config = function()
    --         require("solarized-osaka").setup({
    --             transparent = false,
    --             styles = {
    --                 comments = { italic = false },
    --                 keywords = { italic = false },
    --             },
    --         })
    --         vim.cmd [[colorscheme solarized-osaka]]
    --     end
    -- },
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        config = function()
            require("gruvbox").setup({
                italic = {
                    strings = false,
                    emphasis = false,
                    comments = false,
                    operators = false,
                    folds = true,
                },
            })
            vim.cmd([[colorscheme gruvbox]])
        end,
    },
    {
        "nvim-treesitter/nvim-tree-docs",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "windwp/nvim-ts-autotag",
        },
        config = function()
            local treesitter = require("nvim-treesitter.configs")
            treesitter.setup({
                highlight = {
                    enable = true,
                },
                indent = { enable = true },
                autotag = {
                    enable = true,
                },
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "lua-language-server",
                "stylua",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            { "antosha417/nvim-lsp-file-operations", config = true },
            { "folke/neodev.nvim",                   opts = {} },
            { "nvim-lua/plenary.nvim" },
        },
        config = function()
            -- import lspconfig plugin

            local lspconfig = require("lspconfig")

            -- import cmp-nvim-lsp plugin
            local cmp_nvim_lsp = require("cmp_nvim_lsp")

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf, silent = true }

                    -- set keybinds
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set("n", "<leader>wl", function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts)
                    --vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
                    vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                end,
            })

            -- used to enable autocompletion (assign to every lsp server config)
            local capabilities = cmp_nvim_lsp.default_capabilities()

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
            })

            lspconfig.eslint.setup({})

            local function organize_imports()
                local params = {
                    command = "_typescript.organizeImports",
                    arguments = { vim.api.nvim_buf_get_name(0) },
                }
                vim.lsp.buf.execute_command(params)
            end

            lspconfig.tsserver.setup({
                capabilities = capabilities,
                commands = {
                    OrganizeImports = {
                        organize_imports,
                        description = "Organize Imports",
                    },
                },
            })

            lspconfig.rust_analyzer.setup({
                capabilities = capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        cargo = {
                            allFeatures = true,
                        },
                        imports = {
                            group = {
                                enable = false,
                            },
                        },
                        completion = {
                            postfix = {
                                enable = false,
                            },
                        },
                    },
                },
            })
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer", -- source for text in buffer
            "hrsh7th/cmp-path", -- source for file system paths
            {
                "L3MON4D3/LuaSnip",
                -- follow latest release.
                version = "v2.*",  -- Replace <CurrentMajor> by the latest released major (first number of latest release)
            },
            "saadparwaiz1/cmp_luasnip", -- for autocompletion
            "rafamadriz/friendly-snippets", -- useful snippets
            "onsails/lspkind.nvim", -- vs-code like pictograms
        },
        config = function()
            local cmp = require("cmp")

            local luasnip = require("luasnip")

            local lspkind = require("lspkind")

            -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                completion = {
                    completeopt = "menu,menuone,preview,noselect",
                },
                snippet = { -- configure how nvim-cmp interacts with snippet engine
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                    ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
                    ["<C-e>"] = cmp.mapping.abort(), -- close completion window
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                -- sources for autocompletion
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" }, -- snippets
                    { name = "buffer" }, -- text within current buffer
                    { name = "path" }, -- file system paths
                }),

                -- configure lspkind for vs-code like pictograms in completion menu
                formatting = {
                    format = lspkind.cmp_format({
                        maxwidth = 50,
                        ellipsis_char = "...",
                    }),
                },
            })
            vim.keymap.set({ "i" }, "<C-K>", function()
                luasnip.expand()
            end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<C-l>", function()
                luasnip.jump(1)
            end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<C-h>", function()
                luasnip.jump(-1)
            end, { silent = true })
        end,
    },
    {
        "echasnovski/mini.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "ibhagwan/fzf-lua",
        },
        version = "*",
        config = function()
            -- Load and configure all mini.nvim modules
            --
            -- Mini.ai: Extensible text objects
            -- require('mini.ai').setup()

            -- Mini.bracketed: Jump to different brackets
            -- require('mini.bracketed').setup()

            -- Mini.bufremove: Remove buffers
            -- require('mini.bufremove').setup()

            -- Mini.comment: Smart commenting
            require("mini.comment").setup()

            -- Mini.cursorword: Highlight word under cursor
            -- require('mini.cursorword').setup()

            -- Mini.doc: Generate documentation
            require("mini.doc").setup()

            -- Mini.files: File management
            -- require('mini.files').setup()

            -- Mini.fuzzy: Fuzzy finder
            -- require('mini.fuzzy').setup()

            -- Mini.indentscope: Visualize and work with indent scope
            require("mini.indentscope").setup()

            -- Mini.jump: Jump functionality
            require("mini.jump").setup({
                mappings = {
                    forward = "f",
                    backward = "F",
                    forward_till = "t",
                    backward_till = "T",
                    repeat_jump = "rp",
                },
            })

            -- Mini.jump2d: Jump in 2D
            require("mini.jump2d").setup({
                mappings = {
                    start_jumping = "<leader>w",
                },
            })

            -- Mini.move: Move selections
            require("mini.move").setup()

            -- Mini.pairs: Autopairs functionality
            require("mini.pairs").setup()

            -- Mini.splitjoin: Split and join code
            require("mini.splitjoin").setup()

            -- Mini.surround: Surround functionality
            require("mini.surround").setup()

            -- Mini.tabline: Tabline
            require("mini.tabline").setup()

            require("mini.git").setup()

            -- require('mini.statusline').setup()
            -- require('mini.completion').setup()
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        config = function()
            require("nvim-tree").setup({
                view = {
                    width = 40,
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("nvim-treesitter").setup()
        end,
    },
    {
        "nvim-treesitter/playground",
        event = "BufRead",
    },
    {
        "rust-lang/rust.vim",
        ft = { "rust" },
        config = function()
            vim.g.rustfmt_autosave = 1
            vim.g.rustfmt_emit_files = 1
            vim.g.rustfmt_fail_silently = 0
            vim.g.rust_clip_command = "wl-copy"
        end,
    },
})

------------------------------------------------ place for creativity ---------------------------------------------

local function file_type()
    return vim.bo.filetype
end

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

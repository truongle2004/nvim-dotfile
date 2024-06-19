---@diagnostic disable: undefined-global

if vim.g.neovide then
  vim.o.guifont = "CaskaydiaCove Nerd Font Mono:h10"
end
-- vim.cmd("colorscheme retrobox")
local opt = vim.opt
vim.g.mapleader = " "
opt.shell = "pwsh"
opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
opt.shellquote = ""
opt.shellxquote = ""
opt.termguicolors = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwPlugin = 1
opt.relativenumber = true
opt.number = true
opt.scrolloff = 10
opt.laststatus = 2
opt.tabstop = 2
opt.shiftwidth = 2
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

require("lazy").setup({
  {
    "lewis6991/impatient.nvim",
    config = function()
      require("impatient")
    end,
  },
  {
    "ahmedkhalf/jupyter-nvim",
    config = function()
      require("jupyter-nvim").setup()
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      require("null-ls").setup({
        sources = {
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettierd,
          null_ls.builtins.diagnostics.mypy,
          null_ls.builtins.diagnostics.ruff,
          --   null_ls.builtins.diagnostics.mypy.with({
          --     extra_args = function()
          --       local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
          --       return { "--python-executable", virtual .. "/bin/python3" }
          --     end,
          --   }),
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({
              group = augroup,
              buffer = bufnr,
            })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
              end,
            })
          end
        end,
      })
    end,
  },
  {
    "sainnhe/everforest",
    config = function()
      -- vim.cmd("colorscheme everforest")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({})
    end,
  },
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require("solarized-osaka").setup({
        transparent = false,
      })
      vim.cmd("colorscheme solarized-osaka")
    end,
  },
  {
    "projekt0n/github-nvim-theme",
    config = function()
      -- vim.cmd("colorscheme github_dark_default")
    end,
  },
  {
    "nvim-treesitter/playground",
    event = "BufRead",
  },
  {
    "jose-elias-alvarez/typescript.nvim",
    ft = { "typescript" },
    config = function()
      require("typescript").setup({})
    end,
  },
  {
    "phaazon/hop.nvim",
    branch = "v2",
    config = function()
      require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "antosha417/nvim-lsp-file-operations", config = true },
      { "folke/neodev.nvim",                   opts = {} },
    },
    config = function()
      require("neodev").setup()
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local capabilities = cmp_nvim_lsp.default_capabilities()
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      lspconfig.pyright.setup({
        capabilities = capabilities,
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.tsserver.setup({
        capabilities = capabilities,
      })
      lspconfig.emmet_ls.setup({
        capabilities = capabilities,
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettierd",
        "tsserver",
        "emmet_ls",
      },
    },
  },
  {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    config = function()
      local autopairs = require("nvim-autopairs")

      autopairs.setup({
        check_ts = true,
        ts_config = {
          lua = { "string" },
          javascript = { "template_string" },
          java = false,
        },
      })

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")

      local cmp = require("cmp")

      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "nvim-lua/plenary.nvim",
  },
  {

    "nvim-tree/nvim-web-devicons",
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- calling `setup` is optional for customization
      require("fzf-lua").setup({})
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "windwp/nvim-ts-autotag",
    },
    config = function()
      local treesitter = require("nvim-treesitter")
      require("nvim-ts-autotag").setup()

      treesitter.setup({
        highlight = {
          enable = true,
        },
        indent = { enable = true },
        autotag = {
          enable = true,
        },
        ensure_installed = {
          "json",
          "javascript",
          "typescript",
          "tsx",
          "yaml",
          "html",
          "css",
          "markdown",
          "markdown_inline",
          "bash",
          "lua",
          "vim",
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
      })
    end,
  },
  {
    "kylechui/nvim-surround",
    event = { "BufReadPre", "BufNewFile" },
    version = "*",
    config = true,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-path",
      "mlaursen/vim-react-snippets",
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
      },
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      require("vim-react-snippets").lazy_load()
      -- local cmdline = require("cmp-cmdline")
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
        matching = { disallow_symbol_nonprefix_matching = false },
      })
      local luasnip = require("luasnip")

      local lspkind = require("lspkind")

      require("luasnip.loaders.from_vscode").lazy_load()
      cmp.setup({
        completion = {
          completeopt = "menu,menuone,preview,noselect",
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
          { name = "cmdline" },
        }),

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
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 40,
        },
      })
    end,
  },
  -- {
  -- 	"stevearc/conform.nvim",
  -- 	event = { "BufReadPre", "BufNewFile" },
  -- 	config = function()
  -- 		local conform = require("conform")
  --
  -- 		conform.setup({
  -- 			formatters_by_ft = {
  -- 				javascript = { "prettierd" },
  -- 				typescript = { "prettierd" },
  -- 				javascriptreact = { "prettierd" },
  -- 				typescriptreact = { "prettierd" },
  -- 				css = { "prettierd" },
  -- 				html = { "prettierd" },
  -- 				json = { "prettierd" },
  -- 				yaml = { "prettierd" },
  -- 				lua = { "stylua" },
  -- 				java = { "clang-format" },
  -- 				py = { "mypy" },
  -- 				py = { "ruff" },
  -- 			},
  -- 			format_on_save = {
  -- 				lsp_fallback = true,
  -- 				async = false,
  -- 				timeout_ms = 1000,
  -- 			},
  -- 		})
  --
  -- 		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
  -- 			conform.format({
  -- 				lsp_fallback = true,
  -- 				async = false,
  -- 				timeout_ms = 1000,
  -- 			})
  -- 		end, { desc = "Format file or range (in visual mode)" })
  -- 	end,
  -- },
  {
    "echasnovski/mini.tabline",
    version = "*",
    config = function()
      require("mini.tabline").setup()
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },

    dependencies = {
      "nvim-lua/plenary.nvim",
    },

    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  {
    "sindrets/diffview.nvim",
  },
  {
    "voldikss/vim-floaterm",
  },
  {
    "nvimdev/lspsaga.nvim",
    ft = {
      "lua",
      "typescript",
      "typescriptreact",
      "javascript",
      "javascriptreact",
      "java",
      "yml",
      "json",
      "python",
    },
    config = function()
      require("lspsaga").setup({
        lightbulb = {
          enable = false,
        },
      })
    end,
  },
  {
    "mg979/vim-visual-multi",
    branch = "master",
  },
  {
    "brenton-leighton/multiple-cursors.nvim",
    version = "*",
    opts = {},
    keys = {
      {
        "zj",
        "<Cmd>MultipleCursorsAddDown<CR>",
        mode = { "n", "x" },
        desc = "Add cursor and move down",
      },
      { "zk",     "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "x" },      desc = "Add cursor and move up" },

      { "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "i", "x" }, desc = "Add cursor and move up" },
      {
        "<C-Down>",
        "<Cmd>MultipleCursorsAddDown<CR>",
        mode = { "n", "i", "x" },
        desc = "Add cursor and move down",
      },

      {
        "<C-LeftMouse>",
        "<Cmd>MultipleCursorsMouseAddDelete<CR>",
        mode = { "n", "i" },
        desc = "Add or remove cursor",
      },

      {
        "<Leader>a",
        "<Cmd>MultipleCursorsAddMatches<CR>",
        mode = { "n", "x" },
        desc = "Add cursors to cword",
      },
      {
        "<Leader>A",
        "<Cmd>MultipleCursorsAddMatchesV<CR>",
        mode = { "n", "x" },
        desc = "Add cursors to cword in previous area",
      },

      {
        "<Leader>d",
        "<Cmd>MultipleCursorsAddJumpNextMatch<CR>",
        mode = { "n", "x" },
        desc = "Add cursor and jump to next cword",
      },
      { "<Leader>D", "<Cmd>MultipleCursorsJumpNextMatch<CR>", mode = { "n", "x" }, desc = "Jump to next cword" },

      {
        "<Leader>l",
        "<Cmd>MultipleCursorsLock<CR>",
        mode = { "n", "x" },
        desc = "Lock virtual cursors",
      },
    },
  },
  {
    "mattn/emmet-vim",
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,

            lookahead = true,

            keymaps = {
              ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
              ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
              ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
              ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

              ["a:"] = { query = "@property.outer", desc = "Select outer part of an object property" },
              ["i:"] = { query = "@property.inner", desc = "Select inner part of an object property" },
              ["l:"] = { query = "@property.lhs", desc = "Select left part of an object property" },
              ["r:"] = { query = "@property.rhs", desc = "Select right part of an object property" },

              ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
              ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

              ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
              ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

              ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
              ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

              ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
              ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

              ["am"] = {
                query = "@function.outer",
                desc = "Select outer part of a method/function definition",
              },
              ["im"] = {
                query = "@function.inner",
                desc = "Select inner part of a method/function definition",
              },

              ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
            },

            selection_modes = {
              ["@parameter.outer"] = "v",
              ["@function.outer"] = "V",
              ["@class.outer"] = "<c-v>",
            },
            move = {
              enable = true,
              set_jumps = true,
              goto_next_start = {
                ["]f"] = { query = "@call.outer", desc = "Next function call start" },
                ["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
                ["]c"] = { query = "@class.outer", desc = "Next class start" },
                ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
                ["]l"] = { query = "@loop.outer", desc = "Next loop start" },

                ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
              },
              goto_next_end = {
                ["]F"] = { query = "@call.outer", desc = "Next function call end" },
                ["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
                ["]C"] = { query = "@class.outer", desc = "Next class end" },
                ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
                ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
              },
              goto_previous_start = {
                ["[f"] = { query = "@call.outer", desc = "Prev function call start" },
                ["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
                ["[c"] = { query = "@class.outer", desc = "Prev class start" },
                ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
                ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
              },
              goto_previous_end = {
                ["[F"] = { query = "@call.outer", desc = "Prev function call end" },
                ["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
                ["[C"] = { query = "@class.outer", desc = "Prev class end" },
                ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
                ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
              },
            },

            include_surrounding_whitespace = true,
          },
        },
      })
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
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
})

vim.diagnostic.config({
  virtual_text = false,
})
vim.o.updatetime = 250
vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])

local map = vim.keymap.set
map("i", "<c-j>", "<down>")
map("i", "<c-k>", "<up>")
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")
map("n", "<leader>m", ":NvimTreeToggle<CR>")
map("n", "<leader>n", ":NvimTreeFocus<cr>")
map("n", "<esc>", ":noh<cr>")
map("n", "<M-right>", ":vertical resize +1<CR>")
map("n", "<M-left>", ":vertical resize -1<CR>")
map("n", "<M-Down>", ":resize +1<CR>")
map("n", "<M-Up>", ":resize -1<CR>")
map("n", "ee", "$")
map("n", "<c-h>", "<c-w>h")
map("n", "<c-l>", "<c-w>l")
map("n", "<C-a>", "ggVG")
map("n", "<C-k>", "<C-u>")
map("v", "<C-k>", "<C-u>")
map("n", "<C-j>", "<C-d>")
map("v", "<C-j>", "<C-d>")
map("n", "<A-,>", ":bNext<CR>")
map("n", "<A-.>", ":bnext<CR>")
map("n", "<leader>s", ":w!<cr>")

map("n", "ff", ":lua vim.lsp.buf.format()<CR>")
map("n", "gd", ":Lspsaga goto_definition<CR>")
map("n", "gt", ":Lspsaga goto_type_definition<CR>")
map({ "n", "v" }, "<leader>ca", ":Lspsaga code_action<CR>")
map("n", "<leader>rn", ":Lspsaga rename<cr>")
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)
map("n", "K", "<cmd>Lspsaga hover_doc<cr>")
map("n", "<leader>rs", ":LspRestart<CR>")

local hop = require("hop")
local directions = require("hop.hint").HintDirection
vim.keymap.set("n", "f", function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, { remap = true })
vim.keymap.set("n", "F", function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, { remap = true })
map({ "n", "v" }, "<leader><leader>w", ":HopAnywhere<CR>")
map("n", "<leader>w", ":HopWord<CR>")
map("t", "<C-x>", "<C-\\><C-n>")
map("n", "<leader>df", ":Lspsaga finder def+ref<cr>")
map("n", "<leader>to", ":FloatermToggle<cr>")
map("n", "<leader>ff", "<cmd>lua require('fzf-lua').files()<CR>")
map("n", "<leader>gi", function()
  require("typescript").actions.addMissingImports()
end)
map("n", "<leader>go", function()
  require("typescript").actions.organizeImports()
end)
map("n", "<leader>gr", function()
  require("typescript").actions.removeUnused()
end)
map("n", "<leadr>ga", function()
  c("truong dep trai")
  equire("typescript").actions.fixAll()
end)
map("n", "<F9>", ":w <bar> !g++ -std=c++14 % -o %:r -Wl,--stack,268435456<CR>", { noremap = true })
map("n", "<F10>", ":!%:r<CR>", { noremap = true })
map("n", "<leader>,", ":luafile ./lua/logme.lua<cr>")
map("n", "<leader>ts", ":luafile ./lua/test/init.lua<cr>")
map("n", "vx", ':lua require("treesitter-unit").select()<CR>')
map("n", "dx", ':lua require("treesitter-unit").delete()<CR>')
map("n", "cx", ':lua require("treesitter-unit").change()<CR>')

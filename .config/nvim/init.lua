-- =============================================================================
-- FRONTMATTER
-- =============================================================================
-- Adapted from:
-- https://martinlwx.github.io/en/config-neovim-from-scratch/

-- TODO:
-- [ ] fix which-key
-- [ ] show errors on hover
-- [ ] file browsing

-- =============================================================================
-- VIM GLOBALS
-- =============================================================================
vim.g.mapleader = " "

-- =============================================================================
-- VIM OPTIONS
-- =============================================================================
-- https://martinlwx.github.io/en/config-neovim-from-scratch/
-- Hint: use `:h <option>` to figure out the meaning if needed
vim.opt.clipboard = 'unnamedplus' -- use system clipboard
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.mouse = 'a'               -- allow the mouse to be used in Nvim

-- Tab
vim.opt.tabstop = 4      -- number of visual spaces per TAB
vim.opt.softtabstop = 4  -- number of spacesin tab when editing
vim.opt.shiftwidth = 4   -- insert 4 spaces on a tab
vim.opt.expandtab = true -- tabs are spaces, mainly because of python

-- UI config
vim.opt.number = true         -- show absolute number
vim.opt.relativenumber = true -- add numbers to each line on the left side
vim.opt.cursorline = true     -- highlight cursor line underneath the cursor horizontally
vim.opt.splitbelow = true     -- open new vertical split bottom
vim.opt.splitright = true     -- open new horizontal splits right
-- vim.opt.termguicolors = true        -- enabl 24-bit RGB color in the TUI
vim.opt.showmode = false      -- we are experienced, wo don't need the "-- INSERT --" mode hint


-- Searching
vim.opt.incsearch = true  -- search as characters are entered
vim.opt.hlsearch = false  -- do not highlight matches
vim.opt.ignorecase = true -- ignore case in searches by default
vim.opt.smartcase = true  -- but make it case sensitive if an uppercase is entered




-- =============================================================================
-- PLUGINS
-- =============================================================================
-- Bootstrap lazy.nvim package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


-- require lazy.nvim after bootstrapping
require("lazy").setup({
    -- LSP manager
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",

    -- treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = {
                    "c",
                    "elixir",
                    "glsl",
                    "heex",
                    "html",
                    "javascript",
                    "lua",
                    "query",
                    "rust",
                    "vim",
                    "vimdoc",
                    "wgsl",
                    "zig",
                },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },

    -- Vscode-like pictograms
    {
        "onsails/lspkind.nvim",
        event = { "VimEnter" },
    },
    -- Auto-completion engine
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "lspkind.nvim",
            "hrsh7th/cmp-nvim-lsp", -- lsp auto-completion
            "hrsh7th/cmp-buffer",   -- buffer auto-completion
            "hrsh7th/cmp-path",     -- path auto-completion
            "hrsh7th/cmp-cmdline",  -- cmdline auto-completion
            -- Code snippet engine
            {
                "L3MON4D3/LuaSnip",
                version = "v2.*",
            },
        },
        -- runs after plugin is loaded (configures cmp)
        config = function()
            require("config.nvim-cmp")
        end,
    },
    -- Monokai for theming
    "tanvirtin/monokai.nvim",

    -- comment toggling and whatnot
    -- TODO: fix keybinds
    -- "numToStr/Comment.nvim",

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            spec = {
                {"<Space>d", group = "diagnostic" },
                {"<Space>de", vim.diagnostic.open_float },
                {"<Space>dq", vim.diagnostic.setloclist },


                -- query keymap
                {
                    "<Space>?",
                    function()
                        require("which-key").show({ global = false })
                    end,
                    desc = "Buffer Local Keymaps (which-key)",
                },
            },
        },
        keys = {},
        dependencies = { "echasnovski/mini.icons", "nvim-tree/nvim-web-devicons" },
    },
    -- file navigation
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" }
    }
})

-- =============================================================================
-- COLORSCHEME
-- =============================================================================
-- This section must follow plugins, since color schemes are loaded from plugins.

-- define your colorscheme here
local colorscheme = 'monokai_pro'
-- local colorscheme = 'monokai'

-- use colorscheme *if* it's installed
local is_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not is_ok then
    vim.notify('colorscheme ' .. colorscheme .. ' not found!')
    return
end

-- =============================================================================
-- KEYMAPS
-- =============================================================================
-- local wk = require("which-key")

-- define common options
local opts = {
    noremap = true, -- non-recursive
    silent = true,  -- do not show message
}


-----------------
-- Normal mode --
-----------------

-- Hint: see `:h vim.keymap.set()`
-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

---------------------
-- Language Server --
---------------------

-- Diagnostics
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- vim.keymap.set('n', '<Space>de', vim.diagnostic.open_float, opts)
-- vim.keymap.set('n', '<Space>dn', vim.diagnostic.goto_prev, opts)
-- vim.keymap.set('n', '<Space>dp', vim.diagnostic.goto_next, opts)
-- vim.keymap.set('n', '<Space>dq', vim.diagnostic.setloclist, opts)

local bind_lsp_keys = function(bufnr)
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    -- vim.keymap.set('n', 'K', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
    end, bufopts)
end

-- =============================================================================
-- Language Servers
-- =============================================================================
require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require('mason-lspconfig').setup({
    -- A list of servers to automatically install if they're not already installed
    ensure_installed = {
        -- python
        'pylsp',
        'ruff',
        -- lua
        'lua_ls',
        -- rust
        'rust_analyzer',
        -- C/C++
        'clangd',
        -- Zig
        'zls',
        -- Go
        -- 'gopls',
        -- HTML
        -- 'html',
        -- glsl
        'glsl_analyzer',
        -- wgsl
        'wgsl_analyzer',

    },
})

-- Set different settings for different languages' LSP
-- TODO(axelmagn): will need to be rewritten when you add Which or some such
-- LSP list: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- How to use setup({}): https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-%7B%7D
--     - the settings table is sent to the LSP
--     - on_attach: a lua callback function to run after LSP attaches to a given buffer
local lspconfig = require('lspconfig')


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach_lsp = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    bind_lsp_keys(bufnr)
end

-- Configure each language
-- How to add LSP for a specific language?
-- 1. use `:Mason` to install corresponding LSP
-- 2. add configuration below
lspconfig.pylsp.setup({
    on_attach = on_attach_lsp,
    settings = {
        -- disable linting: conflicts with ruff.  we just want jump to defn
        pylsp = {
            plugins = {
                pyflakes = { enabled = false },
                pylint = { enabled = false },
                pycodestyle = { enabled = false },
            }
        }
    }
})
lspconfig.ruff.setup({
    on_attach = on_attach_lsp,
})
lspconfig.clangd.setup({
    on_attach = on_attach_lsp,
})
lspconfig.rust_analyzer.setup({
    on_attach = on_attach_lsp,
})
lspconfig.zls.setup({
    on_attach = on_attach_lsp,
})
lspconfig.gopls.setup({
    on_attach = on_attach_lsp,
})
lspconfig.html.setup({
    on_attach = on_attach_lsp,
})
lspconfig.glsl_analyzer.setup({
    on_attach = on_attach_lsp,
})
lspconfig.wgsl_analyzer.setup({
    on_attach = on_attach_lsp,
})
lspconfig.lua_ls.setup({
    on_attach = on_attach_lsp,
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc')) then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME
                    -- Depending on the usage, you might want to add additional paths here.
                    -- "${3rd}/luv/library"
                    -- "${3rd}/busted/library",
                }
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
                -- library = vim.api.nvim_get_runtime_file("", true)
            }
        })
    end,
    settings = {
        Lua = {}
    }
})


-- show help command when mouse is hovered over error or warning
-- TODO: show this by default when cursor hovers
vim.api.nvim_create_autocmd({ "CursorHold" }, {
    pattern = "*",
    callback = function()
        for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
            if vim.api.nvim_win_get_config(winid).zindex then
                return
            end
        end
        vim.diagnostic.open_float({
            scope = "cursor",
            focusable = false,
            close_events = {
                "CursorMoved",
                "CursorMovedI",
                "BufHidden",
                "InsertCharPre",
                "WinLeave",
            },
        })
    end
})

----------------------
-- GDSCRIPT
----------------------
-- local port = tonumber(os.getenv('GDScript_Port')) or 6005
-- local cmd = vim.lsp.rpc.connect('127.0.0.1', port)
-- local pipe = '/path/to/godot.pipe' -- I use /tmp/godot.pipe
--
-- vim.lsp.start({
--     name = 'Godot',
--     cmd = cmd,
--     root_dir = vim.fs.dirname(vim.fs.find({ 'project.godot', '.git' }, { upward = true })[1]),
--     on_attach = function(client, bufnr)
--         vim.api.nvim_command('echo serverstart("' .. pipe .. '")')
--     end
-- })

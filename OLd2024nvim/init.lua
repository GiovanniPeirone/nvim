--options
require("core.options")
--keymap
require("core.keymaps")

-- [[ Plugins con lazy.nvim ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", lazypath
    })
end

vim.opt.rtp:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
    print("Error: No se pudo cargar lazy.nvim")
    return
end

lazy.setup({
    -- Temas
    { "morhetz/gruvbox" },  
    {
        "ishan9299/nvim-solarized-lua",
        priority = 1000, 
        config = function()
            vim.o.background = "dark"
            vim.cmd("colorscheme solarized-high")
        end
    },

    -- Plugins de LSP y autocompletado
    { "neovim/nvim-lspconfig" },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "saadparwaiz1/cmp_luasnip" },
    { "L3MON4D3/LuaSnip" },

    -- Mason: Instalador de LSPs, linters y formatters
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "omnisharp", "rust_analyzer", "gopls", "cssls", "lua_ls", "clangd", "pyright" },
            })
        end
    },

    -- Configuración de LSPs con nvim-lspconfig
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local on_attach = function(client, bufnr)
                local opts = { noremap = true, silent = true, buffer = bufnr }
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

                -- Diagnósticos flotantes
                vim.api.nvim_create_autocmd("CursorHold", {
                    buffer = bufnr,
                    callback = function()
                        vim.diagnostic.open_float(nil, { focusable = false, border = "rounded" })
                    end,
                })
            end

            -- Configuración de LSPs específicos
            lspconfig.clangd.setup {
                capabilities = capabilities,
                on_attach = on_attach,
                cmd = { "clangd" },
                filetypes = { "c", "cpp", "objc", "objcpp" },
                root_dir = require("lspconfig").util.root_pattern(".git", "compile_commands.json", "compile_flags.txt"),
            }

            lspconfig.pyright.setup {
                capabilities = capabilities,
                on_attach = on_attach
            }

            lspconfig.gopls.setup {
                capabilities = capabilities,
                on_attach = on_attach
            }
        end
    }
})

-- [[ Configuración de XAML como XML ]]
vim.filetype.add({
    extension = {
        xaml = "xml"
    },
})

-- [[ Configuración de nvim-cmp para autocompletado ]]
local cmp = require("cmp")

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<Tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
        ["<C-Space>"] = cmp.mapping.complete(),
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
        { name = "luasnip" },
    })
})

-- [[ Configuración de lualine ]]
require("lualine").setup()

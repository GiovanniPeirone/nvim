
-- Cargar plugins con Lazy
require("lazy").setup({
    -- 🌅 Colorscheme Solarized
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },

    --{
    --    "rose-pine/neovim",
    --    name = "rose-pine",
    --    config = function()
    --        vim.cmd("colorscheme rose-pine-main")
    --    end
    --},

    -- ⚙️ Mason para gestionar LSPs
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function()
            require("mason").setup()
        end
    },

    -- 📦 Configuración de LSPs con ts_ls (typescript-language-server)
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig"
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls", "pyright", "clangd", "gopls", "jsonls", "html", "cssls", "ts_ls"
                },
                automatic_installation = true,
            })

            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local servers = {
                lua_ls = {},
                pyright = {},
                clangd = {},
                gopls = {},
                jsonls = {},
                html = {},
                cssls = {},
                ts_ls = {}, -- ✅ este es el bueno
            }

            for server, config in pairs(servers) do
                config.capabilities = capabilities
                lspconfig[server].setup(config)
            end

            -- 🧠 Diagnóstico visual
            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })

            -- Íconos en la columna de diagnóstico
            local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end
        end,
    },

    -- ⚡ Autocompletado con nvim-cmp
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind.nvim",
        },
        config = function()
            local cmp = require("cmp")
            local lspkind = require("lspkind")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp.mapping.select_next_item(),
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, {
                    { name = "buffer" },
                    { name = "path" },
                }),
                formatting = {
                    format = lspkind.cmp_format({
                        maxwidth = 50,
                        ellipsis_char = "…"
                    }),
                },
            })
        end
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")

            harpoon:setup() -- usa config por defecto, podés personalizar si querés

            -- 🔥 Atajos útiles (opcional)
            vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end, { desc = "Harpoon Add File" })
            vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon Menu" })

            -- Ir rápido a los primeros 4 archivos
            vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
            vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
            vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
            vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
        end
    },
    {
        'fatih/vim-go',
        ft = 'go',
        build = ':GoUpdateBinaries',
        config = function()
            vim.g.go_fmt_command = "gopls"  -- usa gopls para formateo
            vim.g.go_def_mode = "gopls"
            vim.g.go_info_mode = "gopls"
            vim.g.go_auto_type_info = 1     -- muestra tipo automáticamente
            vim.g.go_doc_keywordprg_enabled = 0
            vim.g.go_imports_autosave = 1   -- autoagrega imports
            vim.g.go_fmt_autosave = 1       -- autoformato al guardar
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup({
                defaults = {
                    layout_config = {
                        prompt_position = "top",
                    },
                    sorting_strategy = "ascending",
                    winblend = 10,
                },
            })

            -- 🔑 Atajos útiles
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope: Buscar archivos" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope: Buscar texto (live_grep)" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope: Buscar buffers" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope: Buscar ayuda" })
        end,
    }
})





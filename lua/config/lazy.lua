-- Cargar plugins con Lazy
require("lazy").setup({
  -- Colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("tokyonight")
    end
  },
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function()
        require("mason").setup()
         end
    },
  {
      "williamboman/mason-lspconfig.nvim",
      dependencies = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig"
      },
      config = function()
        require("mason-lspconfig").setup({
          ensure_installed = {
            "lua_ls", "pyright", "clangd", "gopls", "jsonls", "html", "cssls"
          },
          automatic_installation = true,
        })

        local lspconfig = require("lspconfig")

        local servers = {
          lua_ls = {},
          pyright = {},
          clangd = {},
          gopls = {},
          jsonls = {},
          html = {},
          cssls = {},
        }

        for server, config in pairs(servers) do
          lspconfig[server].setup(config)
        end
      end,
    }

})


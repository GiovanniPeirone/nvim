-- [[ Opciones básicas ]]
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.clipboard = "unnamedplus"

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>l", vim.cmd.Ex)
vim.keymap.set("n", "<leader>v", ":vsplit<Space>", { noremap = true, silent = true })

-- [[ Instalar Lazy si no está ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- [[ Plugins ]]
require("lazy").setup({
  { "folke/lazy.nvim" },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
  { "pmizio/typescript-tools.nvim", dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" } },
})

-- [[ Colorscheme ]]
vim.cmd.colorscheme "catppuccin-mocha"

-- [[ Mason ]]
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "pyright" }, -- Ya no agregamos tsserver aquí
})

-- [[ LSP Config ]]
local lspconfig = require("lspconfig")

-- Python con pyright
lspconfig.pyright.setup({
  on_attach = function(_, bufnr)
    print("pyright conectado!")
  end,
})

-- TypeScript con typescript-tools.nvim
require("typescript-tools").setup({})


-- [[ Colorscheme ]]
vim.cmd("colorscheme sorbet")

-- [[ Opciones básicas ]]
vim.opt.number = true            -- Números de línea
vim.opt.relativenumber = true    -- Números relativos
vim.opt.tabstop = 4              -- Tamaño del tabulador
vim.opt.shiftwidth = 4           -- Tamaño de la indentación
vim.opt.expandtab = true         -- Usa espacios en lugar de tabs
vim.opt.smartindent = true       -- Indentación inteligente
vim.opt.clipboard = "unnamedplus"

-- Configuración para netrw (explorador de archivos por defecto en Neovim)
vim.g.netrw_liststyle = 3     -- 3: Vista de árbol (en lugar de lista)
vim.g.netrw_hide = 0          -- 0: Muestra los archivos ocultos por defecto

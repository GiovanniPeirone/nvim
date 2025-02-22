-- [[ Atajo de teclado para abrir el Explorer ]]
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>l", vim.cmd.Ex)

-- Abre un archivo en una nueva ventana verticalmente con <leader>v
vim.keymap.set("n", "<leader>v", ":vsplit<Space>", { noremap = true, silent = true })

-- [[ Atajos de teclado para cambiar el tamaño de la fuente ]]
vim.keymap.set("n", "<C-+>", ":lua vim.o.guifontsize = vim.o.guifontsize + 1<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-->", ":lua vim.o.guifontsize = vim.o.guifontsize - 1<CR>", { noremap = true, silent = true }) 

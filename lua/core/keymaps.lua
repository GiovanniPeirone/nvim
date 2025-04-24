vim.g.mapleader = " "

vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- abre un archivo en una nueva ventana verticalmente con <leader>v
vim.keymap.set("n", "<leader>v", ":vsplit<space>", { noremap = true, silent = true })

-- [[ Atajos de teclado para cambiar el tamaño de la fuente ]]
vim.keymap.set("n", "<C-+>", ":lua vim.o.guifontsize = vim.o.guifontsize + 1<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-->", ":lua vim.o.guifontsize = vim.o.guifontsize - 1<CR>", { noremap = true, silent = true }) 


---
---
---This is the nvim config of Giovanni Peirone
---
---

-- Agregar Lazy al runtime path

-- Ruta del Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Clonar Lazy si no está instalado
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end

vim.opt.rtp:prepend(lazypath)


--Options
require("core.options")
--Keymap
require("core.keymaps")

--Lazy.nvim
require("config.lazy")



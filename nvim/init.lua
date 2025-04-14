vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

vim.keymap.set("n", "<A-up>", ":m -2<CR>==", { noremap = true, silent = true })
vim.keymap.set("n", "<A-down>", ":m +1<CR>==", { noremap = true, silent = true })
vim.keymap.set("n", "<C-S-d>", "yyp", { noremap = true, silent = true })
vim.keymap.set("n", "<C-z>", "u", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Left>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-Right>", "<C-w>l", { noremap = true, silent = true })
vim.keymap.set("n", "<C-q>", ":bp|bd #<CR>", { noremap = true, silent = true })

vim.keymap.set("v", "<C-c>", '"+y', { noremap = true, silent = true })
vim.keymap.set("n", "<C-v>", '"+p', { noremap = true, silent = true })
vim.keymap.set("v", "<C-v>", '"+p', { noremap = true, silent = true })
vim.keymap.set("i", "<C-v>", '<C-r>+', { noremap = true, silent = true })

vim.keymap.set("v", "d", '"_d', { noremap = true })
vim.keymap.set("v", "D", '"_D', { noremap = true })
vim.keymap.set("n", "x", '"_x', { noremap = true }) -- Also for deleting single characters
vim.keymap.set("n", "s", '"_s', { noremap = true }) -- Stop `s` from copying
vim.keymap.set("n", "<C-a>", "ggVG", { noremap = true, silent = true })


-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    defaults = { timeout = 60000 }
  },
  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

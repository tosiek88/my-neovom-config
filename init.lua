-- load all plugins
require "pluginList"
require "misc-utils"

--require "top-bufferline"
--require("colorizer").setup()

local cmd = vim.cmd
local g = vim.g
g.mapleader = " "
g.auto_save = 0

-- colorscheme related stuff
cmd "syntax on"
cmd "set noswapfile"
cmd "set wrap!"
-- Example config in Lua
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }

-- Load the colorscheme
vim.cmd[[colorscheme tokyonight]]

--g.nvchad_theme = "onedark"
--local base16 = require "base16"
--base16(base16.themes.onedark, true)

--require "highlights"
require "mappings"
require "file-icons"
--require "statusline"

-- hide line numbers , statusline in specific buffers!
vim.api.nvim_exec(
    [[
   au BufEnter term://* setlocal nonumber
   au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif
   au BufEnter term://* set laststatus=0 
]],
    false
)

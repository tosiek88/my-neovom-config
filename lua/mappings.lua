local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opt = {}
-- dont copy any deleted text , this is disabled by default so uncomment the below mappings if you want them
--[[ remove this line

map("n", "dd", [=[ "_dd ]=], opt)
map("v", "dd", [=[ "_dd ]=], opt)
map("v", "x", [=[ "_x ]=], opt)
 this line too ]]
--
-- OPEN TERMINALS --
map("n", "<leader>e", [[<Cmd> split term://zsh | resize 10 <CR>]], opt) --  term bottom

-- copy whole file content
map("i", "jk", "<Esc>", opt)

-- toggle numbers
map("n", "<leader>n", [[ <Cmd> set nu!<CR>]], opt)

map("n", "<C-s>", [[ <Cmd> w <CR>]], opt)
map("n", "<C-g>", [[ <Cmd> noh<CR>]], opt)
-- vim.cmd("inoremap jh <Esc>")

-- Commenter Keybinding
map("n", "<C-x>;", ":CommentToggle<CR>", {noremap = true, silent = true})
map("n", "gcc", ":CommentToggle<CR>", {noremap = true, silent = true})
map("v", "<C-x>;", ":CommentToggle<CR>", {noremap = true, silent = true})
map("v", "gcc", ":CommentToggle<CR>", {noremap = true, silent = true})

map("n", "<C-q>", ":BufDel", opt)
map("n", "<C-c><C-c>", ":lua require('rest-nvim').run()<CR>", opt)

-- Windows JUMPS
map("n", "<leader>wh", "<C-w><C-h>", opt)
map("n", "<leader>wk", "<C-w><C-k>", opt)
map("n", "<leader>wj", "<C-w><C-j>", opt)
map("n", "<leader>wl", "<C-w><C-l>", opt)
map("n", "<leader>wl", "<C-w><C-l>", opt)
map("n", "<leader>w=", "<C-w><C-=>", opt)

-- Lua LSP diag trouble
map("n", "<leader>xx", "<cmd>Trouble<cr>", {silent = true, noremap = true})
map("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>", {silent = true, noremap = true})
map("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>", {silent = true, noremap = true})
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", {silent = true, noremap = true})
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", {silent = true, noremap = true})
map("n", "gR", "<cmd>Trouble lsp_references<cr>", {silent = true, noremap = true})

-- Windows Move
map("n", "<leader>wH", "<C-w>H", opt)
map("n", "<leader>wK", "<C-w>K", opt)
map("n", "<leader>wJ", "<C-w>J", opt)
map("n", "<leader>wL", "<C-w>L", opt)

---Tabs
map("n", "<leader><tab>N", [[<Cmd> tabnew<CR>]], opt) -- term newtab
map("n", "<leader><tab>j", [[<Cmd> tabnext<CR>]], opt) -- term newtab
map("n", "<leader><tab>k", [[<Cmd> tabprevious<CR>]], opt) -- term newtab
map("n", "<leader><tab>d", [[<Cmd> tabclose<CR>]], opt) -- term newtab

--Telescope
map("n", "<leader><leader>", ":Telescope find_files<cr>")
map("n", "<leader>sb", ":Telescope current_buffer_fuzzy_find<CR>")
map("n", "<leader>bb", ":Telescope buffers<cr>")
map("n", "<tab>", "<nop>")
map("n", "<leader>bd", ":bp | bd! #<cr>")
map("c", "<C-t>", ":Telescope command_history<cr>")

map("n", "<leader>wv", ":vsplit<cr>")
map("n", "<leader>ws", ":split<cr>")
map("n", "<leader>wd", "<C-w>q")

map("n", "gss", ":HopChar2<cr>", opt)

-- compe stuff

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col(".") - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif check_back_space() then
        return t "<C-j>"
    else
        return vim.fn["compe#complete"]()
    end
end

_G.cmd_tab_complete = function()
    if vim.fn.wildmenumode() then
        return t "<C-n>"
    end
end

_G.s_cmd_tab_complete = function()
    if vim.fn.wildmenumode() then
        return t "<C-p>"
    end
end

_G.cmd_completions = function()
    if vim.fn.wildmenumode() == 1 then
        return t "<C-y>"
    else
        return vim.fn.wildmenumode()
    end
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif vim.fn.call("vsnip#jumpable", {1}) == 1 then
        return t "<Plug>(vsnip-jump-prev)"
    else
        return t "<C-k>"
    end
end

function _G.completions()
    if vim.fn.pumvisible() == 1 then
        return vim.fn["compe#confirm"]({keys = "<Tab>", select = true})
    elseif require("luasnip").expand_or_jumpable() then
        return vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true)
    else
        return vim.api.nvim_replace_termcodes("<Tab>", true, true, true)
    end
end

map("i", "<CR>", "compe#confirm({ 'keys': '<CR>', 'select': v:true })", {expr = true})

map("c", "<C-j>", "v:lua.cmd_tab_complete()", {expr = true})
map("c", "<C-k>", "v:lua.s_cmd_tab_complete()", {expr = true})
map("c", "<expr><Tab>", "v:lua.cmd_completions()", {expr = true})

--  compe mappings
map("i", "<C-j>", "v:lua.tab_complete()", {expr = true})
map("s", "<C-j>", "v:lua.tab_complete()", {expr = true})
map("i", "<C-k>", "v:lua.s_tab_complete()", {expr = true})
map("s", "<C-k>", "v:lua.s_tab_complete()", {expr = true})
map("i", "<Tab>", "v:lua.completions()", {expr = true})

-- Mappings for nvimtree
map(
    "n",
    "<C-n>",
    ":CHADopen<CR>",
    {
        noremap = true,
        silent = true
    }
)

map("n", "<leader>fm", [[<Cmd> Neoformat<CR>]], opt)

function Buffer_dir()
    -- require "telescope.builtin".find_files({search_dirs = {vim.fn.expand("%:p:h")}})
    require "telescope.builtin".file_browser({cwd = vim.fn.expand("%:p:h"), hidden = true})
end

map("n", "<leader>*", [[<Cmd>Telescope live_grep<CR>]], opt)
map("n", "<leader>.", ":lua Buffer_dir()<CR> ", opt)
map("n", "gD", [[<Cmd>Telescope lsp_references<CR>]], opt)
map("n", "ga", [[<Cmd>lua vim.lsp.buf.code_action()<CR>]], opt)
map("n", "<leader>sk", [[<Cmd>Telescope keymaps<CR>]], opt)

-- dashboard stuff
map("n", "<leader>db", [[<Cmd> Dashboard<CR>]], opt)
map("n", "<leader>fn", [[<Cmd> DashboardNewFile<CR>]], opt)
map("n", "<leader>bm", [[<Cmd> DashboardJumpMarks<CR>]], opt)
map("n", "<leader>sl", [[<Cmd> SessionLoad<CR>]], opt)
map("n", "<leader>ss", [[<Cmd> SessionSave<CR>]], opt)
map("n", "<leader>rr", ":luafile %<CR>", opt)

-- Telescope
-- map("n", "<leader>gt", [[<Cmd> Telescope git_status <CR>]], opt)

map("n", "<leader>cm", [[<Cmd> Telescope git_commits <CR>]], opt)
map("n", "<leader>ff", [[<Cmd> Telescope find_files <CR>]], opt)
map("n", "<leader>pp", [[<Cmd>Telescope project<CR>]], opt)

map("t", "jk", "<C-\\><C-n>", opt)
map("n", "<leader>pe", [[<Cmd>term<CR>]], opt)

map("n", "<leader>fp", [[<Cmd>lua require('telescope').extensions.media_files.media_files()<CR>]], opt)
map("n", "<leader>fb", [[<Cmd>Telescope Buffers<CR>]], opt)
map("n", "<leader>fh", [[<Cmd>Telescope help_tags<CR>]], opt)
map("n", "<leader>fo", [[<Cmd>Telescope oldfiles<CR>]], opt)

--LSP Saga 
map("n", "<leader>grs", [[<Cmd>Lspsaga rename<CR>]], opt)
map("n", "<leader>ga", [[<Cmd>Lspsaga code_action<CR>]], opt)
map("n", "<leader>K", [[<Cmd>Lspsaga hover_doc<CR>]], opt)
map("n", "<leader>gp", [[<Cmd>Lspsaga preview_definition<CR>]], opt)

map("n", "<C-c><Enter>", [[<Cmd>lua require('rest').run()<CR>]], opt)

map("n", "<leader>gg", [[<Cmd>Neogit<CR>]], opt)
map("n", "<leader>gb", [[<Cmd>GitBlameToggle<CR>]], opt)


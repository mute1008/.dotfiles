-- ~/.config/nvim/init.lua

-- =============================================================
-- 1. PLUGIN MANAGER SETUP (lazy.nvim)
-- =============================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable",
            lazypath,
        })
end
vim.opt.rtp:prepend(lazypath)

local map = vim.keymap.set
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.polyglot_disabled = { 'csv' }

-- =============================================================
-- 2. PLUGIN DEFINITIONS
-- =============================================================
local plugins = {
    -- { 'ribru17/bamboo.nvim', lazy = false, priority = 1000, config = function() vim.cmd("colorscheme bamboo") end, },
    { 'Mofiqul/vscode.nvim', lazy = false, priority = 1000, config = function() vim.cmd("colorscheme vscode") end, },
    {
        'preservim/nerdtree',
        cmd = 'NERDTree',
        dependencies = {
            'Xuyuanp/nerdtree-git-plugin',
            'jistr/vim-nerdtree-tabs',
        },
        keys = { { "<C-n>", mode = "n", silent = true } },
        config = function() 
            vim.g.NERDTreeShowHidden = 1 
            vim.keymap.set('n', '<C-n>', '<cmd>NERDTreeMirrorToggle<CR>', { desc = "Toggle NERDTree Mirror" })
        end,
    },
    { 'sheerun/vim-polyglot' },
    { 'airblade/vim-gitgutter' },
    {
        'tyru/caw.vim',
        config = function()
            vim.keymap.set('n', '<C-K>', '<Plug>(caw:hatpos:toggle)', { desc = "CAW Comment Toggle (Normal)" })
            vim.keymap.set('v', '<C-K>', '<Plug>(caw:hatpos:toggle)', { desc = "CAW Comment Toggle (Visual)" })
        end
    },
    { 'editorconfig/editorconfig-vim' },
    {
        'dense-analysis/ale',
        config = function()
            vim.g.ale_linters = {
                javascript = { 'eslint' },
                typescript = { 'eslint' },
            }
            vim.g.ale_fixers = {
                javascript = { 'eslint' },
                typescript = { 'eslint' },
            }
            vim.g.ale_fix_on_save = 1
        end,
    },
}

require("lazy").setup(plugins, { change_detection = { notify = false } })

-- =============================================================
-- 3. CUSTOM FUNCTIONS
-- =============================================================
local function MaximumWindow(key)
    vim.cmd("wincmd " .. key)
    if vim.fn.winheight(0) == 1 or vim.fn.winwidth(0) == 1 then
        local target_keys
        if key == "j" or key == "k" then target_keys = "<C-w>_"
    else target_keys = "<C-w>|" end
    local converted_keys = vim.api.nvim_replace_termcodes(target_keys, true, true, true)
    vim.api.nvim_feedkeys(converted_keys, 'n', { nowait = true, silent = true })
end
end

-- =============================================================
-- 4. VIM OPTIONS
-- =============================================================
vim.cmd([[
    " OPTIONS
    set background=dark
    set tabstop=2 shiftwidth=2 autoindent expandtab number mouse=a ambiwidth=double cindent hidden clipboard+=unnamedplus sh=zsh
    set cursorline
    set list listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
    set undofile undodir=~/.cache/undo/

    " TERMINAL EXIT
    tnoremap <silent> <ESC> <C-\><C-n>
]])

-- =============================================================
-- 5. KEYMAPS (Window, General)
-- =============================================================
-- CUSTOM WINDOW FUNCTIONS
map("n", "sh", function() MaximumWindow("h") end, { desc = "Toggle Maximize Left/Right" })
map("n", "sj", function() MaximumWindow("j") end, { desc = "Toggle Maximize Up/Down" })
map("n", "sk", function() MaximumWindow("k") end, { desc = "Toggle Maximize Up/Down" })
map("n", "sl", function() MaximumWindow("l") end, { desc = "Toggle Maximize Left/Right" })

-- WINDOW MANAGEMENT
map("n", "s", "<Nop>")
map("n", "st", "<cmd>tabnew<CR>", { desc = "New Tab" })
map("n", "s=", "<C-w>=", { desc = "Equalize Splits" })
map("n", "sv", "<cmd>vsplit<CR>", { desc = "Vertical Split" })
map("n", "vs", "<cmd>vsplit<CR>", { desc = "Vertical Split" })
map("n", "K", "gt", { desc = "Next Tab" })
map("n", "J", "gT", { desc = "Previous Tab" })
map("n", "sq", "<C-w>q", { desc = "Close Window" })
map("n", "tt", "<cmd>tabnew | terminal<CR>i", { desc = "Terminal in new tab" })
map("n", "s>", "<C-w>>", { desc = "Window increase width" })
map("n", "s<", "<C-w><", { desc = "Window decrease width" })
map("n", "s-", "<C-w>_", { desc = "Window maximize height" })

-- GENERAL
map("i", "jj", "<Esc>", { silent = true, desc = "Exit Insert Mode" })
map({"n", "v"}, "x", '"_x', { desc = "Delete without Yanke" })
map("n", "D", "<C-d>", { desc = "Scroll Down Half Page" })
map("n", "U", "<C-u>", { desc = "Scroll Up Half Page" })
map("n", "L", "<C-l>", { desc = "Scroll Down Half Page" })

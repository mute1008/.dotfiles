-- ~/.config/nvim/init.lua

-- =============================================================
-- 1. LEADER KEY SETUP
-- =============================================================
vim.g.mapleader = " "

-- =============================================================
-- 2. PLUGIN MANAGER SETUP (lazy.nvim)
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

-- =============================================================
-- 3. PLUGIN DEFINITIONS
-- =============================================================
local plugins = {
    {
        'Mofiqul/vscode.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme vscode")
        end
    },
    {
        'preservim/nerdtree',
        cmd = 'NERDTree',
        dependencies = {
            'Xuyuanp/nerdtree-git-plugin',
            'jistr/vim-nerdtree-tabs',
        },
        keys = { { "<leader>n", mode = "n", silent = true } },
        config = function()
            vim.g.NERDTreeShowHidden = 1
            vim.keymap.set('n', '<leader>n', '<cmd>NERDTreeFocus<CR>', { desc = "Open NERDTree"})
            vim.api.nvim_create_autocmd("FileType", {
                    pattern = "nerdtree",
                    callback = function()
                        vim.keymap.set('n', '<Esc>', '<C-w>p', { buffer = true, silent = true, desc = "Focus back to previous editor" })
                    end
                })
        end,
    },
    {
        'tyru/caw.vim',
        config = function()
            vim.keymap.set('n', '<C-K>', '<Plug>(caw:hatpos:toggle)', { desc = "CAW Comment Toggle (Normal)" })
            vim.keymap.set('v', '<C-K>', '<Plug>(caw:hatpos:toggle)', { desc = "CAW Comment Toggle (Visual)" })
        end
    },
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
    {
        'sheerun/vim-polyglot',
        init = function()
            vim.g.polyglot_disabled = { 'csv' }
        end,
    },
    {
        'easymotion/vim-easymotion',
        init = function()
            vim.g.EasyMotion_smartcase = 1
        end,
        config = function()
            vim.keymap.set('n', '<leader>w', '<Plug>(easymotion-bd-w)', { desc = "Easymotion Word" })
            vim.keymap.set('n', '<leader>s', '<Plug>(easymotion-bd-f2)', { desc = "Easymotion Find 2 chars" })
            vim.keymap.set('n', '<leader>a', '<Plug>(easymotion-bd-jk)', { desc = "Easymotion Line Down" })
        end,
    },
    { 'editorconfig/editorconfig-vim' },
    { 'airblade/vim-gitgutter' },
}

require("lazy").setup(plugins, { change_detection = { notify = false } })

-- =============================================================
-- 4. CUSTOM FUNCTIONS
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
-- 5. VIM OPTIONS
-- =============================================================
vim.cmd([[
    " OPTIONS
    set background=dark
    set tabstop=2
    set shiftwidth=2
    set autoindent
    set expandtab
    set number
    set mouse=a
    set ambiwidth=double
    set cindent
    set hidden
    set clipboard+=unnamedplus
    set sh=zsh
    set cursorline
    set list listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
    set undofile undodir=~/.cache/undo/

    " TERMINAL EXIT
    tnoremap <silent> <ESC> <C-\><C-n>
]])

-- =============================================================
-- 6. KEYMAPS (Window, General)
-- =============================================================
local map = vim.keymap.set

-- CUSTOM WINDOW FUNCTIONS
map("n", "sh", function() MaximumWindow("h") end, { desc = "Toggle Maximize Left/Right" })
map("n", "sj", function() MaximumWindow("j") end, { desc = "Toggle Maximize Up/Down" })
map("n", "sk", function() MaximumWindow("k") end, { desc = "Toggle Maximize Up/Down" })
map("n", "sl", function() MaximumWindow("l") end, { desc = "Toggle Maximize Left/Right" })

-- WINDOW MANAGEMENT
-- map("n", "s", "<Nop>")
map("n", "ss", "<cmd>split<CR>", { desc = "Split" })
map("n", "sv", "<cmd>vsplit<CR>", { desc = "Vertical Split" })
map("n", "s-", "<C-w>_", { desc = "Window maximize height" })
map("n", "s=", "<C-w>=", { desc = "Equalize Splits" })
map("n", "st", "<cmd>tabnew<CR>", { desc = "New Tab" })
map("n", "sq", "<C-w>q", { desc = "Close Window" })
map("n", "K", "gt", { desc = "Next Tab" })
map("n", "J", "gT", { desc = "Previous Tab" })

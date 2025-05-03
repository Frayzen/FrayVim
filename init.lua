-- commit @6c3bda4a
-- Set leader and load common settings
vim.g.mapleader = " "
require("commons")
require("mappings")

-- LAZY.nvim setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)




require("lazy").setup("plugins")  -- Loads all plugins from plugins directory

-- SETUP LSP
require("lsp")



-- vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
--     pattern = {"*.md", "*.tex"},
--     command = "set filetype=tex"
-- })

-- NVIM v0.10.5-dev-22+g0c995c0efb
-- Build type: Debug
-- LuaJIT 2.1.1713484068
-- Run "nvim -V1 -v" for more info
-- ~/.config/nvim tim-java*                                          02:24:46 PM
-- ❯ 
-----------------------------------------------------------


-- For Lua
-- vim.g.python3_host_prog = vim.fn.expand('~/.conda/envs/classiq/bin/python')
vim.g.python3_host_prog = vim.fn.expand('~/.conda/envs/qiskit/bin/python')
vim.g.loaded_python3_provider = 1  -- Force use of the specified Python

-- vim.env.PYTHONPATH = "/home/tim/.conda/envs/classiq/lib/python3.10/site-packages"
vim.env.PYTHONPATH = "/home/tim/.conda/envs/qiskit/lib/python3.10/site-packages"
-- vim.env.PYTHONPATH = "/home/tim/.conda/envs/ship-cudnn/lib/python3.10/site-packages"


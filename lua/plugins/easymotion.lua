return {
    "kuangliu/vim-easymotion",

    lazy = false,
    init = function ()
        --	vim.cmd('let g:EasyMotion_verbose = 0')
        vim.cmd('set cmdheight=1')
    end,
    keys = {
        { "<Leader>w", "<Plug>(easymotion-bd-w)",desc = "EasyMotion words", mode = { "v" , "n" }},
        { "s", "<Plug>(easymotion-s)", desc = "EasyMotion", mode = { "v" , "n"}},
    }
}

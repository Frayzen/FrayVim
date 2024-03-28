return {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
        require'lsp_signature'.setup(opts) 
        vim.keymap.set({ 'i' }, '<C-K>', function()
            require('lsp_signature').toggle_float_win()
        end, { silent = true, noremap = true, desc = 'toggle signature' })
    end
}

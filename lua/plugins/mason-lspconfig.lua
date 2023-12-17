return {
    'williamboman/mason-lspconfig.nvim',
    config = function()
        require("mason-lspconfig").setup {
            -- see https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers            
            ensure_installed = { "lua_ls", "clangd", "bashls", "autotools_ls" },
        }
    end
}

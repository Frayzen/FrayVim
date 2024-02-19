return {
    "williamboman/mason-lspconfig.nvim",

    dependencies = {
        "williamboman/mason.nvim",
        "hrsh7th/nvim-cmp",
    },

    config = function()
        require("mason-lspconfig").setup({
            -- see https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
            ensure_installed = { "lua_ls", "clangd", "bashls", "autotools_ls" },
        })
        require("mason").setup()
        require("mason-lspconfig").setup_handlers({
            -- The first entry (without a key) will be the default handler
            -- and will be called for each installed server that doesn't have
            -- a dedicated handler.
            function(server_name) -- default handler (optional)
                local params = lsp_params[server_name]
                if params == nil then
                    params = {}
                end
                params["capabilities"] = require("cmp_nvim_lsp").default_capabilities()
                require("lspconfig")[server_name].setup(params)
            end,
        })
    end,
}

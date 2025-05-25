return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "nvim-telescope/telescope-ui-select.nvim",
        "folke/neodev.nvim",
    },
    opts = {
        inlay_hints = { enabled = true },
    },
    config = function()
        require("telescope").load_extension("ui-select")

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                register_mapping({
                    n = {
                        { "<Leader>k",  "<cmd>lua vim.lsp.buf.signature_help()<CR>",         desc = "Signature help" },
                        { "<Leader>K",  "<cmd>lua vim.diagnostic.open_float()<CR>",          desc = "Signature help" },
                        { "<Leader>F",  ":Format<CR>", desc = "Format" },
                        { "gr",         "<cmd>lua vim.lsp.buf.references()<CR>",             desc = "References" },
                        { "<M-CR>",     "<cmd>lua vim.lsp.buf.code_action()<CR>",            desc = "Code action" },
                        { "<Leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>",            desc = "Code action" },
                        { "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>",            desc = "Code action" },
                        { "<Leader>r",  "<cmd>lua vim.lsp.buf.rename()<CR>",                 desc = "Rename" },
                        -- ["<C-D>"] = { "<cmd>lua vim.lsp.buf.type_definition<CR>", "Type dedesc=finiton" },
                        { "gi",         "<cmd>lua vim.lsp.buf.implementation()<CR>",         desc = "Implementation" },
                        { "K",          "<cmd>lua vim.lsp.buf.hover()<CR>",                  desc = "Hover" },
                        { "gd",         "<cmd>lua vim.lsp.buf.definition()<CR>",             desc = "Go to definition" },
                        { "gD",         "<cmd>lua vim.lsp.buf.declaration()<CR>",            desc = "Go to declaration" },
                    },
                    v = {
                        { "<M-CR>",     "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code action" },
                        { "<Leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code action" },
                        { "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code action" },
                    },
                })
            end,
        })
    end,
}

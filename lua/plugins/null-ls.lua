function print_enabled_diagnostics()
    local active_sources = require("null-ls").get_sources()
    local diagnostics = {}

    for _, source in ipairs(active_sources) do
        table.insert(diagnostics, source.name)
    end

    print("Enabled diagnostics:")
    for _, diagnostic in ipairs(diagnostics) do
        print("- " .. diagnostic)
    end
end

return {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        local sources = {
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.diagnostics.eslint,
            null_ls.builtins.formatting.black,
            -- null_ls.builtins.completion.spell,
        }
        require("null-ls").setup({
            on_attach = function(client, bufnr)
                vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format()
                        end,
                    })
                end
            end,
            sources = sources,
        })
        -- Function to print enabled diagnostics
        -- Bind this function to a command for easy access
        vim.cmd("command! ShowDiagnostics lua print_enabled_diagnostics()")
    end,
}

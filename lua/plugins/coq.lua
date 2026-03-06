-- ~/.config/nvim/lua/plugins/coq.lua
return {
--     "whonore/Coqtail", -- for syntax highlighting
--     ft = { "coq", "v" }, -- only load for .v / Coq files
--     dependencies = {
--         "neovim/nvim-lspconfig",
--         "hrsh7th/nvim-cmp",           -- completion engine
--         "hrsh7th/cmp-nvim-lsp",       -- LSP source for nvim-cmp
--     },
--     config = function()
--         -- 1️⃣ Syntax highlighting (Coqtail does this automatically on load)

--         -- 2️⃣ LSP setup (rocq-lsp or coq-lsp)
--         local lspconfig = require("lspconfig")
--         local capabilities = require("cmp_nvim_lsp").default_capabilities()

--         -- Rocq / Coq LSP
--         local coq_ls_bin = "/home/tim/.nix-profile/bin/rocq-lsp" -- adjust if needed
--         if vim.fn.executable(coq_ls_bin) == 1 then
--             lspconfig.coq_ls.setup({
--                 cmd = { coq_ls_bin },
--                 filetypes = { "coq", "v" },
--                 root_dir = lspconfig.util.root_pattern(".git", "_CoqProject", ".coqproject"),
--                 capabilities = capabilities,
--                 on_attach = function(client, bufnr)
--                     print("Coq / Rocq LSP attached to buffer " .. bufnr)
--                     local opts = { buffer = bufnr, silent = true, noremap = true }
--                     vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
--                     vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
--                     vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
--                 end,
--             })
--         else
--             print("rocq-lsp not found! Only syntax highlighting will work.")
--         end

--         -- 3️⃣ Optional: Setup nvim-cmp for LSP completion
--         local cmp = require("cmp")
--         cmp.setup.filetype("coq", {
--             sources = {
--                 { name = "nvim_lsp" },
--             }
--         })
--     end,
}


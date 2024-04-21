local lsp_params = {
    clangd = {
        on_attach = function()
            register_mapping({
                n = {
                    ["<Leader><Tab>"] = { "<cmd>ClangdSwitchSourceHeader<CR>", "Swap source / header" },
                },
            })
        end,
    },
    lua_ls = {},
    asm_lsp = {},
    rust_analyzer = {
        cmd = {
            "rust-analyzer",
        },
        settings = {
            ["rust-analyzer"] = {
                imports = {
                    granularity = {
                        group = "module",
                    },
                    prefix = "self",
                },
                cargo = {
                    buildScripts = {
                        enable = true,
                    },
                },
                procMacro = {
                    enable = true,
                },
            },
        },
    },
    autotools_ls = {},
    dockerls = {},
    pylsp = {},
    glslls = {},
    ocamllsp = {},
}

local lspconfig = require("lspconfig")
for k, v in pairs(lsp_params) do
    lspconfig[k].setup(v)
end

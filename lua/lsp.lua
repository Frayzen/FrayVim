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
    pylsp = {
        settings = {
            pylsp = {
                configurationSources = { "flake8" },
                plugins = {
                    flake8 = {
                        enabled = false,
                        ignore = { "E501", "E231" },
                        maxLineLength = 88,
                    },
                    black = { enabled = true },
                    autopep8 = { enabled = false },
                    mccabe = { enabled = false },
                    pycodestyle = {
                        enabled = false,
                        ignore = { "E501", "E231" },
                        maxLineLength = 88,
                    },
                    pyflakes = { enabled = false },
                },
            },
        },
    },
    glslls = {},
    ocamllsp = {},
    tsserver = {},
    jsonls = {},
}

local lspconfig = require("lspconfig")
for k, v in pairs(lsp_params) do
    lspconfig[k].setup(v)
end

local lsp_params = {
  clangd = {
    on_attach = function()
      register_mapping({
        n = {
          { "<Leader><Tab>", "<cmd>ClangdSwitchSourceHeader<CR>", desc = "Swap source / header" },
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
  pyright = {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "off",    -- Optional: Enforce strict type checking
          allowSubtypes = true,        -- Enable subclassing NewType
          reportArgumentType = "none", -- Disable reportArgumentType errors
        },
      },
    },
  },
  -- pylsp = {
  --   settings = {
  --     pylsp = {
  --       configurationSources = { "flake8" },
  --       plugins = {
  --         flake8 = {
  --           enabled = true,
  --           ignore = { "E501", "E231" },
  --           maxLineLength = 88,
  --         },
  --         black = { enabled = true },
  --         autopep8 = { enabled = true },
  --         mccabe = { enabled = true },
  --         pycodestyle = {
  --           enabled = true,
  --           ignore = { "E501", "E231" },
  --           maxLineLength = 88,
  --         },
  --         pyflakes = { enabled = false },
  --         rope_completion = {
  --           enabled = true,
  --         },
  --       },
  --     },
  --   },
  -- },
  glslls = {},
  ocamllsp = {},
  jsonls = {},
  html = {
    filetypes = { "twig", "html", "templ" },
  },
  twiggy_language_server = {},
  emmet_ls = {
    filetypes = { "twig", "html", "templ", "javascriptreact" },
  },
  cssls = {},
  dartls = {},
  cmake = {},
  marksman = {
    filetypes = { "markdown" },
    settings = {
      -- Optional: You can add specific settings here if needed
      -- For example:
      markdown = {
        enable = true,
        trace = {
          server = "verbose" -- Optional: for debugging
        }
      }
    }
  },
}
  

if os.execute("test -d venv") == 0 then
  local path = vim.fn.getcwd() .. "/venv"
  local cur = os.getenv("PYTHONPATH")
  cur = cur and cur .. ":" or ""
  vim.fn.setenv("PYTHONPATH", cur .. path)
end
local lspconfig = require("lspconfig")
for k, v in pairs(lsp_params) do
  lspconfig[k].setup(v)
end

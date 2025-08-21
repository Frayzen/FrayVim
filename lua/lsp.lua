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
  jedi_language_server = {
    root_dir = require("lspconfig.util").root_pattern(".git", "pyproject.toml", "setup.py", "requirements.txt"),

    init_options = {
      -- extra_paths = {"/home/tim/.conda/envs/torch-env/lib/python3.10/site-packages/tensorflow/__init__.py"},
      workspace = {
        -- Same extraPaths as Pyright
        -- Optional: Environment variables
        -- environment = "/home/tim/.conda/envs/ship-cudnn/bin/python",

        -- environment = "/home/tim/.conda/envs/torch-env/bin/python",
      },

      -- Jedi-specific optimizations
      codeAction = {
        nameExtractVariable = "jls_extract_var",
        nameExtractFunction = "jls_extract_def",
      },
      completion = {
        disableSnippets = false,
        resolveEagerly = true,
      },
      diagnostics = {
        enable = true,
        didOpen = true,
        didChange = true,
        didSave = true,
      },
    },
    -- Explicit Python path (same as Pyright)
    settings = {
      python = {
        -- pythonPath = "/home/tim/.conda/envs/torch-env/bin/python",
        -- pythonPath = "/home/tim/.conda/envs/tf218/bin/python",
      }
    },
    -- Optional: Markdown formatting for hover docs
    on_attach = function(client, bufnr)
      client.server_capabilities.hoverProvider = true
      client.server_capabilities.documentFormattingProvider = false -- Jedi doesn't format
    end
  },
  pyright = {
    on_attach = function(client, bufnr)
      client.server_capabilities.hoverProvider = false
    end,
    root_dir = require("lspconfig.util").root_pattern(".git", "pyproject.toml", "setup.py", "requirements.txt"),
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "off", -- Optional: Enforce strict type checking
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "workspace",
          signatureHelp = false,
        },
      },
    },
  },

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
          server = "verbose"   -- Optional: for debugging
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

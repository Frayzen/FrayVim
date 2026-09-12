local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = {
  ts_ls = {},
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
    root_dir = function(fname)
      return util.root_pattern("pyproject.toml", "setup.py", ".git")(fname) or vim.fn.getcwd()
    end,
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
  bashls = {},
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
          server = "verbose", -- Optional: for debugging
        },
      },
    },
  },
  texlab = {
    filetypes = { "tex", "plaintex", "bib", "markdown" }, -- 👈 Add markdown
  },
  gdscript = {},
  -- hdl_checker = {},
  vhdl_ls = {},
}

for server, opts in pairs(servers) do
  opts.capabilities = capabilities
  vim.lsp.config(server, opts)
  vim.lsp.enable(server)
end

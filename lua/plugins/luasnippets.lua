return {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    config = function()
        local ls = require("luasnip")
        
        -- Key mappings (keep your existing ones)
        vim.keymap.set({ "i", "s" }, "<M-l>", function() ls.expand_or_jump() end, { silent = true })
        vim.keymap.set({ "i", "s" }, "<M-h>", function() ls.expand_or_jump() end, { silent = true })
        -- vim.keymap.set({ "i", "s" }, "<M-j>", function() ls.jump(-1) end, { silent = true })

        ls.config.set_config({
            history = true,
            updateevents = "TextChanged,TextChangedI",
            enable_autosnippets = true,
            store_selection_keys = "<Tab>",
        })

        -- Load snippets from absolute path
        require("luasnip.loaders.from_lua").lazy_load({
            paths = { "~/.config/nvim/snippets" }
        })

        -- Edit snippets shortcut
        vim.keymap.set("n", "<leader>S", function()
            require("luasnip.loaders.from_lua").edit_snippet_files()
        end, { desc = "Edit snippets" })
    end,
    dependencies = {
        "rafamadriz/friendly-snippets"  -- Optional: for additional snippets
    }
}

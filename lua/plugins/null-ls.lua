return {}
-- -- function print_enabled_diagnostics()
-- --   local active_sources = require("null-ls").get_sources()
-- --   local diagnostics = {}

-- --   for _, source in ipairs(active_sources) do
-- --     table.insert(diagnostics, source.name)
-- --   end

-- --   print("Enabled diagnostics:")
-- --   for _, diagnostic in ipairs(diagnostics) do
-- --     print("- " .. diagnostic)
-- --   end
-- -- end

-- return {
-- 	"nvimtools/none-ls.nvim",
-- 	config = function()
-- 		local null_ls = require("null-ls")
-- 		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- 		-- local checkstyle_config_path = vim.fn.expand("~") .. "/checkstyle.xml"
-- 		local sources = {
-- 			null_ls.builtins.formatting.stylua,
-- 			null_ls.builtins.formatting.black,
-- 			-- null_ls.builtins.completion.spell,
-- 			-- null_ls.builtins.null_ls.builtins.diagnostics.checkstyle.with({
-- 			-- extra_args = { "-c", "~/checkstyle.xml" }, -- or "/sun_checks.xml" or path to self written rules

-- 			-- args = { "-c", checkstyle_config_path, "-f", "sarif", "$FILENAME" },
-- 			-- }),
-- 		}
-- 	end,
-- }

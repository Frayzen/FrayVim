local M = {}

function getName()
    local name = vim.fn.expand("%:r")
    return name .. ".hh"
end

local qs_classes = [[
(class_specifier name: (type_identifier) @name) @class
]]
function M.retrieve_classes()
    if vim.fn.expand("%:e") == "hh" then
        return
    end
    local cur = vim.api.nvim_get_current_buf()
    local cur_line = vim.fn.line(".")
    local buffer = vim.fn.bufadd(getName())
    vim.fn.bufload(buffer)
    local parser = ts.get_parser(buffer)
    if not parser then
        return
    end
    local tree = parser:parse()[1]
    local root = tree:root()
    local lang = parser:lang()
    local query = ts.query.parse(lang, qs_classes)
    local classes = {}
    for _, match, _ in query:iter_matches(root, buffer) do
        table.insert(classes, t(match[1], buffer))
    end
    if #classes == 1 then
        require("cpp-tools.method_retriever").retrieve_methods(classes[1], buffer, cur, cur_line)
        return
    end
    require("cpp-tools.menu").show_menu(classes, function(sel)
        require("cpp-tools.method_retriever").retrieve_methods(sel, buffer, cur, cur_line)
    end)
end

return M

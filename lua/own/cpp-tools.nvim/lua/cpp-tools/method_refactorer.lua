local M = {}
require("cpp-tools.tools")

local qs = [[
(function_definition
  type: (_)? @type
  (function_declarator
    declarator: (_) @name
    parameters: (_) @params
  )
) @def
]]

local function find(node, type)
    for i = 0, node:child_count() - 1 do
        local c = node:child(i)
        if c:type() == type then
            return c
        end
        local rec = find(c, type)
        if rec ~= nil then
            return rec
        end
    end
    return nil
end

local function find_all(node, type)
    local function find_all_rec(root, list)
        for i = 0, root:child_count() - 1 do
            local c = root:child(i)
            if c:type() == type then
                table.insert(list, c)
            end
            find_all_rec(c, list)
        end
    end
    local append = {}
    find_all_rec(node, append)
    return append
end

function M.refactor_method()
    local method = require("cpp-tools.method_retriever").get_hovered()
    if method == nil then
        print("Method not found")
    end
    local parser = ts.get_parser(vim.api.nvim_get_current_buf())
    local lang = parser:lang()
    local name = t(find(method, "identifier"))
    local namespaces = find_all(method, "namespace_identifier")
    local class_name = nil
    if #namespaces ~= 0 then
        class_name = t(namespaces[#namespaces])
    end

    local cc_buf = vim.api.nvim_get_current_buf()
    local hh_buf = vim.fn.bufadd(get_hh_name())
    vim.fn.bufload(hh_buf)

    local query = ts.query.parse(lang, qs)
    local cur = {}
    for _, match, _ in query:iter_matches(method, cc_buf) do
        cur = get_meth(match, query.captures, cc_buf)
    end

    local unimplemented = require("cpp-tools.method_retriever").retrieve_unimplemented(class_name, hh_buf, cc_buf)
    local choices = {}
    for _, v in pairs(unimplemented) do
        choices[mth_to_str(v)] = v
    end
    require("cpp-tools.menu").show_menu(choices, function(key, value)
        v = sel[2]
        local replacment = mth_to_str(cur) .. ";"
        local line = v["line"]
        vim.api.nvim_buf_set_lines(hh_buf, line, line + 1, false, { replacment })
        vim.api.nvim_buf_call(hh_buf, function()
            vim.cmd(":w")
            vim.cmd(
                ":lua vim.lsp.buf.format({ async = true, range = { start = { "
                .. line
                .. ', 0 }, ["end"] = { '
                .. line
                .. " , 0 } } })"
            )
        end)
    end, "Override method ?")
end

return M

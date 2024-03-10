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
    local method_node = require("cpp-tools.method_retriever").get_hovered()
    if method_node == nil then
        print("Method not found")
    end
    local cc_buf = vim.api.nvim_get_current_buf()
    local base_namespace = require("cpp-tools.class_retriever").get_cur_namespace()
    local method = parse_meth(method_node, cc_buf, "", base_namespace)

    local hh_buf = vim.fn.bufadd(get_hh_name())
    vim.fn.bufload(hh_buf)

    local unimplemented = require("cpp-tools.method_retriever").retrieve_unimplemented(method["class"], hh_buf, cc_buf)
    local choices = table_to_list(unimplemented)
    require("cpp-tools.menu").show_menu(choices, function(sel)
        local replacment = mth_to_str(method, true) .. ";"
        local line = sel["line"]
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

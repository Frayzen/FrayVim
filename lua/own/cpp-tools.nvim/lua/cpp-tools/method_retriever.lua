local M = {}
require("cpp-tools.tools")

local qs_hh = [[
(class_specifier
    name: (type_identifier) @ti (#match? @ti "class_name")
    body: (
        field_declaration_list
            (_
              type: (_)? @type
              declarator:
                (function_declarator
                    declarator: (_) @name
                    parameters: (_) @params
                ) @dec
            )
)) @class
]]

local qs_cc = [[
(function_definition
  type: (_)? @type
  (function_declarator
    declarator: (_) @name
    parameters: (_) @params
  ) @dec
) @def
]]

function M.cc_methods(cc_buffer)
    local parser = ts.get_parser(cc_buffer)
    local tree = parser:parse()[1]
    local root = tree:root()
    local lang = parser:lang()
    local qs = qs_cc
    local query = ts.query.parse(lang, qs)
    local methods = {}
    for _, match, _ in query:iter_matches(root, cc_buffer) do
        local meth = get_meth(match, query.captures, cc_buffer)
        local full = meth["type"] .. " " .. meth["name"] .. meth["params"]
        methods[full] = meth
    end
    return methods
end

function M.hh_methods(hh_buffer, class_name)
    class_name = class_name or ".*"
    local parser = ts.get_parser(hh_buffer)
    local tree = parser:parse()[1]
    local root = tree:root()
    local lang = parser:lang()
    local qs = qs_hh:gsub("class_name", class_name)
    local query = ts.query.parse(lang, qs)
    local methods = {}
    for _, match, _ in query:iter_matches(root, hh_buffer) do
        local meth = get_meth(match, query.captures, hh_buffer)
        local full = meth["type"] .. " " .. meth["name"] .. meth["params"]
        methods[full] = meth
    end
    return methods
end

function M.retrieve_unimplemented(class_name, hh_buffer, cc_buffer)
    local implemented = M.cc_methods(cc_buffer)
    local all = M.hh_methods(hh_buffer, class_name)
    for k, _ in pairs(implemented) do
        all[k] = nil
    end
    return all
end

function M.retrieve_methods(class_name, hh_buffer, cc_buffer, cc_line)
    local unimplemented = M.retrieve_unimplemented(class_name, hh_buffer, cc_buffer)
    local choices = { { "All" }, { "None" } }
    for _, v in pairs(unimplemented) do
        table.insert(choices, { get_full_meth(v, class_name) })
    end
    require("cpp-tools.menu").show_menu(choices, function(sel)
        if sel[1] == "None" then
            return
        elseif sel[1] == "All" then
            local lines = {}
            for _, v in pairs(choices) do
                if v[1] ~= "All" and v[1] ~= "None" then
                    table.insert(lines, v[1])
                    table.insert(lines, "{")
                    table.insert(lines, "	")
                    table.insert(lines, "}")
                    table.insert(lines, "")
                end
            end
            vim.api.nvim_buf_set_text(cc_buffer, cc_line - 1, 0, cc_line - 1, 0, lines)
        else
            vim.api.nvim_buf_set_text(cc_buffer, cc_line - 1, 0, cc_line - 1, 0, { "", sel[1], "{", "	", "}" })
        end
    end, "Chose method to implement")
end

function M.get_hovered()
    local node = ts.get_node()
    while node and node:type() ~= "function_definition" do
        node = node:parent()
    end
    return node
end

return M

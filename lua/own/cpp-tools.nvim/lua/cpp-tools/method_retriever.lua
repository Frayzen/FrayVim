local M = {}
require("cpp-tools.tools")

local qs_hh = [[
(
    class_specifier
    name: (type_identifier) @ti (#match? @ti "class_name")
    body: (field_declaration_list [
        (field_declaration declarator: (function_declarator))
        (declaration)
    ] @meth)
)
]]

local qs_cc = [[
(function_definition) @meth
]]

local function get_method(buffer, qs, class_name)
    local parser = ts.get_parser(buffer)
    local tree = parser:parse()[1]
    local root = tree:root()
    local lang = parser:lang()
    local query = ts.query.parse(lang, qs)
    local methods = {}
    for _, match, _ in query:iter_matches(root, buffer) do
        for id, node in pairs(match) do
            if query.captures[id] == "meth" then
                local val = parse_meth(node, buffer, class_name)
                methods[mth_to_str(val, true)] = val
            end
        end
    end
    return methods
end

function M.cc_methods(cc_buffer)
    return get_method(cc_buffer, qs_cc)
end

function M.hh_methods(hh_buffer, class_name)
    class_name = class_name or ".*"
    local qs = qs_hh:gsub("class_name", class_name)
    local methods = get_method(hh_buffer, qs, class_name)
    return methods
end

function M.retrieve_unimplemented(class_name, hh_buffer, cc_buffer)
    local implemented = M.cc_methods(cc_buffer)
    local all = M.hh_methods(hh_buffer, class_name)
    print("IMP")
    print(vim.inspect(implemented))
    print("ALL")
    print(vim.inspect(all))
    for k, _ in pairs(implemented) do
        all[k] = nil
    end
    return all
end

function M.retrieve_methods(class_name, hh_buffer, cc_buffer, cc_line)
    local unimplemented = M.retrieve_unimplemented(class_name, hh_buffer, cc_buffer)
    local choices = table_to_list(unimplemented)
    table.insert(choices, 1, { key = "All" })
    require("cpp-tools.menu").show_menu(choices, function(sel)
        local key = sel["key"]
        local to_implmt = { [key] = sel }
        if key == "All" then
            to_implmt = unimplemented
        end
        local impl_lines = {}
        for _, v in pairs(to_implmt) do
            if #impl_lines ~= 0 then
                table.insert(impl_lines, "")
            end
            table.insert(impl_lines, mth_to_str(v))
            table.insert(impl_lines, "{")
            table.insert(impl_lines, "	")
            table.insert(impl_lines, "}")
        end
        vim.api.nvim_buf_set_text(cc_buffer, cc_line - 1, 0, cc_line - 1, 0, impl_lines)
        vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { cc_line, 0 })
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

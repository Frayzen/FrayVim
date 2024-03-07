local M = {}

local qs_hh = [[
(class_specifier
    name: (type_identifier) @ti (#eq? @ti "class_name")
    body: (
        field_declaration_list
            (_
              type: (_)? @type
              declarator:
                (function_declarator
                    declarator: (_) @name
                    parameters: (_) @params
                )
            )
)) @class
]]

local qs_cc = [[
(function_definition
  type: [
         (primitive_type)
         (type_identifier)
        ]? @type
  (function_declarator
    declarator: (_) @name
    parameters: (_) @params
  )
) @def
]]

function get_implemented(cc_buffer)
    local parser = ts.get_parser(cc_buffer)
    local tree = parser:parse()[1]
    local root = tree:root()
    local lang = parser:lang()
    local qs = qs_cc
    local query = ts.query.parse(lang, qs)
    local methods = {}
    for _, match, _ in query:iter_matches(root, cc_buffer) do
        local meth = {}
        meth["type"] = ""
        for id, node in pairs(match) do
            local name = query.captures[id]
            if name == "name" then
                local v = t(node, cc_buffer)
                local split = v:find(":[^:]*$")
                if split == nil then
                    meth["name"] = v
                else
                    meth["name"] = v:sub(split + 1, v:len())
                    meth["class"] = v:sub(0, split)
                end
            elseif name == "type" or name == "params" then
                meth[name] = t(node, cc_buffer)
            end
        end
        local full = meth["type"] .. " " .. meth["name"] .. meth["params"]
        methods[full] = meth
    end
    return methods
end

function get_methods(hh_buffer, class_name)
    local parser = ts.get_parser(hh_buffer)
    local tree = parser:parse()[1]
    local root = tree:root()
    local lang = parser:lang()
    local qs = qs_hh:gsub("class_name", class_name)
    print(qs)
    local query = ts.query.parse(lang, qs)
    local methods = {}
    for _, match, _ in query:iter_matches(root, hh_buffer) do
        local meth = {}
        meth["type"] = ""
        for id, node in pairs(match) do
            local name = query.captures[id]
            if name == "type" or name == "name" or name == "params" then
                meth[name] = t(node, hh_buffer)
            end
        end
        local full = meth["type"] .. " " .. meth["name"] .. meth["params"]
        methods[full] = meth
    end
    return methods
end

function M.retrieve_methods(class_name, hh_buffer, cc_buffer, cc_line)
    local implemented = get_implemented(cc_buffer)
    local all = get_methods(hh_buffer, class_name)
    local choices = { "All", "None" }
    for k, _ in pairs(implemented) do
        if all[k] then
            all[k] = nil
        else
        end
    end
    for _, v in pairs(all) do
        local full = ""
        if v["type"] ~= "" then
            full = v["type"] .. " "
        end
        full = full .. class_name .. "::" .. v["name"] .. v["params"]
        table.insert(choices, full)
    end
    require("cpp-tools.menu").show_menu(choices, function(sel)
        if sel == "None" then
            return
        elseif sel == "All" then
            local lines = {}
            for _, value in pairs(choices) do
                if value ~= "All" and value ~= "None" then
                    table.insert(lines, value)
                    table.insert(lines, "{")
                    table.insert(lines, "	")
                    table.insert(lines, "}")
                    table.insert(lines, "")
                end
            end
            vim.api.nvim_buf_set_text(cc_buffer, cc_line - 1, 0, cc_line - 1, 0, lines)
        else
            vim.api.nvim_buf_set_text(cc_buffer, cc_line - 1, 0, cc_line - 1, 0, { "", sel, "{", "	", "}" })
        end
    end, "Chose method to implement")
end

return M

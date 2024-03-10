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

local function get_method(buffer, qs)
	local parser = ts.get_parser(buffer)
	local tree = parser:parse()[1]
	local root = tree:root()
	local lang = parser:lang()
	local query = ts.query.parse(lang, qs)
	local methods = {}
	for _, match, _ in query:iter_matches(root, buffer) do
		for id, node in pairs(match) do
			if query.captures[id] == "meth" then
				table.insert(methods, parse_meth(t(node, buffer)))
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
	local methods = get_method(hh_buffer, qs)
	for k, _ in pairs(methods) do
		methods[k]["class"] = class_name
	end
	return methods
end

function M.retrieve_unimplemented(class_name, hh_buffer, cc_buffer)
	local implemented = M.cc_methods(cc_buffer)
	local all = M.hh_methods(hh_buffer, class_name)
	for _, v in pairs(implemented) do
		table.remove(all, v)
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

function get_full_meth(meth)
	print(vim.inspect(meth))
	local full = ""
	if meth["type"] ~= "" then
		full = meth["type"] .. " "
	end
	if meth["class"] ~= "" then
		full = full .. meth["class"] .. "::"
	end
	full = full .. meth["name"] .. "(" .. meth["params"] .. ")"
	return full
end

function get_meth(match, captures, buffer)
	local meth = {}
	meth["type"] = ""
	for id, node in pairs(match) do
		local name = captures[id]
		if name == "name" then
			local v = t(node, buffer)
			local split = v:find(":[^:]*$")
			if split == nil then
				meth["name"] = v
			else
				meth["name"] = v:sub(split + 1, v:len())
				meth["class"] = v:sub(0, split)
			end
		elseif name == "type" or name == "params" then
			meth[name] = t(node, buffer)
		elseif name == "dec" then
			meth["line"] = node:start()
		end
	end
	return meth
end

function get_hh_name()
	local name = vim.fn.expand("%:r")
	return name .. ".hh"
end

function t(node, buf)
	buf = buf or 0
	return ts.get_node_text(node, buf)
end

function parse_meth(text)
	local type = "(.-)%s*"
	local class = "([a-zA-Z_]-)"
	local name = "([a-zA-Z_]+)%("
	local params = "(.*)%)"
	local pattern = string.format("^%s[a-zA-Z_:]-%s:?:?%s%s", type, class, name, params)
	_, _, type, class, name, params = string.find(text, pattern)
	if name == nil then
		error("Error parsing " .. text, nil)
	end
	return {
		type = type,
		class = class,
		name = name,
		params = params,
	}
end

function get_full_meth(meth, class_name)
    class_name = class_name or ""
    local full = ""
    if meth["type"] ~= "" then
        full = meth["type"] .. " "
    end
    if class_name ~= "" then
        full = full .. class_name .. "::"
    end
    full = full .. meth["name"] .. meth["params"]
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

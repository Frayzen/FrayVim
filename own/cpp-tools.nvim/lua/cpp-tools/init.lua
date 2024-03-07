local M = {}

ts = vim.treesitter

function t(node, buf)
    buf = buf or 0
    return ts.get_node_text(node, buf)
end

function M.setup(opts)
    opts = opts or {}
end

function M.implement()
    require("cpp-tools.class_retriever").retrieve_classes()
end

return M

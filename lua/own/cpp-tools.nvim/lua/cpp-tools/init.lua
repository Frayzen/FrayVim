local M = {}

ts = vim.treesitter

function M.setup(opts)
    opts = opts or {}
end

function M.implement()
    require("cpp-tools.class_retriever").retrieve_classes()
end

function M.refactor()
    require("cpp-tools.method_refactorer").refactor_method()
end

return M

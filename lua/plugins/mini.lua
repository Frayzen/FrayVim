return {
  "echasnovski/mini.nvim",
  config = function()
    require("mini.ai").setup()
    -- require("mini.surround").setup()
    -- mini.files related
    -- register_mapping({
    --   n = {
    --     {
    --       "<Leader>e",
    --       function()
    --         MiniFiles.open()
    --       end,
    --       desc = "Toggle tree",
    --     },
    --   },
    -- })

    -- local show_dotfiles = false
    -- local show_nongit = false
    -- local cached_git_files = nil
    -- require("mini.files").setup({
    --   content = {
    --     filter = function(fs_entry)
    --       if vim.startswith(fs_entry.name, ".") and not show_dotfiles then
    --         return false
    --       end
    --       if show_nongit then
    --         return true
    --       end
    --       local path = fs_entry.name
    --       return path ~= ".git" and vim.system({ "git", "check-ignore", "-q", path }):wait().code ~= 0
    --     end,
    --   },
    -- })

    -- vim.api.nvim_create_autocmd("User", {
    --   pattern = "MiniFilesBufferCreate",
    --   callback = function(args)
    --     local buf_id = args.data.buf_id
    --     -- Tweak left-hand side of mapping to your liking
    --     vim.keymap.set("n", "<Leader>.", function()
    --       show_dotfiles = not show_dotfiles
    --       MiniFiles.synchronize()
    --     end, { buffer = buf_id })

    --     vim.keymap.set("n", "<Leader>g", function()
    --       show_nongit = not show_nongit
    --       MiniFiles.synchronize()
    --     end, { buffer = buf_id })
    --   end,
    -- })

    -- -- Set focused directory as current working directory
    -- local set_cwd = function()
    --   local path = (MiniFiles.get_fs_entry() or {}).path
    --   if path == nil then
    --     return vim.notify("Cursor is not on valid entry")
    --   end
    --   vim.fn.chdir(vim.fs.dirname(path))
    -- end

    -- -- Yank in register full path of entry under cursor
    -- local yank_path = function()
    --   local path = (MiniFiles.get_fs_entry() or {}).path
    --   if path == nil then
    --     return vim.notify("Cursor is not on valid entry")
    --   end
    --   vim.fn.setreg(vim.v.register, path)
    -- end

    -- -- Open path with system default handler (useful for non-text files)
    -- local ui_open = function()
    --   vim.ui.open(MiniFiles.get_fs_entry().path)
    -- end

    -- vim.api.nvim_create_autocmd("User", {
    --   pattern = "MiniFilesBufferCreate",
    --   callback = function(args)
    --     local b = args.data.buf_id
    --     vim.keymap.set("n", "g~", set_cwd, { buffer = b, desc = "Set cwd" })
    --     vim.keymap.set("n", "gX", ui_open, { buffer = b, desc = "OS open" })
    --     vim.keymap.set("n", "gy", yank_path, { buffer = b, desc = "Yank path" })
    --   end,
    -- })
  end,
}

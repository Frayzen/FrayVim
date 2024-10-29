return {
  "ThePrimeagen/git-worktree.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("telescope").load_extension("git_worktree")
    register_mapping({
      n = {
        {
          "<Leader>fg",
          function()
            require("telescope").extensions.git_worktree.git_worktrees()
          end,
          desc = "Git worktree navigate",
        },

        {
          "<Leader>gc",
          function()
            require("telescope").extensions.git_worktree.create_git_worktree()
          end,
          desc = "Git worktree create",
        },
      },
    })
  end,
}

return {
  {
    "LazyVim/LazyVim",
    dir = vim.fn.stdpath("config") .. "/lazyvim-shim",
    name = "LazyVim",
    lazy = false,

    config = function(_, opts)
      if opts.colorscheme then
        vim.cmd.colorscheme(opts.colorscheme)
      end
    end,
  },
}

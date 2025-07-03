return {
  "tim-pearson/latex-eval.nvim",
  config = function()
    -- Register mappings with which-key

    require("which-key").add({
      mode = "v",
      { "<Leader>b", group = "LatexEval" },
      {
        "<leader>bx",
        function()
          require("latex-eval").evaluate_visual()
        end,
        desc = "evaluate latex visual selection",
      },
      {
        "<leader>bs",
        function()
          require("latex-eval").evaluate_visual(true)
        end,
        desc = "simplify latex visual selection",
      },
      {
        "<leader>bz",
        function()
          require("latex-eval").solve_visual(true)
        end,
        desc = "solve latex visual selection",
      },

    })
  end,
  dependencies = {},
}


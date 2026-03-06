-- ~/.config/nvim/lua/plugins/coqtail.lua

return {
  "whonore/Coqtail",
  ft = { "coq" },
  event = "VeryLazy",
  config = function()
    -- =========================
    -- 🧱 Basic Coqtail Settings
    -- =========================
    -- You can optionally set these globals before plugin loads
    vim.g.coqtail_noimap = 1           -- disable default Coqtail mappings
    vim.g.coqtail_split = "horizontal" -- or "vertical" if you prefer
    vim.g.coqtail_open_qwin = 1        -- automatically open goal window
    vim.g.coqtail_open_msgwin = 1      -- automatically open message window

    vim.g.coqtail_coq_prog = "coqtop"
    vim.g.coqtail_coq_path = "/home/tim/.opam/coq-env/bin"
    vim.g.coqtail_coq_args = { "-Q", "/home/tim/.opam/coq-env/lib/coq-core", "Coq" }

    -- ==================================
    -- 🧩 Coqtail Function & Keymap Setup
    -- ==================================
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true, buffer = true }

    -- Session control
    map("n", "<space>cs", ":CoqStart<CR>", opts)
    map("n", "<space>cq", ":CoqStop<CR>", opts)
    map("n", "<space>cr", ":CoqRestart<CR>", opts)

    -- Proof navigation
    map("n", "<space>cn", ":CoqNext<CR>", opts)
    map("n", "<space>cu", ":CoqUndo<CR>", opts)
    map("n", "<space>cc", ":CoqToCursor<CR>", opts)
    map("n", "<space>cl", ":CoqToLine<CR>", opts)

    -- Goal and message windows
    map("n", "<space>cg", ":CoqGotoGoal<CR>", opts)
    map("n", "<space>cm", ":CoqGotoMsg<CR>", opts)
    map("n", "<space>ch", ":CoqHideWins<CR>", opts)

    -- ===================================
    -- 🎨 Optional: Auto Split Management
    -- ===================================
    -- This ensures consistent window layout (like your Iron setup)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "coq",
      callback = function()
        -- When Coqtail opens, keep a 15-line bottom split for goals
        vim.cmd("botright 15split")
      end,
    })
  end,
}

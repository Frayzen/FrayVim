-- File: lua/qcircuit.lua
local M = {}

-- Directory to save PNGs
local output_dir = vim.fn.expand("~/Documents/qcircuits/")

-- Make sure the dir exists
os.execute("mkdir -p " .. output_dir)

-- Function to generate a PNG from LaTeX qcircuit code
local function qcircuit_to_png(circuit_code, filename)
  local tex_file = output_dir .. "temp.tex"
  local dvi_file = output_dir .. "temp.dvi"
  local png_file = output_dir .. filename

  -- Wrap circuit in standalone document
  local latex_code = [[
\documentclass[border=2mm]{standalone}
\usepackage{qcircuit}
\begin{document}
]] .. circuit_code .. [[
\end{document}
]]

  -- Write LaTeX file
  local f = io.open(tex_file, "w")
  f:write(latex_code)
  f:close()

  -- Compile and convert to PNG
  os.execute("latex -interaction=nonstopmode -output-directory=" .. output_dir .. " " .. tex_file)
  os.execute("dvipng -T tight -o " .. png_file .. " " .. dvi_file)

  -- Clean up temp files
  for _, ext in ipairs({ ".aux", ".log", ".tex", ".dvi" }) do
    os.remove(output_dir .. "temp" .. ext)
  end

  return png_file
end

-- Main command function
function M.save_selected_qcircuit()
  -- Get visual selection
  vim.cmd("normal! `<v`>y")
  local circuit_code = vim.fn.getreg('"')

  -- Ask for a filename
  local filename = vim.fn.input("PNG filename (with .png): ")

  if filename == "" then
    print("No filename given, aborting")
    return
  end

  local png_path = qcircuit_to_png(circuit_code, filename)

  -- Insert Markdown figure snippet
  local md_snippet = string.format("![Quantum Circuit](%s)", png_path)
  vim.api.nvim_put({ md_snippet }, "l", true, true)

  print("Saved PNG and inserted Markdown snippet: " .. png_path)
end

-- Optional: setup command
vim.api.nvim_create_user_command(
  "SaveQcircuit",
  M.save_selected_qcircuit,
  { range = true }
)

return M

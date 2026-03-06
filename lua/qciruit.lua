-- file: lua/quantum_circuit.lua
local M = {}

function M.fold_circuit()
  local start_line = vim.fn.search("\\[", "bn")   -- search backward
  local end_line = vim.fn.search("\\]", "n")      -- search forward
  if start_line > 0 and end_line > 0 then
    vim.cmd(start_line .. "," .. end_line .. "fold")
    -- print("Folded circuit: lines " .. start_line .. "-" .. end_line)
  else
    -- print("No circuit block found nearby!")
  end
end
M.save_circuit_png = function()
  -- get selected lines in visual mode
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  local lines = vim.fn.getline(start_line, end_line)
  local code = table.concat(lines, "\n")

  -- wrap the code in display math delimiters \[ ... \]
  code = "\\[\n" .. code .. "\n\\]"

  -- Simple LaTeX template that should work on Arch
  local tex_content = [[
\documentclass[border=4mm]{standalone}
\usepackage{xcolor}
\usepackage{amsmath}
\usepackage{physics}
\usepackage[braket, qm]{qcircuit}
\begin{document}
\resizebox{500pt}{!}{
]] .. code .. [[
}
\end{document}
]]

  -- ask for filename
  local filename = vim.fn.input("Save diagram as: ", "diagram")
  if filename == "" then return end

  -- prepare temp directory
  local tmp_dir = vim.fn.expand("~/.cache/nvim/circuits/")
  os.execute("mkdir -p " .. tmp_dir)
  local tex_file = tmp_dir .. filename .. ".tex"
  local pdf_file = tmp_dir .. filename .. ".pdf"
  local png_file = tmp_dir .. filename .. ".png"

  -- write .tex file
  local f = io.open(tex_file, "w")
  f:write(tex_content)
  f:close()

  -- compile LaTeX to PDF
  local compile_cmd = "cd " .. tmp_dir .. " && pdflatex -interaction=nonstopmode " .. tex_file .. " 2>&1"
  local handle = io.popen(compile_cmd)
  local output = handle:read("*a")
  handle:close()

  if not os.execute("test -f " .. pdf_file) then
    print("❌ LaTeX compilation failed!")
    print("Output:", output)
    return
  end

  -- convert PDF to PNG
  os.execute("magick -density 300 " .. pdf_file .. " -resize 1200 " .. png_file)

  -- copy markdown snippet to clipboard
  local md_snippet = "![Diagram](" .. png_file .. ")"
  vim.fn.setreg("+", md_snippet)

  print("✅ Saved PNG: " .. png_file)
end
-- M.save_circuit_png = function()
--   -- get selected lines in visual mode
--   local start_line = vim.fn.line("'<")
--   local end_line = vim.fn.line("'>")
--   local lines = vim.fn.getline(start_line, end_line)
--   local code = table.concat(lines, "\n")

--   -- wrap the code in display math delimiters \[ ... \]
--   code = "\\[\n" .. code .. "\n\\]"

--   -- detect type: tikz or qcircuit
--   local tex_packages = [[
-- \usepackage{xcolor}
-- \pagecolor{white}
-- \usepackage{amsmath}
-- \usepackage{physics}
-- ]]
--   if code:match("\\begin{tikzpicture}") then
--     tex_packages = tex_packages .. "\n\\usepackage{tikz}"
--   elseif code:match("\\Qcircuit") then
--     tex_packages = tex_packages .. [[
-- \usepackage[braket, qm]{qcircuit}
-- \input{Qcircuit]]
--   end

--   -- full LaTeX document with larger border
--   local tex_content = string.format([[
-- \documentclass[border=4mm]{standalone}
-- %s
-- \begin{document}
-- %s
-- \end{document}
-- ]], tex_packages, code)

--   -- ask for filename
--   local filename = vim.fn.input("Save diagram as: ", "diagram")
--   if filename == "" then return end

--   -- prepare temp directory
--   local tmp_dir = vim.fn.expand("~/.cache/nvim/circuits/")
--   os.execute("mkdir -p " .. tmp_dir)
--   local tex_file = tmp_dir .. filename .. ".tex"
--   local pdf_file = tmp_dir .. filename .. ".pdf"
--   local png_file = tmp_dir .. filename .. ".png"

--   -- write .tex file
--   local f = io.open(tex_file, "w")
--   f:write(tex_content)
--   f:close()

--   -- compile LaTeX to PDF
--   local compile_result = os.execute(string.format(
--   "cd %s && pdflatex -interaction=nonstopmode %s > /dev/null 2>&1",
--   tmp_dir, tex_file
--   ))

--   if compile_result ~= 0 then
--     print("❌ LaTeX compilation failed! Check if qcircuit package is installed.")
--     print("Try: sudo apt-get install texlive-science texlive-pictures")
--     return
--   end

--   -- convert PDF to PNG
--   local convert_cmd = string.format(
--   "magick -density 300 %s -resize 1000 %s",
--   pdf_file, png_file
--   )
--   os.execute(convert_cmd)

--   -- copy markdown snippet to clipboard
--   local md_snippet = string.format("![Diagram](%s)", png_file)
--   vim.fn.setreg("+", md_snippet)

--   print("✅ Saved PNG:", png_file, "and copied Markdown snippet to clipboard!")
-- end

-- Unfold the nearest \[ ... \] block
function M.unfold_circuit()
  local start_line = vim.fn.search("\\[", "bn")
  local end_line = vim.fn.search("\\]", "n")
  if start_line > 0 and end_line > 0 then
    vim.cmd(start_line .. "," .. end_line .. "foldopen")
    -- print("Unfolded circuit: lines " .. start_line .. "-" .. end_line)
  else
    -- print("No circuit block found nearby!")
  end
end

-- Toggle all \[ ... \] blocks in the file
function M.toggle_circuits()
  -- get all lines in the buffer
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local fold_state = {}   -- track which blocks to fold/unfold

  -- detect all \[ ... \] blocks
  local in_block = false
  local start_line = 0
  for i, line in ipairs(lines) do
    if line:match("\\%[") and not in_block then
      in_block = true
      start_line = i
    elseif line:match("\\%]") and in_block then
      in_block = false
      local end_line = i

      -- check if first line of block is already folded
      local info = vim.fn.foldclosed(start_line)
      if info == -1 then
        -- currently unfolded → fold it
        vim.cmd(start_line .. "," .. end_line .. "fold")
      else
        -- currently folded → unfold it
        vim.cmd(start_line .. "," .. end_line .. "foldopen")
      end
    end
  end
end

return M

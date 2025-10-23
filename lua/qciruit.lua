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

  -- detect type: tikz or qcircuit
  local tex_packages = [[
\usepackage{xcolor}
\pagecolor{white}
]]
  if code:match("\\begin{tikzpicture}") then
    tex_packages = tex_packages .. "\n\\usepackage{tikz}"
  elseif code:match("\\Qcircuit") then
    tex_packages = tex_packages .. "\n\\usepackage{qcircuit}"
  end

  -- full LaTeX document with larger border
  local tex_content = string.format([[
\documentclass[border=8mm, varwidth]{standalone}
%s
\begin{document}
%s
\end{document}
]], tex_packages, code)

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
  os.execute(string.format(
    "pdflatex -interaction=nonstopmode -output-directory=%s %s > /dev/null",
    tmp_dir, tex_file
  ))

  -- convert PDF to high-res PNG
  -- local convert_cmd = string.format(
  --     "magick -density 300 %s -quality 100 %s",
  --     pdf_file, png_file
  -- )
  -- os.execute(convert_cmd)

  -- Convert PDF to high-res PNG with a target width
  -- ~80 characters in terminal = ~80 * 8px = 640px wide (approx)
  local target_width_px = 640
  local convert_cmd = string.format(
    "magick -density 300 %s -resize %d %s",
    pdf_file, target_width_px, png_file
  )
  os.execute(convert_cmd)
  -- copy markdown snippet to clipboard
  local md_snippet = string.format("![Diagram](%s)", png_file)
  vim.fn.setreg("+", md_snippet)

  print("Saved PNG:", png_file, "and copied Markdown to clipboard!")
end


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

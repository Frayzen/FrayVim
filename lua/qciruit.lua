-- file: lua/quantum_circuit.lua
local M = {}
-- file: lua/quantum_circuit.lua

M.save_circuit_png = function()
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")
    local lines = vim.fn.getline(start_line, end_line)
    local circuit_code = table.concat(lines, "\n")

    -- wrap in standalone LaTeX document
    local tex_content = [[
\documentclass[border=2mm]{standalone}
\usepackage{qcircuit}
\begin{document}
]] .. circuit_code .. [[
\end{document}
    ]]

    -- prompt for filename
    local filename = vim.fn.input("Save circuit as: ", "circuit")  -- default 'circuit'
    if filename == "" then
        print("Cancelled")
        return
    end

    -- generate file paths
    local tmp_dir = vim.fn.expand("~/.cache/nvim/circuits/")
    os.execute("mkdir -p " .. tmp_dir)
    local tex_file = tmp_dir .. filename .. ".tex"
    local pdf_file = tmp_dir .. filename .. ".pdf"
    local png_file = tmp_dir .. filename .. ".png"

    -- save .tex
    local f = io.open(tex_file, "w")
    f:write(tex_content)
    f:close()

    -- compile pdflatex
    os.execute(string.format("pdflatex -interaction=nonstopmode -output-directory=%s %s > /dev/null", tmp_dir, tex_file))
    -- convert PDF to high-res PNG
    os.execute(string.format("convert -density 300 %s -quality 100 %s", pdf_file, png_file))

    -- copy markdown figure snippet to system clipboard
    local md_snippet = string.format("![Quantum Circuit](%s)", png_file)
    vim.fn.setreg("+", md_snippet)

    print("Saved PNG:", png_file)
    print("Markdown copied to clipboard!")
end

return M


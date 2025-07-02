return {
  s({ trig = "iff", dscr = "iff" }, {
    t("\\Leftrightarrow"), i(0)
  }),
  s({ trig = "imp", dscr = "implies" }, {
    t("\\Rightarrow"), i(0)
  }),
  s({ trig = "k0", dscr = "Ket |0⟩" }, {
    t("\\ket{0}"), i(0)
  }),
  s({ trig = "k1", dscr = "Ket |1⟩" }, {
    t("\\ket{1}"), i(0)
  }),
  s({ trig = "b0", dscr = "Bra ⟨0|" }, {
    t("\\bra{0}"), i(0)
  }),
  s({ trig = "b1", dscr = "Bra ⟨1|" }, {
    t("\\bra{1}"), i(0)
  }),
  s({ trig = "ran", dscr = "rangle ⟩ \\rangle" }, {
    t("\\rangle"), i(0)
  }),
  s({ trig = "lan", dscr = "langle ⟨ \\langle" }, {
    t("\\langle"), i(0)
  }),
  s({ trig = "kt", dscr = "Ket |0⟩" }, {
    t("\\ket{"), i(1,"x"), t("}"), i(0)
  }),



  -- math
  s({ trig = "ap", dscr = "Appox equal to \\approx" }, {
    t("\\approx"), i(0)
  }),
  s({ trig = "brac", dscr = "auto size bracked \\left( \\right)" }, {
    t("\\left("), i(1, "input"), t("\\right)"), i(0)
  }),
  s({ trig = "partt", dscr = "differentiate resp t" }, {
    t("\\frac{\\partial "), i(1, "input"), t("}{\\partial t}"), i(0)
  }),
  s({ trig = "partx", dscr = "differentiate resp x" }, {
    t("\\frac{\\partial "), i(1, "input"), t("}{\\partial x}"), i(0)
  }),
  s({ trig = "ppartt", dscr = "differentiate resp t" }, {
    t("\\frac{\\partial^2 "), i(1, "input"), t("}{\\partial t^2}"), i(0)
  }),
  s({ trig = "ppartx", dscr = "differentiate resp x" }, {
    t("\\frac{\\partial^2 "), i(1, "input"), t("}{\\partial x^2}"), i(0)
  }),
  s({ trig = "sum", dscr = "Summation with limits \\sum_{start}^{end} expression" }, {
  t("\\sum_{"), i(1, "n=0"), t("}^{"), i(2, "\\infty"), t("} "), i(3, "x_n"), i(0)
}),
-- psi of x
s({ trig = "psix", dscr = "Function Psi of x \\psi(x)" }, {
  t("\\psi(x)"), i(0)
}),
s({ trig = "Psixt", dscr = "Function Psi of x \\Psi(x,t)" }, {
  t("\\Psi(x,t)"), i(0)
}),

-- Generic state kets
s({ trig = "psi", dscr = "Generic ket |ψ⟩" }, {
  t("\\ket{\\psi}"), i(0)
}),
s({ trig = "01", dscr = "set of 0 and 1" }, {
  t("\\{0,1\\}"), i(0)
}),
s({ trig = "01n", dscr = "set of 0 and 1" }, {
  t("\\{0,1\\}^n"), i(0)
}),

-- Inner products
s({ trig = "bk", dscr = "Inner product ⟨ψ|φ⟩" }, {
  t("\\braket{\\psi|\\phi}"), i(0)
}),
s({ trig = "prj", dscr = "Projector |a⟩⟨b|" }, {
  t("\\ket{"), i(1, "a"), t("}\\bra{"), i(2, "b"), t("}"), i(0)
}),

-- Text eV
s({ trig = "ev", dscr = "Electron volt \\text{eV}" }, {
  t("\\text{eV}"), i(0)
}),
-- Text eV
s({ trig = "txt", dscr = "Text block \\text{input}" }, {
  t("\\text{"), i(1, "input"), t("}"), i(0)
}),
-- Inline math exp
s({ trig = "in", dscr = "Inline exp $ input $" }, {
  t("$"), i(1, "input"), t("$"), i(0)
}),
-- multi line exp
s({ trig = "mth", dscr = "Multiline exp $$ input $$" }, {
  t({ "$$", "" }),
  i(1, "input"),
  t({ "", "$$" }),
  i(0)
}),

s({ trig = "amth", dscr = "Multiline exp $$ input $$" }, {
  t({ "$$", "" }),
  t({ "\\begin{align*}", "" }),
  i(1, "input"),
  t({ "", "\\end{align*}" }),
  t({ "", "$$" }),
  i(0)
}),

s({ trig = "bmth", dscr = "Multiline exp $$ input $$" }, {
  t({ "$$", "" }),
  t({ "\\boxed{", "" }),
  i(1, "input"),
  t({ "", "}" }),
  t({ "", "$$" }),
  i(0)
}),

-- fractions
s({ trig = "fr", dscr = "Fraction \\frac{}{}" }, {
  t("\\frac{"), i(1, "numerator"), t("}{"), i(2, "denominator"), t("}"), i(0)
}),
-- square root
s({ trig = "sq", dscr = "Sqrt \\sqrt{input}" }, {
  t("\\sqrt{"), i(1, "input"), t("}"), i(0)
}),

-- exp
s({ trig = "exp", dscr = "Fraction \\e^{input}" }, {
  t("e ^{"), i(1, "input"), t("}"), i(0)
}),

-- insert inpage
s({ trig = "fig", dscr = "Markdown image with caption" }, {
  t("!["),
  i(1, "Figure caption"),
  t("](./images/figure"),
  i(2, "n"),
  t(".png)  "),
  t({ "", "*Figure " }),
  i(3, "n"),
  t(": "),
  i(4, "Caption text."),
  t("*"),
  i(0)
}),

-- math cal
s({ trig = "mc", dscr = "Mathcal symbol \\mathcal{}" }, {
  t("\\mathcal{"), i(1, "input"), t("}"), i(0)
}),
}

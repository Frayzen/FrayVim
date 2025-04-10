local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
    -- Simple kets and bras
    s({trig = "k0", dscr = "Ket |0⟩"}, {
        t("|0\\rangle"), i(0)
    }),
    
    s({trig = "k1", dscr = "Ket |1⟩"}, {
        t("|1\\rangle"), i(0)
    }),
    s({trig = "b0", dscr = "Ket |0⟩"}, {
        t("\\langle 0|"), i(0)
    }),
    
    s({trig = "b1", dscr = "Ket |1⟩"}, {
        t("\\langle 1|"), i(0)
    }),


    -- Generic state kets
    s({trig = "|psi", dscr = "Generic ket |ψ⟩"}, {
        t("|"), i(1, "\\psi"), t("\\rangle"), i(0)
    }),

    -- Inner products
    s({trig = "<psi|phi>", dscr = "Inner product ⟨ψ|φ⟩"}, {
        t("\\langle "), i(1, "\\psi"), t("|"), i(2, "\\phi"), t("\\rangle"), i(0)
    }),

    -- Fraction
    s({trig = "fr", dscr = "Fraction \\frac{}{}"}, {
        t("\\frac{"), i(1, "numerator"), t("}{"), i(2, "denominator"), t("}"), i(0)
    }),
}

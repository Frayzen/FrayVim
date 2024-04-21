function getName()
    local name = vim.fn.expand("%:t:r")
    return name .. ".hh"
end

return {
    s("inc", { t('#include "'), f(getName), t('"') }),
    s({ trig = "fori", priority = 100000000 }, {
        t("for (int "),
        i(1, "i"),
        t(" = "),
        i(2, "0"),
        t("; "),
        l(l._1, 1),
        t(" < "),
        i(3, "lim"),
        t("; "),
        l(l._1, 1),
        t({ "++)", "{", "	" }),
        i(0),
        t({ "", "}" }),
    }),
    s({ trig = "forui", priority = 100000000 }, {
        t("for (unsigned int "),
        i(1, "i"),
        t(" = "),
        i(2, "0"),
        t("; "),
        l(l._1, 1),
        t(" < "),
        i(3, "lim"),
        t("; "),
        l(l._1, 1),
        t({ "++)", "{", "	" }),
        i(0),
        t({ "", "}" }),
    }),
    s({ trig = "forst", priority = 100000000 }, {
        t("for (size_t "),
        i(1, "i"),
        t(" = "),
        i(2, "0"),
        t("; "),
        l(l._1, 1),
        t(" < "),
        i(3, "lim"),
        t("; "),
        l(l._1, 1),
        t({ "++)", "{", "	" }),
        i(0),
        t({ "", "}" }),
    }),
    s("swhile", {
        t("int "),
        i(1, "i"),
        t({ " = 0;", "while (" }),
        i(2, "mystr"),
        t("["),
        l(l._1, 1),
        t({ "])", "{", "    " }),
        i(0),
        t({ "", "    " }),
        l(l._1, 1),
        t({ "++;", "}", "" }),
    }),
    s("print", {
        t({ "std::cout << " }),
        i(0, '"OK"'),
        t({ " << '\\n';" }),
    }),
    s("ptype", {
        t({ "std::cout << typeid(" }),
        i(0, ""),
        t({ ").name() << '\\n';" }),
    }),
    s("once", { t({ "#pragma once", "" }) }),
}

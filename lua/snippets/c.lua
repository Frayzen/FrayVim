local function snake(s)
	return s:gsub("%f[^%l]%u", "_%1")
		:gsub("%f[^%a]%d", "_%1")
		:gsub("%f[^%d]%a", "_%1")
		:gsub("(%u)(%u%l)", "%1_%2")
		:lower()
end

function getSnakeName()
	local name = vim.fn.expand("%:t:r")
	local snakeName = snake(name):upper()
	return snakeName
end

return {
	s({ trig = "hguard", filetype = "c" }, {
		t("#ifndef "),
		f(getSnakeName),
		t({ "_H", "" }),
		t("#define "),
		f(getSnakeName),
		t({ "_H", "" }),
		t({ "", "" }),
		i(0),
		t({ "", "" }),
		t({ "", "" }),
		t("#endif /* !"),
		f(getSnakeName),
		t("_H */"),
	}),
	s({ trig = "inc", filetype = "c" }, {
		t('#include "'),
		f(function()
			return vim.fn.expand("%:t:r")
		end),
		t({ '.h"', "" }),
	}),

	s({ trig = "print", filetype = "c" }, {
		t('printf("'),
		i(1),
		i(0),
		t('"\\n'),
		i(2),
		t(");"),
	}),
	s("i<", { t("#include <"), i(1), t({ ".h>" }) }),
	s('i""', { t('#include "'), i(1), t({ '.h"' }) }),
	s({ trig = "for", priority = 100000000 }, {
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
		t({ "++)", "{", "" }),
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
	s("llwhile", {
		t("struct "),
		i(1, "list"),
		t(" *"),
		i(2, "el"),
		t("= "),
		i(3, "first"),
		t({ ";", "while(" }),
		l(l._1, 2),
		t({ ")", "{", "    " }),
		i(0, ""),
		t({ "", "    " }),
		l(l._1, 2),
		t(" = "),
		l(l._1, 2),
		t({ "->next;", "}" }),
	}),
	s("testsuite", {
		t({ "#include <criterion/criterion.h>", "#include <criterion/internal/test.h>", "", "TestSuite(" }),
		i(1, "TestSuite"),
		t({ ");", "", "" }),
		i(0),
	}),
	s("test", {
		t("Test("),
		i(1, "TestSuite"),
		t({ ", test_" }),
		i(2, "example"),
		t({ ")", "{", "" }),
		i(0),
		t({ "", "}" }),
	}),
	s("pl", {
		t('printf("%zu\\n", '),
		i(1, "i"),
		t(");"),
	}),
	s("ps", {
		t('printf("%s\\n", '),
		i(1, "i"),
		t(");"),
	}),
	s("pc", {
		t('printf("%c\\n", '),
		i(1, "c"),
		t(");"),
	}),
	s("pd", {
		t('printf("%d\\n", '),
		i(1, "i"),
		t(");"),
	}),
	s("pp", {
		t('printf("%p\\n", (void*)'),
		i(1, "i"),
		t(");"),
	}),
	s("pok", {
		t('printf("OK\\n");'),
	}),
	s("fun", {
		i(1, "int"),
		t(" "),
		i(2, "function"),
		t("("),
		i(3, "args"),
		t({ ")", "{", "    " }),
		i(0, ""),
		t({ "", "}" }),
	}),
	s("maina", {
		t({ "int main(int " }),
		i(1, "argc"),
		t(", char *"),
		i(2, "argv"),
		t("[])"),
		t({ ")", "{", "    " }),
		i(0, ""),
		t({ "", "}" }),
	}),
	s("main", {
		t({ "int main(void)" }),
		t({ "{", "    " }),
		i(0, ""),
		t({ "", "    return 0;", "}" }),
	}),
}

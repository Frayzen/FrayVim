return {
	s("pkg", {
        t"package ",
        i(1, "fr.something"),
        t({";", ""}),
    }),
	-- s("class", {
	-- 	t("public class "),
        -- i(1, "MyClass"),
	-- 	t({ "{", "" }),
	-- 	i(0),
	-- 	t({ "","}"}),
	-- }),
    s("Main", {
        t"package ",
        i(1, "fr.something"),
        t({";", "", "public class Main {", "	public static void main(String[] args)	{", "		"}),
        i(0),
        t({"","	}", "}"});
    }),
}

return {
    s("test", {
        t({ 'test("", () => {', "\t" }),
        i(0),
        t({ "", "});" }),
    }),
    s("mexp", {
        t({
            "module.exports = {",
            "\t",
        }),
        i(0),
        t({ "", "}" }),
    }),
}

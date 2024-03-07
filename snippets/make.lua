return {
    s("make", {
        t("CC="),
        i(1, "gcc"),
        t({ "", "CFLAGS= " }),
        i(2, "-std=c99 -pedantic -Werror -Wall -Wextra -Wvla"),
        t({ "", "LDFLAGS= " }),
        i(3, ""),
        t({ "", "SRCS = $(shell find $(SRC_DIR) -name '*.c' -a ! -path '" }),
        i(4, "*/tests/*"),
        t({ "')", "" }),
        t({ "OBJS = $(SRCS:.c=.o)", "", "" }),
        i(0),
        t({ "", "", "all: $(OBJS)" }),
        t({ "", "", "clean:", "\t$(RM) $(OUT) $(shell find . -name '*.o')", "", ".PHONY: clean all" }),
    }),
    s("library", {
        t({
            "CC=gcc",
            "CFLAGS=-std=c99 -pedantic -Werror -Wall -Wextra -Wvla",
            "OUT=lib",
        }),
        i(1, "mylibname"),
        t({
            ".a",
            "OBJS = ",
        }),
        i(2, "main.o"),
        t({
            "",
            "",
            "",
        }),
        i(3, "library"),
        t({
            ": $(OUT)",
            "",
            "$(OUT): $(OBJS)",
            "\tar rcs $(OUT) $(OBJS)",
            "",
            "debug: library ",
        }),
        i(4, "test.o"),
        t({
            "",
            "\t$(CC) $(CFLAGS) *.o",
        }),
        i(0),
        t({
            "",
            "clean:",
            "\t$(RM) $(OUT) *.o $(OBJS) *.out",
            "",
            ".PHONY: clean library debug",
        }),
    }),
    s("target", {
        i(1, "target"),
        t({ ": CFLAGS += " }),
        i(2),
        t({ "", "" }),
        l(l._1, 1),
        t({ ": LDFLAGS += " }),
        i(3),
        t({ "", "" }),
        l(l._1, 1),
        t(": all "),
        i(4, "./tests/debug.o"),
        t({ "", "\t" }),
        i(5, "$(CC) -o $@ $(LDFLAGS) $(OBJS) "),
        l(l._1, 4),
        t({ "", "" }),
    }),
    s("dbgflag", {
        t(" -g -fsanitize=address"),
    }),
}

return {
  s({ trig = "mk", dscr = "Jupyter Markdown cell" }, {
    t("# %% [markdown]"),
    t({"", 'r"""', ""}),  -- open triple quotes on its own line
    i(1, "\\ket{\\psi}"),     -- cursor for content
    t({"", '"""', "# %%" }), -- close triple quotes + next cell marker
    i(0),
  }),
}


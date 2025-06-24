return {
	filetypes = { "bib", "gitcommit", "markdown", "org", "plaintex", "rst", "rnoweb", "tex", "pandoc", "typst" },
	settings = {
		ltex = {
			filetypes = {
				"bib",
				"gitcommit",
				"markdown",
				"org",
				"plaintex",
				"rst",
				"rnoweb",
				"tex",
				"pandoc",
				"typst",
			},
			completionEnabled = true,
			checkFrequency = "save",
			latex = {
				commands = {
					["\\cite[]{}"] = "ignore",
					["\\cite{}"] = "ignore",
				},
			},
		},
	},
}

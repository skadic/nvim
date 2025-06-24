return {
	settings = {
		texlab = {
			build = {
				executable = "tectonic",
				--args = { "-f", "--synctex", "--keep-logs", "--keep-intermediates", "%f" },
				args = {
					"-X",
					"compile",
					"%f",
					"--synctex",
					"--keep-logs",
					"--keep-intermediates",
				},
				onSave = true,
			},
		},
	},
}

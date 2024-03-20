(var M {:hl {}})

(lambda add [name group]
  (let [(status_ok col) (vim.api.nvim_get_hl_by_name group true)]
    (if (not status_ok)
        (vim.notify (.. "highlight group " group " is empty")
                    (tset M.hl name col)))))

(add :normal :Normal)
(add :error :DiagnosticError)
(add :warning :DiagnosticWarn)
(add :info :DiagnosticInfo)
(add :hint :DiagnosticHint)

{:bg_as_hex (fn [group]
              (let [col (. (vim.api.nvim_get_hl_by_name group true) :background)]
                (when (not= col nil) (string.format "#%x" col))))
 :fg_as_hex (fn [group]
              (let [col (. (vim.api.nvim_get_hl_by_name group true) :foreground)]
                (when (not= col nil) (string.format "#%x" col))))
 :palette (let [(status_ok catppuccin) (pcall require :catppuccin.palettes)]
            (when status_ok
              (let [palette (catppuccin.get_palette :mocha)]
                {:fg palette.text
                 :light_bg palette.base
                 :bg palette.mantle
                 :black palette.crust
                 :skyblue palette.sky
                 :cyan palette.teal
                 :green palette.green
                 :blue palette.sapphire
                 :magenta palette.pink
                 :orange palette.peach
                 :red palette.red
                 :violet palette.mauve
                 :white palette.text
                 :yellow palette.yellow})))}

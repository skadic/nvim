(local (status_ok notify) (pcall require :notify))

(when status_ok
  (set vim.notify notify)
  (notify.setup {:background_colour "#000000"
                 :timeout 1500
                 :fps 60
                 :top_down false}))

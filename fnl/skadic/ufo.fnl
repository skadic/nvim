(local (status_ok ufo) (pcall require :ufo))

(fn handler [virt_text lnum end_lnum width truncate]
  (local new_virt_text {})
  (var suffix (string.format " 󰁂 %d " (- end_lnum lnum)))
  (local suf_width (vim.fn.strdisplaywidth suffix))
  (local target_width (- width suf_width))
  (var cur_width 0)
  (each [_ chunk (ipairs virt_text)]
    (let [chunk_text (. chunk 1)
          chunk_width (vim.fn.strdisplaywidth chunk_text)]
      (if (< (+ cur_width chunk_width) target_width)
          (table.insert new_virt_text chunk)
          (< cur_width target_width)
          (let [chunk_text (truncate chunk_text (- target_width cur_width))
                hl_group (. chunk 2)
                chunk_width (vim.fn.strdisplaywidth chunk_text)]
            (table.insert new_virt_text [chunk_text hl_group])
            (when (< (+ cur_width chunk_width) target_width)
              (set suffix
                   (.. suffix
                       (string.rep " " (- target_width cur_width chunk_width))))))
          (set cur_width (+ cur_width chunk_width))))
    (table.insert new_virt_text [suffix :MoreMsg])
    new_virt_text))

(when status_ok
  (set vim.o.foldlevel 99)
  (set vim.o.foldlevelstart 99)
  (set vim.o.foldenable true)
  (ufo.setup {:fold_virt_text_handler handler
              :provider_selector (fn [_bufnr filetype _buftype]
                                   (if (= filetype :neo-tree) [:treesitter]
                                       [:treesitter :indent]))})
  {})

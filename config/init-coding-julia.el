(use-package julia-mode
  :ensure t)

(use-package julia-repl
  :ensure t
  :hook (julia-mode . julia-repl-mode)

  :init
  (setenv "JULIA_NUM_THREADS" "8")

  :config
  ;; Set the terminal backend
  (julia-repl-set-terminal-backend 'vterm)
  
  ;; Keybindings for quickly sending code to the REPL
  (define-key julia-repl-mode-map (kbd "<C-RET>") 'my/julia-repl-send-cell)
  (define-key julia-repl-mode-map (kbd "<M-RET>") 'julia-repl-send-line)
  (define-key julia-repl-mode-map (kbd "<S-return>") 'julia-repl-send-buffer))

(defun my/julia-repl-send-cell() 
  ;; "Send the current julia cell (delimited by ###) to the julia shell"
  (interactive)
  (save-excursion (setq cell-begin (if (re-search-backward "^###" nil t) (point) (point-min))))
  (save-excursion (setq cell-end (if (re-search-forward "^###" nil t) (point) (point-max))))
  (set-mark cell-begin)
  (goto-char cell-end)
  (julia-repl-send-region-or-line)
  (next-line))

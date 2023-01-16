;;;;Org mode configuration
;; Enable Org mode
(require 'org)
;; Make Org mode work with files ending in .org
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; The above is the default in recent emacsen

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . nil)
   (shell . t)))

;; track habits
(require 'org-habit)
(setq org-habit-graph-column 65)
(setq org-habit-show-habits-only-for-today t
      )
(setq org-habit-preceding-days 8)
(setq org-habit-following-days 4)

;; org agenda
(setq org-agenda-start-with-follow-mode t)
(setq org-agenda-files (list "~/org/current/Me.org" "~/org/current/UMBC.org" "~/org/current/Animals.org"))
(setq org-default-notes-file '("~/org/current/Refile.org"))

(setq org-log-into-drawer "LOGBOOK")
(setq org-log-done 'note)
(setq org-todo-keywords
  '((sequence "TODO(t)" "NEXT(n)" "WAITING(W@/@)" "|" "DONE(d@)" "CANCELED(C@)")))

(setq org-todo-keyword-faces
      '(("TODO" . (:foreground "DarkOrange1" :weight bold))
        ("NEXT" . (:foreground "sea green"))
        ("WAITING" . (:foreground "blue"))
        ("DONE" . (:foreground "light sea green"))
	("CANCELED" . (:foreground "red"))))

(setq org-clock-into-drawer "CLOCK")
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
;;; capture templates
(setq org-capture-templates
 '(("t" "Todo" entry (file+headline "~/org/current/Refile.org" "Tasks")
        "* TODO %?\n %i\n")
   ("j" "Journal" entry (file+datetree "~/org/current/Journal.org")
        "* %?\nEntered on %U\n %i\n")))

;;; refile targets
(setq org-refile-targets (quote ((org-agenda-files :maxlevel . 9))))

;; agenda setups from Charles Cave (members.optusnet.com.au/~charles57/GTD/)
(setq org-agenda-exporter-settings
      '((ps-number-of-columns 1)
        (ps-landscape-mode t)
        (htmlize-output-type 'css)))

(setq org-agenda-custom-commands
'(

("P" "Projects"   
((tags "PROJECT")))

("H" "Office and Home Lists"
     ((agenda)
          (tags-todo "OFFICE")
          (tags-todo "HOME")
          (tags-todo "COMPUTER")
          (tags-todo "DVD")
          (tags-todo "READING")))

("D" "Daily Action List"
     (
          (agenda "" ((org-agenda-ndays 1)
                      (org-agenda-sorting-strategy
                       (quote ((agenda time-up priority-down tag-up) )))
                      (org-deadline-warning-days 0)
                      ))))
)
)

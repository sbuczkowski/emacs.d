;; start server mode
(server-start)

;; Disable the splash screen (to enable it agin, replace the t with 0)
(setq inhibit-splash-screen t)

;; Enable transient mark mode
(transient-mark-mode 1)

(tool-bar-mode -1)
(menu-bar-mode -1)

;; Install use-package if necessary
(require 'package)
(setq package-enable-at-startup nil)
;; add MELPA for packages
(setq package-archives (append package-archives
			 '(("melpa" . "http://melpa.org/packages/"))))
			 
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Enable use-package
(eval-when-compile
  ;; load-path needed if using externally built use-package
  ;;(add-to-list 'load-path "/Users/steven/.emacs.d/elpa/use-package-20221209.2013")
  (require 'use-package))

(use-package diminish :ensure t)

:;; uncomment below to use theme packages
;; (use-package afternoon-theme
;; :ensure t
;; :config
;; (load-theme 'afternoon t))
(load-theme 'tango-dark t)
(set-face-attribute'default nil :height 200)

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; set up xclip (clipboard cut/paste)
(use-package xclip
  :init
  (xclip-mode 1))

;; Enable vertico
(use-package vertico
  :init
  (vertico-mode))

;; A few more useful configurations...
(use-package emacs
  :init
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)

  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode))

  ;; Optionally use the `orderless' completion style.
(use-package orderless
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  ;; Either bind `marginalia-cycle' globally or only in the minibuffer
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init configuration is always executed (Not lazy!)
  :init

  ;; Must be in the :init section of use-package such that the mode gets
  ;; enabled right away. Note that this forces loading the package.
  (marginalia-mode))

(use-package treemacs
  :ensure t)

(use-package winum
  :ensure t
  :config
  (global-set-key (kbd "M-0") 'treemacs-select-window)
  (global-set-key (kbd "M-1") 'winum-select-window-1)
  (global-set-key (kbd "M-2") 'winum-select-window-2)
  (global-set-key (kbd "M-3") 'winum-select-window-3)
  (global-set-key (kbd "M-4") 'winum-select-window-4)
  (global-set-key (kbd "M-5") 'winum-select-window-5)
  (global-set-key (kbd "M-6") 'winum-select-window-6)
  (global-set-key (kbd "M-7") 'winum-select-window-7)
  (global-set-key (kbd "M-8") 'winum-select-window-8)
  (winum-mode))

(use-package consult
  :ensure t)

(use-package embark
  :ensure t

  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t ; only need to install it, embark loads it after consult if found
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

(use-package vterm
  :ensure t)

;; move customization variables out of init.el
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file t)

;; move backup files to common location
(setq backup-directory-alist
      '(("." . "~/emacs.d/backups")))

;; show matching parentheses
(setq show-paren-mode 1)

;; bookmarks
(setq bookmark-default-file "~/.emacs.d/bookmarks")
;; save bookmarks when modified
(setq bookmark-save-flag 1)

;; === Programming & Coding Functions ===
(load-file "~/.emacs.d/config/init-org.el")
(load-file "~/.emacs.d/config/init-magit.el")
(load-file "~/.emacs.d/config/init-coding-julia.el")
(load-file "~/.emacs.d/config/init-tramp.el")
(load-file "~/.emacs.d/config/init-coding-matlab.el")
(load-file "~/.emacs.d/config/init-yasnippets.el")


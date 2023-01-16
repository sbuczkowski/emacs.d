;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; matlab setup
;; Replace path below to be where your matlab.el file is.
(add-to-list 'load-path "~/.emacs.d/elisp/matlab-emacs-src")
(load-library "matlab-load")

;; Enable CEDET feature support for MATLAB code. (Optional)
(matlab-cedet-setup)

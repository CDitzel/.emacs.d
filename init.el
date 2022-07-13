;; bootstrap straight.el as the package manager of choice instead of package.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; use 'use-package' as default for straight for additional syncatic config sugar instead of straight-use-package

(straight-use-package 'use-package)

;; no more having to use :straight t in (use-package ...)
(setq straight-use-package-by-default t)
(require 'gnutls)
;; You can still provide a custom recipe for a package if desired
; (use-package el-patch
;  :straight (el-patch :type git :host github :repo "raxod502/el-patch"
;                      :fork (:host github
;                             :repo "your-name/el-patch")))


;; The :ensure-system-package keyword allows you to ensure system binaries exist alongside your package declarations.
;; https://github.com/jwiegley/use-package#use-package-ensure-system-package
(use-package use-package-ensure-system-package)

;; This is the actual config file. It is omitted if it doesn't exist so emacs won't refuse to launch.
(when (file-readable-p "~/.emacs.d/config.org")
  (org-babel-load-file (expand-file-name "~/.emacs.d/config.org")))

(defun ditzel/visit-emacs-config () (interactive) (find-file "~/.emacs.d/config.org"))
(global-set-key (kbd "C-c e") 'ditzel/visit-emacs-config)

;(emacs-lisp-byte-compile-and-load "./bazel.el" t)
;(add-to-list 'load-path "./bazel.el")
;(auto-laod "./bazel.el")
;; (byte-compile-file "home/ubuntu/.emacs.d/bazel.el" 'load)
(byte-compile-file (expand-file-name "~/.emacs.d/bazel.el") 'load)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-indicator-zero-based nil)
 '(column-number-mode nil)
 '(custom-enabled-themes '(manoj-dark))
 '(ediff-diff-options "-w")
 '(ediff-split-window-function 'split-window-vertically)
 '(ediff-window-setup-function 'ediff-setup-windows-plain)
 '(flymake-mode-line-counter-format nil)
 '(flymake-mode-line-format nil)
 '(mode-line-percent-position nil)
 '(rg-default-alias-fallback "everything"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(eglot-highlight-symbol-face ((t (:inherit nil))))
 '(eglot-mode-line ((t nil)))
 '(show-paren-match ((t (:background "blue4")))))

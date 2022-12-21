(require 'package)
(add-to-list 'package-archives 
    '("MELPA" .
      "http://melpa.org/packages/"))
(package-initialize)
										;
(package-install 'expand-region)
(package-install 'avy)
(package-install 'multiple-cursors)
(package-install 'bind-key)
(package-install 'magit)
(package-install 'rg)

(add-hook 'after-init-hook (lambda () (load-theme 'manone t)))
(add-hook 'icomplete-minibuffer-setup-hook (lambda () (setq-local completion-styles '(substring flex))))
;(add-hook 'text-mode-hook 'turn-on-auto-fill)
;(byte-compile-file (expand-file-name "~/.emacs.d/cuda-mode.el") 'load)
                                        ;(byte-compile-file (expand-file-name "~/.emacs.d/bazel.el") 'load)


(setq-default cursor-in-non-selected-windows nil
			  inhibit-startup-screen t
			  initial-scratch-message nil
			  isearch-repeat-on-direction-change t
			  isearch-lazy-count t
			  lazy-highlight-initial-delay 0
			  save-interprogram-paste-before-kill t
			  lazy-highlight-cleanup nil
			  lazy-highlight-buffer t
			  mouse-yank-at-point t
			  echo-keystrokes 0.1
			  save-place-mode t
			  scroll-preserve-screen-position 'always
			  help-window-select t
			  confirm-kill-emacs 'y-or-n-p
			  use-dialog-box nil
			  create-lockfiles nil
			  auto-save-default nil
			  make-backup-files nil
			  abbrev-mode t
			  avy-timeout-seconds 0.2
			  tab-bar-mode t
			  tab-bar-show nil
			  tab-bar-new-tab-choice "*scratch*"
			  show-paren-delay 0
			  use-short-answers t
			  global-auto-revert-non-file-buffers t
			  auto-revert-verbose nil
			  dired-auto-revert-buffer t
			  window-combination-resize t
			  completion-auto-help nil
			  recentf-max-saved-items nil
			  recentf-max-menu-items 25
			  dired-recursive-copies 'always
			  dired-recursive-deletes 'always
			  dired-dwim-target t
			  dired-listing-switches "-lAFGh1v --group-directories-first"
			  dired-kill-when-opening-new-dired-buffer t
			  ediff-window-setup-function 'ediff-setup-windows-plain
			  ediff-split-window-function (quote split-window-horizontally)
			  gud-gdb-command-name "gdb --i=mi "
			  gdb-many-windows t
			  x-super-keysym 'ctrl
			  icomplete-compute-delay 0 
			  max-mini-window-height 10
			  resize-mini-windows 'grow-only
			  isearch-wrap-pause 'no
			  magit-display-buffer-function 'magit-display-buffer-same-window-except-diff-v1
			  tab-width 4
			  tab-always-indent t
			  ff-always-try-to-create nil
                          ff-ignore-include t	
			  ff-quiet-mode t
			  eldoc-echo-area-use-multiline-p nil
			  )

(setq-default indent-tabs-mode nil)
(setq-default tab-width 8)
(setq indent-line-function 'insert-tab)
(setq c-default-style "linux") 
(setq c-basic-offset 4) 
(c-set-offset 'comment-intro 0)

(global-auto-revert-mode 1)
(add-to-list'default-frame-alist '(fullscreen . maximized))
(show-paren-mode t)
(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cuh\\'" . c++-mode))

(fido-vertical-mode t)
(fringe-mode 0)
(savehist-mode 1)
(recentf-mode t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(tooltip-mode -1)
(scroll-bar-mode -1)
(delete-selection-mode t)
(global-visual-line-mode 0)
(global-subword-mode 1)

(require 'view)
(require 'eglot)
(setq eglot-ignored-server-capabilites '(:documentHighlightProvider))

(require 'rg)
  
(rg-define-search rg-everything
  "Search everything."
  :files "everything"
  :confirm prefix
  :menu ("Search" "e" "Everything"))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '((c-mode c++-mode)
                 . ("clangd-15"
                    "-j=16"
                    "--log=error"
                    "--malloc-trim"
                    "--background-index"
                    "--clang-tidy"
                    "--cross-file-rename"
                    "--completion-style=detailed"
                    "--pch-storage=memory"
                    "--header-insertion=never"
                    "--header-insertion-decorators=0"))))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)

(define-abbrev-table 'global-abbrev-table '(
					    ("pr" "printf(\"%d\\n\", @@);")
					    ("ex" "exit(1);")
					    ("os" "std::cout << @@ << \"\\n\";")
					    ("rr" "- [ ]")
					    ("fr" "for(int i = 0; i < @@; ++i){}")
					    ("cd" "// TODO(cditzel MB):")))

 (defadvice expand-abbrev (after my-expand-abbrev activate)
   (if ad-return-value
       (run-with-idle-timer 0 nil
                            (lambda ()
                              (let ((cursor "@@"))
                                (if (search-backward cursor last-abbrev-location t)
                                    (delete-char (length cursor))))))))


(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active
       (list (region-beginning) (region-end))
     (list (line-beginning-position) (line-beginning-position 2)))))

(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive
   (if mark-active
       (list (region-beginning) (region-end))
     (message "Copied line")
     (list (line-beginning-position) (line-beginning-position 2)))))

(define-key input-decode-map (kbd "C-i") (kbd "H-i"))
(global-unset-key (kbd "C-x C-z"))

(defvar my-cpp-other-file-alist
  '(("\\.cpp\\'" (".hpp" ".cuh"))
    ("\\.hpp\\'" (".cpp"".cu"))
    ("\\.cuh\\'" (".cu" ".cpp"))
    ("\\.cu\\'" (".cuh" ".hpp"))
    ("\\.c\\'" (".h"))
    ("\\.h\\'" (".c"))
    ))
(setq-default ff-other-file-alist 'my-cpp-other-file-alist)

(bind-keys*
 ("C-o" . other-window)
 ("<C-return>" . (lambda () (interactive)(move-end-of-line nil) (newline-and-indent)))
 ("<S-return>". (lambda () (interactive)(beginning-of-line nil)(newline-and-indent)(forward-line -1) (indent-according-to-mode)))
 ("C-x 3" .  (lambda () (interactive)(split-window-horizontally) (other-window 1)))
 ("C-c w" . (lambda () (interactive) (find-file "~/org/wiki/wiki.org")))
 ("C-c d" . (lambda () (interactive) (find-file "~/org/wiki/daimler.org")))
 ("C-c e" . (lambda () (interactive) (find-file "~/.emacs.d/init.el")))
 ("C-a" . (lambda () (interactive) (if (= (point) (progn (back-to-indentation) (point))) (beginning-of-line))))
 ("C-1" . (lambda () (interactive)(tab-bar-select-tab 1)))
 ("C-2" . (lambda () (interactive)(tab-bar-select-tab 2)))
 ("C-3" . (lambda () (interactive)(tab-bar-select-tab 3)))
 ("C-4" . (lambda () (interactive)(tab-bar-select-tab 4)))
 ("C-," . comment-line)
 ("C-x b". ibuffer)
 ("C-x k". kill-current-buffer)
 ("H-i" . goto-line)
 ("M-j" . (lambda () (interactive) (let ((current-prefix-arg 1)) (call-interactively #'delete-indentation))))
 ("C-x 2" . tab-bar-new-tab)
 ("C-`" . ff-find-related-file)
 ;("C-<backspace>" . (lambda () (interactive) (kill-line 0)))
 ("C-u" . (lambda () (interactive) (let ((opoint  (point))) (back-to-indentation) (delete-region (point) opoint))))
 ("C-c f" . bookmark-jump)
 ("C-x C-d" . dired)
 ("C-c C-n" . switch-to-buffer)
 ("C-x d" . find-name-dired)
 ("C-c C-r" . rg-everything)
 ("C-r" . recentf)
 ("M-n" . scroll-up-line)
 ("M-p" . scroll-down-line)
 ("C-." . goto-last-change)
 ("C-j" . avy-goto-char-timer)
 ("C-c C-e" . mc/edit-lines)
 ("C-'" . er/expand-region)
 ("C-;" . er/contract-region)
 ("C-c r" . eval-buffer)
 ("C-t" . duplicate-line)
 ("C-c g" . magit-status)
 ("C-v" . View-scroll-half-page-forward)
 ("M-v" . View-scroll-half-page-backward)
 ("C-c g" . magit-status)
 )
        
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("b6c3d87ff5f2b31a9e34955af2b87dc5bdac90a743f31ce5c424c0891e731720" default))
 '(eldoc-documentation-strategy 'eldoc-documentation-compose-eagerly)
 '(mc/always-repeat-command t)
 '(package-selected-packages
   '(tree-sitter tree-sitter-langs rg magit bind-key multiple-cursors avy expand-region))
 '(xref-after-jump-hook '(recenter))
 '(xref-after-return-hook nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(eglot-highlight-symbol-face ((t nil)))
 '(eglot-mode-line ((t nil))))


(split-window-right)
(tab-bar-new-tab)
(split-window-right)
(tab-bar-new-tab)
(split-window-right)
(tab-bar-new-tab)
(split-window-right)
(tab-bar-select-tab 1)


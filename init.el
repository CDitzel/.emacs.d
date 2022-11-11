(package-install 'expand-region)
(package-install 'avy)
(package-install 'multiple-cursors)
(package-install 'bind-key)
(package-install 'magit)

(desktop-read "~/.emacs")

(add-hook 'after-init-hook (lambda () (load-theme 'manone t)))
(add-hook 'icomplete-minibuffer-setup-hook (lambda () (setq-local completion-styles '(substring flex))))
(add-hook 'text-mode-hook 'turn-on-auto-fill)
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
			  eldoc-echo-area-use-multiline-p 1
			  )

(desktop-save-mode 1)
(subword-mode 1)
(global-auto-revert-mode 1)
(add-to-list'default-frame-alist '(fullscreen . maximized))
(show-paren-mode t)
(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cuh\\'" . c++-mode))

;; minibuffer should show errors
;; go to next clang error functinality

(fido-vertical-mode t)
(fringe-mode 0)
(savehist-mode 1)
(recentf-mode t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(tooltip-mode -1)
(scroll-bar-mode -1)
(delete-selection-mode t)
(subword-mode t)
(global-visual-line-mode 1)

(require 'view)
(require 'eglot)

 (with-eval-after-load 'eglot
   (add-to-list 'eglot-server-programs
                '((c-mode c++-mode cuda-mode)
                 . ("clangd-15"
                    "-j=8"
                    "--log=error"
                    "--malloc-trim"
                    "--background-index"
                    "--clang-tidy"
                    "--cross-file-rename"
                    "--completion-style=detailed"
                    "--pch-storage=memory"
                    "--header-insertion=never"
                    "--header-insertion-decorators=0"))))


(define-abbrev-table 'global-abbrev-table '(
											("ex" " exit(1);")
											("os" " std::cout << << std::endl;")
											("rr" "- [ ]")
											("cd" "// TODO(cditzel MB):")))

(defun system-is-lenovo ()
  (interactive)
  (string-equal (system-name) "lenovo"))
(if (system-is-lenovo)
    (set-face-attribute 'default nil :height 200))

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

(add-hook 'eglot-managed-mode-hook
          (lambda ()
            ;; Show flymake diagnostics first.
            (setq eldoc-documentation-functions
                  (cons #'flymake-eldoc-function
                        (remove #'flymake-eldoc-function eldoc-documentation-functions)))
            ;; Show all eldoc feedback.
            (setq eldoc-documentation-strategy #'eldoc-documentation-compose)))

(bind-keys*
 ("C-h C-s" . isearch-forward-symbol-at-point)
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
 ("C-," . comment-line)
 ("C-x b". ibuffer)
 ("C-x k". kill-current-buffer)
 ("H-i" . goto-line)
 ("M-j" . (lambda () (interactive) (let ((current-prefix-arg 1)) (call-interactively #'delete-indentation))))
 ("C-x 2" . tab-bar-new-tab)
 ;; ("C-`" . (lambda () (interactive) (switch-to-buffer (other-buffer (current-buffer) 1))))
 ("C-`" . ff-find-other-file)
 ("C-<backspace>" . (lambda () (interactive) (kill-line 0)))
 ("C-c f" . bookmark-jump)
 ("C-x C-d" . dired)
 ("C-c C-n" . switch-to-buffer)
 ("C-x d" . find-name-dired)
 ("C-c C-r" . rgrep)
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
 '(package-selected-packages '(ccls magit bind-key multiple-cursors avy expand-region)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

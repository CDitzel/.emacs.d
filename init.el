(require 'package)
(add-to-list 'package-archives 
             '("MELPA" .
               "http://melpa.org/packages/"))
(package-initialize)

(package-install 'expand-region)
(package-install 'avy)
(package-install 'multiple-cursors)
(package-install 'bind-key)
(package-install 'magit)
(package-install 'rg)
(package-install 'git-timemachine)

(add-hook 'after-init-hook (lambda () (load-theme 'manone t)))
(add-hook 'icomplete-minibuffer-setup-hook (lambda () (setq-local completion-styles '(substring basic))))
;(add-hook 'text-mode-hook 'turn-on-auto-fill)

(if (string-equal (system-name) "lenovo")
    (set-face-attribute 'default nil :height 160)
  (setq x-super-keysym 'ctrl))

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
					;ff-ignore-include t
			        ;ff-quiet-mode t
			        eldoc-echo-area-use-multiline-p 1
					xref-after-return-hook nil
					xref-after-jump-hook '(recenter)
					ff-other-file-alist 'my-cpp-other-file-alist
					;; ff-other-file-alist '("\\.cu\\'" (".cuh" ".hpp"))
			        )

(unless (boundp 'done-set-tab-layout)
  (split-window-right)
  (tab-bar-new-tab)
  (split-window-right)
  (tab-bar-new-tab)
  (split-window-right)
  (tab-bar-new-tab)
  (split-window-right)
  (tab-bar-select-tab 1)
  (setq done-set-tab-layout t))

;(setq-default indent-tabs-mode nil)
;(setq-default tab-width 2)
;(setq indent-line-function 'insert-tab)
;(setq c-default-style "linux") 
;(setq-default c-basic-offset 2) 
;(c-set-offset 'comment-intro 0)
(setq c-default-style "linux") 
(setq c-basic-offset 4)


(add-to-list'default-frame-alist '(fullscreen . maximized))
(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cuh\\'" . c++-mode))

(global-auto-revert-mode 1)
(show-paren-mode t)
(electric-pair-mode 1)
(fido-vertical-mode t)
(fringe-mode 0)
(savehist-mode 1) ;; save minibuffer history
(recentf-mode t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(tooltip-mode -1)
(scroll-bar-mode -1)
(delete-selection-mode t)
(global-visual-line-mode t)
(global-subword-mode 1)
(global-eldoc-mode nil)

(require 'view)
;(require 'rg)
;(require 'eglot)
;(setq eglot-ignored-server-capabilites '(:documentHighlightProvider))
(setq eglot-ignored-server-capabilites '(:hoverProvider))

(rg-define-search rg-everything
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
  '(
	("\\.cpp\\'" (".hpp" ".cuh"))
   ("\\.hpp\\'" (".cpp"".cu"))
   ("\\.cuh\\'" (".cu" ".cpp"))
   ("\\.cu\\'" (".cuh" ".hpp"))
   ("\\.c\\'" (".h"))
   ("\\.h\\'" (".c"))
   ))

(defun prot-search-isearch-abort-dwim ()
"This is a modified variant of `isearch-abort' that allows us to
perform the following, based on the specifics of the case: (i)
delete the entirety of a non-matching part, when present; (ii)
delete a single character, when possible; (iii) exit current
search if no character is present and go back to point where the
search started."
  (interactive)
  (if (eq (length isearch-string) 0)
      (isearch-cancel)
    (isearch-del-char)
    (while (or (not isearch-success) isearch-error)
      (isearch-pop-state)))
  (isearch-update))

(define-key isearch-mode-map (kbd "<backspace>") 'prot-search-isearch-abort-dwim)


(defun my-isearch-forward-symbol-at-point ()
  "`isearch-forward-symbol-at-point', but copy symbol name to `kill-ring'."
  (interactive)
  (isearch-forward-symbol nil 1)
  (let* ((bounds  (find-tag-default-bounds))
         (string  (and bounds  (buffer-substring-no-properties
                                 (car bounds) (cdr bounds)))))
    (cond
     (string
      (kill-new string)
      (when (< (car bounds) (point))(goto-char (car bounds)))
      (isearch-yank-string string))
     (t
      (setq isearch-error "No symbol at point")
      (isearch-push-state)
      (isearch-update)))))


(defun endless/isearch-symbol-with-prefix (p)
  "Like isearch, unless prefix argument is provided.
With a prefix argument P, isearch for the symbol at point."
  (interactive "P")
  (let ((current-prefix-arg nil))
    (call-interactively
     ;(if p #'isearch-forward-symbol-at-point #'isearch-forward))))
     (if p #'my-isearch-forward-symbol-at-point #'isearch-forward))))

(global-set-key [remap isearch-forward] #'endless/isearch-symbol-with-prefix)

(defun mark-inside-sexp ()
  "Mark inside a sexp."
  (interactive)
  (let (beg end)
    (backward-up-list 1 t t)
    (setq beg (1+ (point)))
    (forward-sexp)
    (setq end (1- (point)))
    (goto-char beg)
    (push-mark)
    (goto-char end))
  (activate-mark))

(defun move-line-down ()
  (interactive)
  (let ((col (current-column)))
    (save-excursion
      (forward-line)
      (transpose-lines 1))
    (forward-line)
    (move-to-column col)))

(defun move-line-up ()
  (interactive)
  (let ((col (current-column)))
    (save-excursion
      (forward-line)
      (transpose-lines -1))
    (move-to-column col)))

(bind-keys*
 ("C-o" . other-window)
 ("<C-return>" . (lambda () (interactive)(move-end-of-line nil) (newline-and-indent)))
 ("<S-return>". (lambda () (interactive)(beginning-of-line nil)(newline-and-indent)(forward-line -1) (indent-according-to-mode)))
 ("C-x 3" .  (lambda () (interactive)(split-window-horizontally) (other-window 1)))
 ("C-c w" . (lambda () (interactive) (find-file "~/org/wiki/wiki.org")))
 ("C-c d" . (lambda () (interactive) (find-file "~/org/wiki/daimler.org")))
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
 ("C-`" . (lambda () (interactive) (ff-find-other-file nil t)))
 ("C-<backspace>" . (lambda () (interactive) (let ((opoint  (point))) (back-to-indentation) (delete-region (point) opoint))))
 ("C-c f" . bookmark-jump)
 ("C-x C-d" . dired)
 ("C-x d" . find-name-dired)
 ("C-r" . rg-everything)
 ("C-c C-n" . recentf)
 ("M-n" . scroll-up-line)
 ("M-p" . scroll-down-line)
 ("s-p" . move-line-up)
 ("s-n" . move-line-down)
 ("C-." . goto-last-change)
 ("C-j" . avy-goto-char-timer)
 ("C-c e" . mc/edit-lines)
 ;("C-'" . er/expand-region)
 ;("C-;" . er/contract-region)
 ("C-t" . duplicate-line)
 ("C-c g" . magit-status)
 ("C-v" . View-scroll-half-page-forward)
 ("M-v" . View-scroll-half-page-backward)
 ("C-c g" . magit-status)
 ("C-c t" . git-timemachine)
 ("M-s ." . my-isearch-forward-symbol-at-point)
 ("C-m" . mark-inside-sexp)
 )


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(git-timemachine expand-region avy multiple-cursors bind-key magit rg tree-sitter-langs)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(global-set-key (kbd "C-x g") 'webjump)

;; Add Urban Dictionary to webjump
(eval-after-load "webjump"
'(add-to-list 'webjump-sites
              '("Urban Dictionary" .
                [simple-query
                 "www.urbandictionary.com"
                 "http://www.urbandictionary.com/define.php?term="
                 ""])))

;; bootstrap straight.el as the package manager of choice instead of package.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

(defun ditzel/visit-emacs-config () (interactive) (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "C-c e") 'ditzel/visit-emacs-config)

;(byte-compile-file (expand-file-name "~/.emacs.d/bazel.el") 'load)

(setq isearch-repeat-on-direction-change t)
(setq isearch-lazy-count t)
(setq lazy-highlight-cleanup nil)
(setq lazy-highlight-buffer t)
(setq x-super-keysym 'ctrl)
(setq scroll-margin 3)
(setq inhibit-startup-screen 1)
(setq initial-scratch-message nil)
(setq mouse-yank-at-point t)
(setq-default cursor-in-non-selected-windows nil)
(setq echo-keystrokes 0)
(setq save-place-mode 1)
(setq scroll-preserve-screen-position 'always)
(setq confirm-kill-emacs 'y-or-n-p)
(setq use-dialog-box nil)
(setq lazy-highlight-initial-delay 0)
(setq create-lockfiles nil)
(setq auto-save-default nil)
(setq make-backup-files nil)
(setq tab-bar-mode t)
(setq tab-bar-show nil)
(setq tab-bar-new-tab-choice "*scratch*")
(setq show-paren-delay 0)
(setq use-short-answers t)
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)
(setq dired-auto-revert-buffer t)
(setq window-combination-resize t)
(setq completion-auto-help nil)
(setq recentf-max-saved-items nil)
(setq recentf-max-menu-items 25)
(setq dired-dwim-target t)
(setq dired-listing-switches "-lAFGh1v --group-directories-first")
(setq dired-kill-when-opening-new-dired-buffer t)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function (quote split-window-horizontally))
(setq magit-display-buffer-function 'magit-display-buffer-same-window-except-diff-v1)
(global-auto-revert-mode)
(add-to-list'default-frame-alist '(fullscreen . maximized))
(show-paren-mode t)
(add-to-list 'auto-mode-alist '("\.cu$" . c++-mode))
(run-at-time nil (* 30 60) 'recentf-save-list)
(fido-vertical-mode 1)
(fringe-mode 0)
(recentf-mode t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(tooltip-mode -1)
(scroll-bar-mode -1)
(delete-selection-mode t)

(require 'eglot)
(add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd-15"))
(setq eldoc-echo-area-use-multiline-p 1)

(setq-default abbrev-mode t)
(define-abbrev-table 'global-abbrev-table '(
					    ("rr" "- [ ]")
					    ("cd" "// TODO(cditzel MB): ")))
(load "~/.emacs.d/my-manoj-dark-theme.el")

(defun system-is-lenovo ()
  (interactive)
  (string-equal system-name "lenovo"))
(if (system-is-lenovo)
    (set-face-attribute 'default nil :height 200))

(defun switch-to-previous-buffer ()
  "Switch to most recent buffer. Repeated calls toggle back and forth between the most recent two buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(defun my/get-positions-of-line-or-region ()
  "Return positions (beg . end) of the current line or region."
  (let (beg end)
    (if (and mark-active (> (point) (mark)))
	(exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
	(exchange-point-and-mark))
    (setq end (line-end-position))
    (cons beg end)))

(defun duplicate-and-comment-current-line-or-region (arg)
  "Duplicates and comments the current line or region ARG times.
If there's no region, the current line will be duplicated.  However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (pcase-let* ((origin (point))
	       (`(,beg . ,end) (my/get-positions-of-line-or-region))
	       (region (buffer-substring-no-properties beg end)))
    (comment-or-uncomment-region beg end)
    (setq end (line-end-position))
    (dotimes (_ arg)
      (goto-char end)
      (unless (use-region-p)
	(newline))
      (insert region)
      (setq end (point)))
    (goto-char (+ origin (* (length region) arg) arg))))

(defun my/split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))

(defun top-join-line ()
  (interactive)
  (delete-indentation 1))

(defun join-region (beg end)
  (interactive "r")
  (if mark-active
      (let ((beg (region-beginning))
	    (end (copy-marker (region-end))))
	(goto-char beg)
	(while (< (point) end)
	  (join-line 1)))))

(defun smart-join-line (beg end)
  (interactive "r")
  (if mark-active
      (join-region beg end)
    (top-join-line)))

(defun open-line-below ()
  (interactive)
  (move-end-of-line nil)
  (newline-and-indent))

(defun open-line-above ()
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank))

;; Dont kill but switch buffer in the future
;; C-x TAB after highlighting region to indent 
;; C-M-f,b,a,e,n,p etc. moves in larger chunks
;; C-u C-SPC back to saved mark
;; C-M-v scroll-other-window and C-M-S-v scroll-other-window-down
;; backard / forward paragraph (M-{ / M-}
;; C-M-a and C-M-e to move back and forward a function at a time.
;; [[\[\[https://www.masteringemacs.org/article/effective-editing-movement\]\]][Efficienly move within Emacs]]
;; C-u C-s mark word under points -> C-s to find further occurences, also in other windows. After some time C-s retriggers last search
;; Use M-{ and M-} to move forward or backward by paragraph.
;; Use M-h to mark (highlight) the current paragraph.
;; Pressing C-s or C-r for a second time before entering your search string will reuse the previous search string.
;; M-C-k und M-C-backspace to delete fwd/bwd up to brackets
;; C-l recentres the window while keeping the point on the same line
;; M-r moves the point without recentring the window.
;; C-s C-w [C-w ... ] to search for a word/expression under a cursor.
;; M-o oben line above
;; undo in marked region only
;; fido-mode enables nice features such as icomplete-fido-delete-char
;; (C-d), which deletes the current character or calls dired on the
;; current directory, and icomplete-fido-kill (C-k), which kills the
;; current line or, for instance, if we are completing files asks if we
;; want to delete the selected one. Check icomplete-fido-mode-map for
;; more details on the available key bindings.
;; C-s C-w matching until end of word for search
;; M-s . matching entire word
;; then M-s o calls occur (buffer local) (C-u to call with line ctx) e goes into edit mode
;; C-M-k and M-k
;; M-e to edit failed isearch parts
;; M-s M-.	Search for thing at point (Emacs28)
;; M-s h r	Highlight regexp
;; M-s h u	Undo the highlight
;; C-x n n narrow region
;; C-x n w widen region
;; C-x C-j direc jump
;; With the cursor on an opening parenthesis ([{ etc, use C-M-n to jump
;; to the matching closing one. This works even if there are nested
;; parentheses. You can use C-M-p to go back.
;; M-x (M-p) for cached commands
;; 
;; C-M-... commands

  (require 'view)
  (global-set-key "\C-v"   'View-scroll-half-page-forward)
  (global-set-key "\M-v"   'View-scroll-half-page-backward)
  (global-set-key (kbd "C-x 3") 'my/split-and-follow-vertically)
  (global-set-key (kbd "C-c w") (lambda () (interactive) (find-file "~/org/wiki/wiki.org")))
  (global-set-key (kbd "C-c d") (lambda () (interactive) (find-file "~/org/wiki/daimler.org")))
  (global-set-key (kbd "C-1") (lambda () (interactive) (tab-bar-select-tab 1)))
  (global-set-key (kbd "C-2") (lambda () (interactive) (tab-bar-select-tab 2)))
  (global-set-key (kbd "C-3") (lambda () (interactive) (tab-bar-select-tab 3)))
  (global-set-key (kbd "M-m") 'goto-last-change)
  (global-set-key (kbd "C-r") 'recentf)
  (global-set-key (kbd "C-,") 'comment-line)
  (global-set-key (kbd "C-x k") 'kill-current-buffer)
  (define-key input-decode-map (kbd "C-i") (kbd "H-i"))
  (global-set-key (kbd "H-i") 'goto-line)
  (global-set-key (kbd "M-j") 'smart-join-line)
  (global-set-key (kbd "C-t") 'duplicate-line)
  (global-set-key (kbd "C-o") (kbd "C-x o"))
  (global-set-key (kbd "M-a") (kbd "C-M-a"))
  (global-set-key (kbd "M-e") (kbd "C-M-e"))
  (global-set-key (kbd "s-n") (kbd "C-u 1 C-v"))
  (global-set-key (kbd "s-p") (kbd "C-u 1 M-v"))
  (global-set-key (kbd "C-x 2") 'tab-bar-new-tab)
  (global-set-key (kbd "C-`") 'switch-to-previous-buffer)
  (global-set-key (kbd "M-t") 'duplicate-and-comment-current-line-or-region)
  (global-set-key (kbd "C-<backspace>") (lambda () (interactive) (kill-line 0)))
  (global-unset-key (kbd "C-x C-z"))
  (global-set-key (kbd "C-c g") 'magit-status)

(bind-keys*
 ("C-c C-r" . rgrep)
 ("C-c C-f" . bookmark-jump)
 ("C-x d" . find-name-dired)
 ("C-x C-d" . dired)
 ("<C-return>" . open-line-below)
 ("<S-return>" . open-line-above)
 ("C-c C-n" . switch-to-buffer)
 ("C-u C-s" . isearch-forward-thing-at-point)
 )

(use-package magit)
;; http://www.howardism.org/Technical/Emacs/magit-squashing.html]

(use-package expand-region)
(bind-keys* ("C-'" . er/expand-region)
	    ("C-;" . er/contract-region))

(use-package whole-line-or-region)
(whole-line-or-region-global-mode t)

(use-package avy)
;; C-j C-j for goto-line 
(bind-keys* ("C-j" . avy-goto-char-timer))
(setq avy-timeout-seconds 0.2)
(setq avy-style 'words)
(setq avy-case-fold-search nil)
(setq avy-all-windows t)

(use-package multiple-cursors
  :bind (("C-c C-SPC" . mc/edit-lines)))

(use-package mood-line
  :init
  (mood-line-mode))
(load "~/.emacs.d/my-manoj-dark-theme.el")

(use-package goto-last-change
  :bind ("M-m" . goto-last-change))


(setenv "PATH" (concat (getenv "PATH")"~/cuda-gdb"))
(setq exec-path (append exec-path '("/home/ubuntu/cuda-gdb")))
(setq exec-path (append exec-path '("/usr/local/cuda-11.8/bin")))
(setq gud-gdb-command-name "cuda-gdb --annotate=3")
(setq gud-gdb-command-name "gdb --i=mi ")
(setq gdb-many-windows t)
(setq gdb-use-separate-io-buffer t)

;; recenter and highlight current line
(defvar gud-overlay
  (let* ((ov (make-overlay (point-min) (point-min))))
    (overlay-put ov 'face '(:background "#22aafF")) ;; colors for Leuven theme
    ov)
  "Overlay variable for GUD highlighting.")
(defadvice gud-display-line (after my-gud-highlight act)
  "Highlight current line."
  (let* ((ov gud-overlay)
	 (bf (gud-find-file true-file)))
    (save-excursion
      (with-selected-window (get-buffer-window bf)
	(save-restriction
	  (goto-line (ad-get-arg 1))
	  (recenter)))
      (set-buffer bf)
      (move-overlay ov (line-beginning-position) (line-end-position)
		    (current-buffer)))))

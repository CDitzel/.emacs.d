(package-install 'expand-region)
(package-install 'avy)
(package-install 'multiple-cursors)
(package-install 'magit)

(add-hook 'after-init-hook (lambda () (load-theme 'manone t)))
(add-hook 'icomplete-minibuffer-setup-hook (lambda () (setq-local completion-styles '(substring))))

(global-auto-revert-mode 1)
(add-to-list'default-frame-alist '(fullscreen . maximized))
(show-paren-mode t)
(add-to-list 'auto-mode-alist '("\.cu$" . c++-mode))
					;(run-at-time nil (* 30 60) 'recentf-save-list)
(fido-vertical-mode 1)
(fringe-mode 0)
(savehist-mode 1)
(recentf-mode t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(tooltip-mode -1)
(scroll-bar-mode -1)
(delete-selection-mode t)
(global-visual-line-mode 1)

(setq-default cursor-in-non-selected-windows nil
	      inhibit-startup-screen 1
	      initial-scratch-message nil
	      isearch-repeat-on-direction-change t
	      isearch-lazy-count t
	      lazy-highlight-initial-delay 0
	      save-interprogram-paste-before-kill t
	      lazy-highlight-cleanup nil
	      lazy-highlight-buffer t
	      mouse-yank-at-point t
	      echo-keystrokes 0
	      save-place-mode 1
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
	      magit-display-buffer-function 'magit-display-buffer-same-window-except-diff-v1
	      magit-ediff-dwim-show-on-hunks t
	      )

(require 'eglot)
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '((c-mode c++-mode)
                 . ("clangd-14"
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
(setq eldoc-echo-area-use-multiline-p 1)

(define-abbrev-table 'global-abbrev-table '(
					    ("rr" "- [ ]")
					    ("cd" "// TODO(cditzel MB): ")))

;; (defun my/get-positions-of-line-or-region ()
;;   "Return positions (beg . end) of the current line or region."
;;   (let (beg end)
;;     (if (and mark-active (> (point) (mark)))
;; 	(exchange-point-and-mark))
;;     (setq beg (line-beginning-position))
;;     (if mark-active
;; 	(exchange-point-and-mark))
;;     (setq end (line-end-position))
;;     (cons beg end)))

;; (defun duplicate-and-comment-current-line-or-region (arg)
;;   "Duplicates and comments the current line or region ARG times.
;; If there's no region, the current line will be duplicated.  However, if
;; there's a region, all lines that region covers will be duplicated."
;;   (interactive "p")
;;   (pcase-let* ((origin (point))
;; 	       (`(,beg . ,end) (my/get-positions-of-line-or-region))
;; 	       (region (buffer-substring-no-properties beg end)))
;;     (comment-or-uncomment-region beg end)
;;     (setq end (line-end-position))
;;     (dotimes (_ arg)
;;       (goto-char end)
;;       (unless (use-region-p)
;; 	(newline))
;;       (insert region)
;;       (setq end (point)))
;;     (goto-char (+ origin (* (length region) arg) arg))))

(defun system-is-lenovo ()
  (interactive)
  (string-equal (system-name) "lenovo"))
(if (system-is-lenovo)
    (set-face-attribute 'default nil :height 200)
  (setq x-super-keysym 'ctrl)
  )

(defun switch-to-previous-buffer ()
  "Switch to most recent buffer"
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

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

;; (defun duplicate-line ()
;;   "Duplicate current line"
;;   (interactive)
;;   (kill-whole-line)
;;   (yank)
;;   (yank))

					;(require 'view)
					;(global-set-key "\C-v"   'View-scroll-half-page-forward)
					;(global-set-key "\M-v"   'View-scroll-half-page-backward)


(define-key input-decode-map (kbd "C-i") (kbd "H-i"))
(global-unset-key (kbd "C-x C-z"))
(define-key isearch-mode-map (kbd "C-j") 'isearch-forward-thing-at-point)

(defvar my-keys-minor-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "<C-return>") 'open-line-below)
    (define-key map (kbd "<S-return>") 'open-line-above)
    (define-key map (kbd "C-o") 'other-window)
    (define-key map (kbd "C-x 3") (lambda () (interactive)(split-window-horizontally) (other-window 1)))
    (define-key map (kbd "C-c w") (lambda () (interactive) (find-file "~/org/wiki/wiki.org")))
    (define-key map (kbd "C-c d") (lambda () (interactive) (find-file "~/org/wiki/daimler.org")))
    (define-key map (kbd "C-c e") (lambda () (interactive) (find-file "~/.emacs.d/init.el")))
    (define-key map (kbd "C-c t") (lambda () (interactive) (find-file "~/fritzNAS/test.org")))
    (define-key map (kbd "C-a") (lambda () (interactive) (if (= (point) (progn (back-to-indentation) (point))) (beginning-of-line))))
    (define-key map (kbd "C-1") 'tab-bar-select-tab 1)
    (define-key map (kbd "C-2") 'tab-bar-select-tab 2)
    (define-key map (kbd "C-3") 'tab-bar-select-tab 3)
    (define-key map (kbd "C-,") 'comment-line)
    (define-key map (kbd "C-x b") 'ibuffer)
    (define-key map (kbd "C-x k") 'kill-current-buffer)
    (define-key map (kbd "H-i") 'goto-line)
    (define-key map (kbd "M-j") 'smart-join-line)
    ;; (define-key map (kbd "C-t") 'duplicate-line)
    (define-key map (kbd "C-x 2") 'tab-bar-new-tab)
    (define-key map (kbd "C-`") 'switch-to-previous-buffer)
    ;; (define-key map (kbd "M-t") 'duplicate-and-comment-current-line-or-region)
    (define-key map (kbd "C-<backspace>") (lambda () (interactive) (kill-line 0)))
    (define-key map (kbd "C-c f") 'bookmark-jump)
    (define-key map (kbd "C-x C-d") 'dired)
    (define-key map (kbd "C-c C-n") 'switch-to-buffer)
    (define-key map (kbd "C-x d") 'find-name-dired)
    (define-key map (kbd "C-c C-r") 'rgrep)
    (define-key map (kbd "C-r") 'recentf)
    (define-key map (kbd "s-n") (kbd "C-u 1 C-v"))
    (define-key map (kbd "s-p") (kbd "C-u 1 M-v"))
    (define-key map (kbd "C-.") 'goto-last-change)
    (define-key map (kbd "C-j") 'avy-goto-char-timer)
    (define-key map (kbd "C-c C-SPC") 'mc/edit-lines)
    (define-key map (kbd "C-'") 'er/expand-region)
    (define-key map (kbd "C-;") 'er/contract-region)
    (define-key map (kbd "M-C-s") 'isearch-forward-thing-at-point)
    (define-key map (kbd "C-c r") 'eval-buffer)
    (define-key map (kbd "C-c g") 'magit-status)
    map)
  "my-keys-minor-mode keymap.")

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  :init-value t
  :lighter " my-keys")

(my-keys-minor-mode 1)

(setenv "PATH" (concat (getenv "PATH")"~/cuda-gdb"))
(setq exec-path (append exec-path '("/home/ubuntu/cuda-gdb")))
(setq exec-path (append exec-path '("/usr/local/cuda-11.8/bin")))
					;(setq gud-gdb-comanmd-name "cuda-gdb --annotate=3")
(setq gud-gdb-command-name "gdb --i=mi ")
(setq gdb-many-windows t)
					;(setq gdb-use-separate-io-buffer t)

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

;; Dont kill but switch buffer in the future
;; C-x TAB after highlighting region to indent
;; C-M-f,b,a,e,n,p etc. moves in larger chunks
;; C-u C-SPC back to saved mark
;; C-M-v scroll-other-window and C-M-S-v scroll-other-window-down
;; backard / forward paragraph (M-{ / M-}
;; C-M-a and C-M-e to move back and forward a function at a time.
;; C-u C-s mark word under points -> C-s to find further occurences, also in other windows. After some time C-s retriggers last search
;; Use M-{ and M-} to move forward or backward by paragraph.
;; Use M-h to mark (highlight) the current paragraph.
;; Pressing C-s or C-r for a second time before entering your search string will reuse the previous search string.
;; M-C-k und M-C-backspace to delete fwd/bwd up to brackets
;; C-l recentres the window while keeping the point on the same line
;; M-r moves the point without recentring the window.
;; C-s C-w [C-w ... ] to search for a word/expression under a cursor.
;; undo in marked region only
;; M-m beginn of indentation
;; C-s C-w matching until end of word for search
;; M-s . matching entire word
;; then M-s o calls occur (buffer local) (C-u to call with line ctx) and e goes into edit mode
;; C-M-k and M-k
;; M-e to edit failed isearch parts
;; M-s h r	Highlight regexp
;; M-s h u	Undo the highlight
;; C-x n n narrow region
;; C-x n w widen region
;; C-x C-j dired-jump
;; With the cursor on an opening parenthesis ([{ etc, use C-M-n to jump
;; to the matching closing one. This works even if there are nested
;; parentheses. You can use C-M-p to go back.
;; M-x (M-p) for cached commands
;;M-n		isearch-ring-advance
;;M-p		isearch-ring-retreat
;; C-M-... commands
;; find-file then M-n for find-file-at-point, i.e. insert current file

(defvar goto-last-change-undo nil
  "The `buffer-undo-list' entry of the previous \\[goto-last-change] command.")
(make-variable-buffer-local 'goto-last-change-undo)


(defun goto-last-change (&optional mark-point minimal-line-distance)
  "Set point to the position of the last change.
Consecutive calls set point to the position of the previous change.
With a prefix arg (optional arg MARK-POINT non-nil), set mark so \
\\[exchange-point-and-mark]
will return point to the current position."
  (interactive "P")
  (when (eq buffer-undo-list t)
    (error "No undo information in this buffer"))
  (when mark-point
    (push-mark))
  (unless minimal-line-distance
    (setq minimal-line-distance 10))
  (let ((position nil)
	(undo-list (if (and (eq this-command last-command)
			    goto-last-change-undo)
		       (cdr (memq goto-last-change-undo buffer-undo-list))
		     buffer-undo-list))
	undo)
    (while (and undo-list
                (or (not position)
                    (eql position (point))
                    (and minimal-line-distance
                         ;; The first invocation always goes to the last change, subsequent ones skip
                         ;; changes closer to (point) then minimal-line-distance.
                         (memq last-command '(goto-last-change
                                              goto-last-change-with-auto-marks))
                         (< (count-lines (min position (point-max)) (point))
                            minimal-line-distance))))
      (setq undo (car undo-list))
      (cond ((and (consp undo) (integerp (car undo)) (integerp (cdr undo)))
	     ;; (BEG . END)
	     (setq position (cdr undo)))
	    ((and (consp undo) (stringp (car undo))) ; (TEXT . POSITION)
	     (setq position (abs (cdr undo))))
	    ((and (consp undo) (eq (car undo) t))) ; (t HIGH . LOW)
	    ((and (consp undo) (null (car undo)))
	     ;; (nil PROPERTY VALUE BEG . END)
	     (setq position (cdr (last undo))))
	    ((and (consp undo) (markerp (car undo)))) ; (MARKER . DISTANCE)
	    ((integerp undo))		; POSITION
	    ((null undo))		; nil
	    (t (error "Invalid undo entry: %s" undo)))
      (setq undo-list (cdr undo-list)))
    (cond (position
	   (setq goto-last-change-undo undo)
	   (goto-char (min position (point-max))))
	  ((and (eq this-command last-command)
		goto-last-change-undo)
	   (setq goto-last-change-undo nil)
	   (error "No further undo information"))
	  (t
	   (setq goto-last-change-undo nil)
	   (error "Buffer not modified")))))

(defun goto-last-change-with-auto-marks (&optional minimal-line-distance)
  "Calls goto-last-change and sets the mark at only the first invocations
in a sequence of invocations."
  (interactive "P")
  (goto-last-change (not (or (eq last-command 'goto-last-change-with-auto-marks)
                             (eq last-command t)))
                    minimal-line-distance))

(setq-default mode-line-format
	      (quote
	       (#(" " 0 1
		  ())
		mode-line-modified
		"    "
		mode-line-buffer-identification
		;; "    "
		(line-number-mode "%l/")
		(:eval (number-to-string (count-lines (point-min) (point-max))))
		"    "
		;; default-directory
		)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(icomplete-compute-delay 0)
 '(package-selected-packages '(magit multiple-cursors expand-region avy)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

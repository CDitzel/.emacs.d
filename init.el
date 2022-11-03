(package-install 'expand-region)
(package-install 'avy)
(package-install 'multiple-cursors)

(add-hook 'after-init-hook (lambda () (load-theme 'manone t)))
(add-hook 'icomplete-minibuffer-setup-hook (lambda () (setq-local completion-styles '(substring flex))))

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
	      gud-gdb-command-name "gdb --i=mi "
	      gdb-many-windows t
	      x-super-keysym 'ctrl
	      )

(global-auto-revert-mode 1)
(add-to-list'default-frame-alist '(fullscreen . maximized))
(show-paren-mode t)
(add-to-list 'auto-mode-alist '("\.cu$" . c++-mode))
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


(defun system-is-lenovo ()
  (interactive)
  (string-equal (system-name) "lenovo"))
(if (system-is-lenovo)
    (set-face-attribute 'default nil :height 200)
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
    (define-key map (kbd "C-a") (lambda () (interactive) (if (= (point) (progn (back-to-indentation) (point))) (beginning-of-line))))
    (define-key map (kbd "C-1") 'tab-bar-select-tab 1)
    (define-key map (kbd "C-2") 'tab-bar-select-tab 2)
    (define-key map (kbd "C-3") 'tab-bar-select-tab 3)
    (define-key map (kbd "C-,") 'comment-line)
    (define-key map (kbd "C-x b") 'ibuffer)
    (define-key map (kbd "C-x k") 'kill-current-buffer)
    (define-key map (kbd "H-i") 'goto-line)
    (define-key map (kbd "M-j") 'smart-join-line)
    (define-key map (kbd "C-x 2") 'tab-bar-new-tab)
    (define-key map (kbd "C-`") 'switch-to-previous-buffer)
    (define-key map (kbd "C-<backspace>") (lambda () (interactive) (kill-line 0)))
    (define-key map (kbd "C-c f") 'bookmark-jump)
    (define-key map (kbd "C-x C-d") 'dired)
    (define-key map (kbd "C-c C-n") 'switch-to-buffer)
    (define-key map (kbd "C-x d") 'find-name-dired)
    (define-key map (kbd "C-c C-r") 'rgrep)
    (define-key map (kbd "C-r") 'recentf)
    (define-key map (kbd "M-n") (quote scroll-up-line))
    (define-key map (kbd "M-p") (quote scroll-down-line))
    (define-key map (kbd "C-.") 'goto-last-change)
    (define-key map (kbd "C-j") 'avy-goto-char-timer)
    (define-key map (kbd "C-c C-SPC") 'mc/edit-lines)
    (define-key map (kbd "C-'") 'er/expand-region)
    (define-key map (kbd "C-;") 'er/contract-region)
    (define-key map (kbd "M-C-s") 'isearch-forward-thing-at-point)
    (define-key map (kbd "C-c r") 'eval-buffer)
    (define-key map (kbd "C-c g") 'magit-status)
    map))

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  :init-value t
  :lighter " my-keys")



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(rainbow-mode multiple-cursors avy expand-region)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;https://arnesonium.com/2023/07/emacs-29-1-on-ubuntu-22-04-lts

(require 'package)
(add-to-list 'package-archives 
             '("MELPA" .
               "http://melpa.org/packages/"))
(package-initialize)

(package-install 'rg)
(package-install 'avy)
;(package-install 'magit)
;(package-install 'git-timemachine)
(package-install 'expand-region)
;(package-install 'yaml-mode)
;(package-install 'json-mode)
(package-install 'whole-line-or-region)
;(package-install 'winum-mode)
;(package-install 'dired-rsync)

(set-face-attribute 'default nil :font "Monospace" :height 100)



(add-hook 'icomplete-minibuffer-setup-hook (lambda () (setq-local completion-styles '(substring basic))))

;(setq winum-keymap
;    (let ((map (make-sparse-keymap)))
;      (define-key map (kbd "M-0") 'winum-select-window-0)
;      (define-key map (kbd "M-1") 'winum-select-window-1)
;      (define-key map (kbd "M-2") 'winum-select-window-2)
;      (define-key map (kbd "M-3") 'winum-select-window-3)
;      (define-key map (kbd "M-4") 'winum-select-window-4)
;      map))
;
;(require 'winum)
;(winum-mode)

;(setq completion-auto-help 'visible)
;(setq completion-auto-select 'second-tab)

(add-hook 'occur-hook (lambda () (switch-to-buffer-other-window "*Occur*")))

;(setenv "PATH" (concat (getenv "PATH") ":/usr/bin/"))
					;(setq exec-path (append exec-path '("/usr/bin")))

; (defun set-exec-path-from-shell-PATH ()
;   "Set up Emacs' `exec-path' and PATH environment variable to match
; that used by the user's shell.
;; This is particularly useful under Mac OS X and macOS, where GUI
; apps are not started from a shell."
;;   (interactive)
;;   (let ((path-from-shell (replace-regexp-in-string
;; 			  "[ \t\n]*$" "" (shell-command-to-string
;; 					  "$SHELL --login -c 'echo $PATH'"
;; 						    ))))
;;     (setenv "PATH" path-from-shell)
;;     (setq exec-path (split-string path-from-shell path-separator))))

;; (set-exec-path-from-shell-PATH)


(add-hook 'dired-mode-hook 'dired-hide-details-mode)


(eval-after-load "dired" '(progn

							(define-key dired-mode-map (kbd "e") 'dired-up-directory) ))
(eval-after-load "dired" '(progn
  (define-key dired-mode-map (kbd "w") 'dired-toggle-read-only) ))

;(setq savehist-additional-variables '(register-alist-kill-ring))

(setq-default cursor-in-non-selected-windows nil
			        inhibit-startup-screen t
			        initial-scratch-message nil
			        isearch-repeat-on-direction-change t
;				isearch-allow-motion t
			        isearch-lazy-count t
			        lazy-highlight-initial-delay 0
;			        save-interprogram-paste-before-kill t
			        lazy-highlight-cleanup nil
			        lazy-highlight-buffer t
;			        mouse-yank-at-point t
;			        echo-keystrokes 0.1
			        save-place-mode t
			        scroll-preserve-screen-position 'always
;			        help-window-select t
			        confirm-kill-emacs 'y-or-n-p
;			        use-dialog-box nil
			        create-lockfiles nil
;			        auto-save-default nil
			        make-backup-files nil
;			        abbrev-mode t
;			        avy-timeout-seconds 0.2
			        tab-bar-mode t
			        tab-bar-show nil
;			        tab-bar-new-tab-choice "*scratch*"
;			        show-paren-delay 0
			        use-short-answers t
			        global-auto-revert-non-file-buffers t
			        auto-revert-verbose nil
			        dired-auto-revert-buffer t
				auto-revert-remote-files t
			        window-combination-resize t
;			        completion-auto-help nil
			        recentf-max-saved-items nil
			        dired-recursive-copies 'always
			        dired-recursive-deletes 'always
			        dired-dwim-target t
			        dired-listing-switches "-lAFGh1v --group-directories-first"
			        dired-kill-when-opening-new-dired-buffer t
;			        ediff-window-setup-function 'ediff-setup-windows-plain
;			        ediff-split-window-function (quote split-window-horizontally)
;			        gud-gdb-command-name "gdb --i=mi "
;			        gdb-many-windows t
;				gdb-debuginfod-enable 0
;			        x-super-keysym 'ctrl
			        icomplete-compute-delay 0
			        max-mini-window-height 10
;			        resize-mini-windows 'grow-only
			        isearch-wrap-pause 'no
;			        magit-display-buffer-function 'magit-display-buffer-same-window-except-diff-v1
;			        tab-width 4
;			        tab-always-indent t
;			        ff-always-try-to-create nil
;;			        eldoc-echo-area-use-multiline-p 1
;;				xref-after-return-hook nil
;;				xref-after-jump-hook '(recenter)
;				ff-other-file-alist 'my-cpp-other-file-alist
				set-mark-command-repeat-pop t ; hit C-u C-spc, leave C pressed and jump by hitting space repeatedly
				split-width-threshold nil
			        )
;
;(setq split-width-threshold nil)

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

(setq c-default-style "linux") 
(setq c-basic-offset 4)

(add-to-list'default-frame-alist '(fullscreen . maximized))
(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cuh\\'" . c++-mode))
;
;
;(setq magit-diff-hide-trailing-cr-characters t)
;
;(global-eldoc-mode -1) 
;(global-auto-revert-mode 1)
;(show-paren-mode t)
(fido-vertical-mode t)
(fringe-mode 0)
(savehist-mode 1) ;; save minibuffer history
(recentf-mode t)
(tool-bar-mode -1)
(menu-bar-mode -1)
;(tooltip-mode -1)
(scroll-bar-mode -1)
(delete-selection-mode t)
(global-visual-line-mode t)
(global-subword-mode 1)
(whole-line-or-region-global-mode t)

;;(add-hook 'eglot-managed-mode-hook (lambda ()
;;(remove-hook 'flymake-diagnostic-functions 'eglot-flymake-backend)))

;(defun aws ()
;  (interactive)
;  (dired "/ssh:aws:git-ndas/ndas"))

(defun coder ()
  (interactive)
  (dired "/ssh:coder.cditzel:git-ndas/ndas"))

;(setq debug-ignored-errors
;      (cons 'remote-file-error debug-ignored-errors))
;
;
;(customize-set-variable
; 'tramp-ssh-controlmaster-options
; (concat
;   "-o ControlPath=/tmp/ssh-ControlPath-%%r@%%h:%%p "
;   "-o ControlMaster=auto -o ControlPersist=yes"))
;
;;
;;;(setq lsp-pyls-server-command "/usr/bin/pylsp")
;;
;;;(customize-set-variable 'tramp-use-ssh-controlmaster-options nil)
;;;(setq tramp-use-ssh-controlmaster-options nil)
;;;(setq enable-remote-dir-locals t)
;;;(setq file-name-inhibit-locks t)
;;;(setq tramp-inline-compress-start-size 1000)
;;;(setq tramp-copy-size-limit 10000)
;;;(setq tramp-default-method "scp")
;;
;;;;; alternatively
;;;(customize-set-variable
;;; 'tramp-ssh-controlmaster-options
;;; (concat
;;;"-o ControlPath=/tmp/ssh-ControlPath-%%r@%%h:%%p "
;;;"-o ControlMaster=auto -o ControlPersist=yes"))
;;;(setq tramp-default-method "ssh")
;;
(remove-hook 'tramp-cleanup-connection-hook #'tramp-recentf-cleanup)
(remove-hook 'tramp-cleanup-all-connections-hook #'tramp-recentf-cleanup-all)
;;
;;;  (setq tramp-inline-compress-start-size 1000)
;;;  (setq tramp-copy-size-limit 10000)
;;;  (setq vc-handled-backends '(Git))
;;;  (setq tramp-auto-save-directory "~/tmp/tramp/")
;;;  (setq tramp-chunksize 2000)
;;;  (setq tramp-default-method "scp")
;;;  (setq tramp-use-ssh-controlmaster-options nil)

;;
;; ;; cache file-name forever
;;;(setq remote-file-name-inhibit-cache nil)
(setq vc-ignore-dir-regexp (format "\\(%s\\)\\|\\(%s\\)" vc-ignore-dir-regexp tramp-file-name-regexp))
;; ;; make sure vc stuff is not making tramp slower
;(setq vc-ignore-dir-regexp (format "%s\\|%s" vc-ignore-dir-regexp tramp-file-name-regexp))
;;;(setq tramp-auto-save-directory "~/tmp/tramp/")
;;;(setq tramp-chunksize 2000)
;;
(require 'whole-line-or-region)
(require 'view)
;;(require 'yaml-mode)
;;(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
;;(require 'json-mode)
;
;
;;;(with-eval-after-load 'eglot
;;;  (add-to-list 'eglot-server-programs
;;;               '((c-mode c++-mode)
;;;                 . ("clangd-15"
;;;                    ;; "-j=16"
;;;                    ;; "--log=error"
;;;                    ;; "--malloc-trim"
;;;                    ;; "--background-index"
;;;                    ;; "--clang-tidy=0"
;;;                    ;; "--cross-file-rename"
;;;                    ;; "--completion-style=detailed"
;;;                    ;; "--pch-storage=memory"
;;;                    ;; "--header-insertion=never"
;;;                    ;; "--header-insertion-decorators=0"
;;;					)))
;;; ;(add-to-list 'eglot-server-programs '(python-mode . ("pylsp")))
;;; )
;;;(set-face-attribute 'default nil :height 90)
;
;(add-to-list 'tramp-remote-path 'tramp-own-remote-path)
;;
;;
;;;(add-hook 'c-mode-hook 'eglot-ensure)
;;;(add-hook 'c++-mode-hook 'eglot-ensure)
;;;(add-hook 'python-mode-hook 'eglot-ensure)
;;
;;; py-related (add-to-list 'tramp-remote-path 'tramp-own-remote-path)
;;
;;;(with-eval-after-load 'eglot
;;;(add-to-list 'eglot-server-programs '(python-mode . ("/usr/bin/pylsp"))))
;;;(add-to-list 'eglot-server-programs '(python-mode . ("jedi-language-server"))))
;;;(add-hook 'python-mode-hook 'eglot-ensure)
;;
;;;(setq org-startup-with-inline-images t)
;;
(rg-define-search rg-everything
  :files "everything"
  :confirm prefix
  :menu ("Search" "e" "Everything"))

(rg-define-search rg-everything-from-project-root
  :files "everything"
  :confirm prefix
  :dir project
  :menu ("Search" "e" "Everything"))
;
(define-abbrev-table 'global-abbrev-table '(
					                        ("pr" "print(f\"{@@= }\")")
					                        ("ex" "exit(1);")
					                        ("os" "std::cout << @@ << \"\\n\";")
					                        ("rr" "- [ ]")
					                        ("fr" "for(uint32_t i = 0; i < @@; ++i){}")
					                        ("vo" "(void) @@;")
					                        ("cd" "// TODO(cditzel MB):")
					                        ("cdp" "# TODO(cditzel MB):")
											("db" "std::cout << \"==========MY_DEBUG========== \" << @@ << \"\\n\"")
											("pdb" "import pdb; pdb.set_trace()")
											("png" "from torchvision.utils import save_image save_image(@@.float() '.png') ")
											))

(defadvice expand-abbrev (after my-expand-abbrev activate)
  (if ad-return-value
      (run-with-idle-timer 0 nil
                           (lambda ()
                             (let ((cursor "@@"))
                               (if (search-backward cursor last-abbrev-location t)
                                   (delete-char (length cursor))))))))

;;(defadvice kill-region (before slick-cut activate compile)
;;  "When called interactively with no active region, kill a single line instead."
;;  (interactive
;;   (if mark-active
;;       (list (region-beginning) (region-end))
;;     (list (line-beginning-position) (line-beginning-position 2)))))
;;
;;(defadvice kill-ring-save (before slick-copy activate compile)
;;  "When called interactively with no active region, copy a single line instead."
;;  (interactive
;;   (if mark-active
;;       (list (region-beginning) (region-end))
;;     (list (line-beginning-position) (line-beginning-position 2)))))
;
;
;(defvar my-cpp-other-file-alist
;  '(
;    ("\\.cpp\\'" (".hpp" ".cuh"))
;    ("\\.hpp\\'" (".cpp"".cu"))
;    ("\\.cuh\\'" (".cu" ".cpp"))
;    ("\\.cu\\'" (".cuh" ".hpp"))
;    ("\\.c\\'" (".h"))
;    ("\\.h\\'" ("interface.cpp"))
;    ("\\.h\\'" (".c"))
;    ))
;
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
;
;;(define-key dired-mode-map (kbd "C-c C-t") 'dired-rsync)
;
;
(defun endless/isearch-symbol-with-prefix (p)
  "Like isearch, unless prefix argument is provided.
With a prefix argument P, isearch for the symbol at point."
  (interactive "P")
  (let ((current-prefix-arg nil))
    (call-interactively
     (if p #'isearch-forward-symbol-at-point #'isearch-forward))))

(global-set-key [remap isearch-forward] #'endless/isearch-symbol-with-prefix)

(define-key input-decode-map (kbd "C-i") (kbd "H-i"))
(global-unset-key (kbd "C-x C-z"))
(global-unset-key (kbd "C-z"))

(defvar my-keys-minor-mode-map
  (let ((map (make-sparse-keymap)))
 (define-key map (kbd "C-o") 'other-window)
; (define-key map (kbd "<C-return>") (lambda () (interactive)(move-end-of-line nil) (newline-and-indent)))
; (define-key map (kbd "<S-return>") (lambda () (interactive)(beginning-of-line nil)(newline-and-indent)(forward-line -1) (indent-according-to-mode)))
 (define-key map (kbd "C-x 3" )  (lambda () (interactive)(split-window-horizontally) (other-window 1)))
 (define-key map (kbd "C-c w" ) (lambda () (interactive) (find-file "~/mega/wiki/wiki.org")))
 (define-key map (kbd "C-c d" ) (lambda () (interactive) (find-file "~/mega/daimler/daimler.org")))
 (define-key map (kbd "C-a" ) (lambda () (interactive) (if (= (point) (progn (back-to-indentation) (point))) (beginning-of-line))))
 (define-key map (kbd "C-1" ) (lambda () (interactive)(tab-bar-select-tab 1)))
 (define-key map (kbd "C-2" ) (lambda () (interactive)(tab-bar-select-tab 2)))
 (define-key map (kbd "C-3" ) (lambda () (interactive)(tab-bar-select-tab 3)))
 (define-key map (kbd "C-4" ) (lambda () (interactive)(tab-bar-select-tab 4)))
 (define-key map (kbd "C-," ) 'comment-line)
; (define-key map (kbd "M-o" ) 'delete-blank-lines)
; (define-key map (kbd "C-x b") 'ibuffer)
 (define-key map (kbd "C-x k") 'kill-current-buffer)
 (define-key map (kbd "C-x C-k") 'kill-current-buffer)
 (define-key map (kbd "H-i") 'goto-line)
; ;(define-key map (kbd "C-M-a") 'beginning-of-defun)
 (define-key map (kbd "M-j") (lambda () (interactive) (let ((current-prefix-arg 1)) (call-interactively #'delete-indentation))))
 (define-key map (kbd "C-`") (lambda () (interactive) (ff-find-other-file nil t)))
; (define-key map (kbd "C-<backspace>") (lambda () (interactive) (let ((opoint  (point))) (back-to-indentation) (delete-region (point) opoint))))
; (define-key map (kbd "C-x C-d") 'dired)
; (define-key map (kbd "C-x d") 'find-name-dired)
 (define-key map (kbd "C-c C-r") 'rg-everything)
 (define-key map (kbd "C-c r") 'rg-everything-from-project-root)
 (define-key map (kbd "M-n") 'scroll-up-line)
 (define-key map (kbd "M-p") 'scroll-down-line)
 (define-key map (kbd "C-j") 'avy-goto-char-timer)
 (define-key map (kbd "C-t") 'duplicate-line)
 (define-key map (kbd "C-'") 'er/expand-region)
 (define-key map (kbd "C-;") 'er/contract-region)
; (define-key map (kbd "C-c g") 'magit-status)
 (define-key map (kbd "C-v") 'View-scroll-half-page-forward)
 (define-key map (kbd "M-v") 'View-scroll-half-page-backward)
; (define-key map (kbd "C-c t") 'git-timemachine)
 map
 ))

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  :init-value t
  :lighter " my-keys")

(global-set-key [?\C-r] 
                #'(lambda (_)
                    (interactive "p")
                    (cond
                     ((eq _ 1)
                      (isearch-backward))
                     ((eq _ 4)
                      (call-interactively 'recentf-open)))))

(global-set-key [?\C-f] 
                #'(lambda (_)
                    (interactive "p")
					(cond
                     ((eq _ 1)
                      (forward-char))
                     ((eq _ 4)
                      (call-interactively 'bookmark-jump)))))

;;; C-x C-x exhange mark, if you forget to mark text before
;;; C-d to confirm file renaming with partial existing subword
;;; C-u C-spc pop local-mark-ring (buffer-wise)
;;; C-x C-spc pop global-mark-ring 
;;; C-x C-j dired to current dir
;;; M-k Kill to end of sentence (kill-sentence).
;;; C-x DEL backward kill sentence
;;; C-y M-y paste and cycle
;;; C-x C-o delete all blank lines below
;;; C-x TAB after highlighting region to indent
;;; C-M-f,b,n,p etc. moves in larger chunks
;;; C-M-k und C-M-backspace to delete fwd/bwd up to brackets
;;; C-M-v scroll-other-window and C-M-S-v scroll-other-window-down
;;; (M-{ / M-} backard / forward paragraph 
;;; C-M-a and C-M-e to move back and forward a function at a time.
;;; C-u C-s mark word under points -> C-s to find further occurences, also in other windows
;;; Use M-h to mark the current paragraph
;;; Use C-M-h to mark the current function
;;; Pressing C-s or C-r for a second time before entering your search string will reuse the previous search string.
;;; C-l recentres the window while keeping the point on the same line
;;; M-r moves the point without recentring the window.
;;; C-s C-w [C-w ... ] to search for a word/expression under a cursor.
;;; then M-s o calls occur (buffer local) (C-u to call with line ctx) and e goes into edit mode
;;; C-M-@ mark words or C-M-SPC
;;; M-; insert comment
;;; C-c C-c comment
;;; M-s h r	Highlight regexp
;;; M-s h u	Undo the highlight
;;
;;;(with-eval-after-load "eglot"
;;;(add-to-list 'eglot-stay-out-of 'eldoc))
;;;(add-hook 'eglot-managed-mode-hook (lambda () (eglot-inlay-hints-mode -1)))
;;
(add-hook 'after-init-hook (lambda () (load-theme 'late-night t)))
;;
;;
;;;(getenv "SSH_AGENT_PID")  
;;;(getenv "SSH_AUTH_SOCK")
;;;(setq tramp-shell-prompt-pattern "^[^$>\n]*[#$%>] *\\(\[[0-9;]*[a-zA-Z] *\\)*")
;;;(connection-local-set-profile-variables
;;; 'remote-without-auth-sources '((auth-sources . nil)))
;;;
;;;(connection-local-set-profiles
;;; '(:application tramp) 'remote-without-auth-sources)
;;					;
;;
;;(custom-set-variables
;; ;; custom-set-variables was added by Custom.
;; ;; If you edit it by hand, you could mess it up, so be careful.
;; ;; Your init file should contain only one such instance.
;; ;; If there is more than one, they won't work right.
;; '(custom-safe-themes
;;   '("a86bf878c4752094fe7294486f60872d4f73a1f7ed2f37e1bc4e902fc2b790a1"
;;	 "d581a53bd93d5dab76503e7e166589938a27ec5a7971fd223be56b0f68b2e145"
;;	 "f9fcd87778953039b8e4de4954ce7dff426c1ee493a09d665c2f641ac7a626c1"
;;	 default))
;; '(icomplete-in-buffer t)
;; '(org-safe-remote-resources
;;   '("\\`https://fniessen\\.github\\.io/org-html-themes/org/theme-readtheorg\\.setup\\'"))
;; '(package-selected-packages
;;   '(avy bazel dired-rsync-transient eglot expand-region json-mode magit
;;		 markdownfmt rainbow-mode rg whole-line-or-region
;;		 window-numbering winum yaml-mode))
;; '(tramp-verbose 1)
;; '(whole-line-or-region-global-mode t))
;;(custom-set-faces
;; ;; custom-set-faces was added by Custom.
;; ;; If you edit it by hand, you could mess it up, so be careful.
;; ;; Your init file should contain only one such instance.
;; ;; If there is more than one, they won't work right.
;; '(highlight ((t (:foreground "#00a1c6" :weight heavy)))))
;;
;;
;(custom-set-variables
; ;; custom-set-variables was added by Custom.
; ;; If you edit it by hand, you could mess it up, so be careful.
; ;; Your init file should contain only one such instance.
; ;; If there is more than one, they won't work right.
; '(package-selected-packages
;   '(yaml-mode whole-line-or-region rg magit json-mode expand-region avy)))
;(custom-set-faces
; ;; custom-set-faces was added by Custom.
; ;; If you edit it by hand, you could mess it up, so be careful.
; ;; Your init file should contain only one such instance.
; ;; If there is more than one, they won't work right.
; )
;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-safe-remote-resources
   '("\\`https://fniessen\\.github\\.io/org-html-themes/org/theme-readtheorg\\.setup\\'"))
 '(package-selected-packages
   '(rainbow-mode yaml-mode whole-line-or-region rg magit json-mode expand-region avy)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

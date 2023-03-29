(require 'package)
(add-to-list 'package-archives 
             '("MELPA" .
               "http://melpa.org/packages/"))
(package-initialize)

(package-install 'expand-region)
(package-install 'avy)
(package-install 'multiple-cursors)
(package-install 'magit)
(package-install 'rg)
(package-install 'git-timemachine)
(package-install 'yaml)

(add-hook 'after-init-hook (lambda () (load-theme 'late-night t)))
(add-hook 'icomplete-minibuffer-setup-hook (lambda () (setq-local completion-styles '(substring basic))))


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
			        eldoc-echo-area-use-multiline-p 1
				xref-after-return-hook nil
				xref-after-jump-hook '(recenter)
				ff-other-file-alist 'my-cpp-other-file-alist
			        )




;(with-eval-after-load 'magit-mode
;  (add-hook 'after-save-hook 'magit-after-save-refresh-status t))


(add-hook 'gud-mode-hook
          (lambda ()
             (global-set-key (kbd "C-c c") 'gud-cont)
             (global-set-key (kbd "C-c p") 'gud-print)
             (global-set-key (kbd "C-c r") 'gud-run)
             (global-set-key (kbd "C-c j") 'gud-jump)
             (global-set-key (kbd "C-c u") 'gud-until)
             (global-set-key (kbd "C-c w") 'gud-watch)
             (global-set-key (kbd "C-c b") 'gud-break)
             (global-set-key (kbd "C-c n") 'gud-next)
             (global-set-key (kbd "C-c f") 'gud-finish)
             (global-set-key (kbd "C-c <") 'gud-up)
             (global-set-key (kbd "C-c s") 'gud-step)))

;; Ensure that all source files are opened in the same window when gdb                                                                                                  
;; is running.                                                                                                                                                          
;(add-to-list 'display-buffer-alist
;         (cons 'gdb-source-code-buffer-p
;           (cons 'display-buffer-use-some-window nil)))
;
;(defun gdb-source-code-buffer-p (bufName action)
;  "Return whether BUFNAME is a source code buffer and gdb is running."
;  (let ((buf (get-buffer bufName)))
;    (and buf
;         (eq gud-minor-mode 'gdbmi)
;         (with-current-buffer buf
;           (derived-mode-p buf 'c++-mode 'c-mode)))))
;
;



(setq xwl-gdb-current-line-overlay nil)
(defun xwl-gdb-highlight-current-line ()
  (when gud-overlay-arrow-position
    (with-current-buffer (marker-buffer gud-overlay-arrow-position)
      (when xwl-gdb-current-line-overlay
        (delete-overlay xwl-gdb-current-line-overlay))
      (setq xwl-gdb-current-line-overlay (make-overlay gud-overlay-arrow-position (line-end-position)))
      (overlay-put xwl-gdb-current-line-overlay 'face 'xwl-gdb-current-line-face))))

(defun xwl-gdb-unhighlight-current-line ()
 (delete-overlay xwl-gdb-current-line-overlay))

(defface xwl-gdb-breakpoint-line-face
  '((((class color))
     (:background "brown4")))
  "DodgerBlue4")

(defun xwl-gdb-highlight-breakpoint-line (enabled bptno &optional line)
  (let* ((bp-line (or line (line-number-at-pos)))
         (points (gdb-line-posns bp-line))
         (bp-overlay (make-overlay (car points) (cdr points))))
    (overlay-put bp-overlay 'face 'xwl-gdb-breakpoint-line-face)))

(defun xwl-gdb-unhighlight-breakpoint-lines (start end &optional remove-margin)
  (dolist (overlay (overlays-in start end))
    (when (eq (overlay-get overlay 'face) 'xwl-gdb-breakpoint-line-face)
      (delete-overlay overlay))))

(with-eval-after-load 'gdb-mi
  (advice-add 'gdb-frame-handler :after 'xwl-gdb-highlight-current-line)
  (advice-add 'gdb-reset :after 'xwl-gdb-unhighlight-current-line)
  (advice-add 'gdb-put-breakpoint-icon :after 'xwl-gdb-highlight-breakpoint-line)
  (advice-add 'gdb-remove-breakpoint-icons :after 'xwl-gdb-unhighlight-breakpoint-lines))



(unless (boundp 'done-set-tab-layout)
  (split-window-right)
  (tab-bar-new-tab)
  (split-window-right)
  (tab-bar-new-tab)
  (split-window-right)
  (tab-bar-new-tab)
  (split-window-right)
  (tab-bar-select-tab 1)
  (dired "/home/ubuntu/git-ndas/ndas")
  (setq done-set-tab-layout t))

(setq c-default-style "linux") 
(setq c-basic-offset 4)

(add-to-list'default-frame-alist '(fullscreen . maximized))
(add-to-list 'auto-mode-alist '("\\.cu\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.cuh\\'" . c++-mode))

(global-auto-revert-mode 1)
(show-paren-mode t)
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


  (add-hook 'eglot-managed-mode-hook (lambda ()
                   (remove-hook 'flymake-diagnostic-functions 'eglot-flymake-backend)))



(require 'view)


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
					                        ("vo" "(void) @@;")
					                        ("cd" "// TODO(cditzel MB):")
					                        ("cla_csft" "--processors=LidarToRadarProcessor
--targetJson=lidar:gt:top:p128:v4p5;$CSFT_INPUT_PATH/dataset-structured.sqlite --rig=/home/ubuntu/git-ndas/ndas/nv/datasets/2dbf6282-b531-11eb-9c5e-00044baf74dc/rig_dynamic_calibration.json --disableSensorsByType=camera,time --disableSensorsByName=uss:valeo,lidar:parking:gt:front:p128,lidar:parking:gt:left:p128,lidar:parking:gt:rear:p128,lidar:parking:gt:right:p128,lidar:front:center:p128:v4p5,lidar:front:center:p128,radar:cross:left,radar:cross:right,radar:rear:left,radar:rear:right,radar:side:left,radar:side:right,time:nvpps:main:a,time:nvpps:main:b,can:1 --offscreen=1")
											("cla_exp" "--outputFolder=nv --rig=/home/ubuntu/git-ndas/ndas/nv/datasets/2dbf6282-b531-11eb-9c5e-00044baf74dc/rig_dynamic_calibration.json")
											("csft" "bazel-bin/tools/experimental/lidarperception/crossSensorFusionTool/tools_experimental_cross_sensor_fusion") 
											("expo" "bazel-bin/tools/experimental/lidarperception/lidarExporterTool/lidar_exporter_tool")
											)
  )


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
     (list (line-beginning-position) (line-beginning-position 2)))))


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
 (define-key map (kbd "<C-return>") (lambda () (interactive)(move-end-of-line nil) (newline-and-indent)))
 (define-key map (kbd "<S-return>") (lambda () (interactive)(beginning-of-line nil)(newline-and-indent)(forward-line -1) (indent-according-to-mode)))
 (define-key map (kbd "C-x 3" )  (lambda () (interactive)(split-window-horizontally) (other-window 1)))
 (define-key map (kbd "C-c w" ) (lambda () (interactive) (find-file "~/org/wiki/wiki.org")))
 (define-key map (kbd "C-c d" ) (lambda () (interactive) (find-file "~/org/wiki/daimler.org")))
 (define-key map (kbd "C-a" ) (lambda () (interactive) (if (= (point) (progn (back-to-indentation) (point))) (beginning-of-line))))
 (define-key map (kbd "C-1" ) (lambda () (interactive)(tab-bar-select-tab 1)))
 (define-key map (kbd "C-2" ) (lambda () (interactive)(tab-bar-select-tab 2)))
 (define-key map (kbd "C-3" ) (lambda () (interactive)(tab-bar-select-tab 3)))
 (define-key map (kbd "C-4" ) (lambda () (interactive)(tab-bar-select-tab 4)))
 (define-key map (kbd "C-," ) 'comment-line)
 (define-key map (kbd "C-x b") 'ibuffer)
 (define-key map (kbd "C-x k") 'kill-current-buffer)
 (define-key map (kbd "H-i") 'goto-line)
 (define-key map (kbd "M-j") (lambda () (interactive) (let ((current-prefix-arg 1)) (call-interactively #'delete-indentation))))
 (define-key map (kbd "C-`") (lambda () (interactive) (ff-find-other-file nil t)))
 (define-key map (kbd "C-<backspace>") (lambda () (interactive) (let ((opoint  (point))) (back-to-indentation) (delete-region (point) opoint))))
 (define-key map (kbd "C-c f") 'bookmark-jump)
 (define-key map (kbd "C-x C-d") 'dired)
 (define-key map (kbd "C-x d") 'find-name-dired)
 (define-key map (kbd "C-c C-r") 'rg-everything)
 (define-key map (kbd "M-n") 'scroll-up-line)
 (define-key map (kbd "M-p") 'scroll-down-line)
 (define-key map (kbd "C-.") 'goto-last-change)
 (define-key map (kbd "C-j") 'avy-goto-char-timer)
 (define-key map (kbd "C-c e") 'mc/edit-lines)
 (define-key map (kbd "C-'") 'er/expand-region)
 (define-key map (kbd "C-;") 'er/contract-region)
 (define-key map (kbd "C-t") 'duplicate-line)
 (define-key map (kbd "C-c g") 'magit-status)
 (define-key map (kbd "C-v") 'View-scroll-half-page-forward)
 (define-key map (kbd "M-v") 'View-scroll-half-page-backward)
 (define-key map (kbd "C-c g") 'magit-status)
 (define-key map (kbd "C-c t") 'git-timemachine)
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

;; C-x C-j dired to current dir
;; M-k Kill to end of sentence (kill-sentence).
;; C-x DEL backward kill sentence
;; C-y M-y paste and cycle
;; C-x C-o delete all blank lines below
;; C-x TAB after highlighting region to indent
;; C-M-f,b,n,p etc. moves in larger chunks
;; C-M-k und C-M-backspace to delete fwd/bwd up to brackets
;; C-u C-SPC back to saved mark
;; C-M-v scroll-other-window and C-M-S-v scroll-other-window-down
;; (M-{ / M-} backard / forward paragraph 
;; C-M-a and C-M-e to move back and forward a function at a time.
;; C-u C-s mark word under points -> C-s to find further occurences, also in other windows
;; Use M-h to mark the current paragraph
;; Use C-M-h to mark the current function
;; Pressing C-s or C-r for a second time before entering your search string will reuse the previous search string.
;; C-l recentres the window while keeping the point on the same line
;; M-r moves the point without recentring the window.
;; C-s C-w [C-w ... ] to search for a word/expression under a cursor.
;; then M-s o calls occur (buffer local) (C-u to call with line ctx) and e goes into edit mode
;; C-M-@ mark words or C-M-SPC
;; M-; insert comment
;; C-c C-c comment

(with-eval-after-load "eglot"
  (add-to-list 'eglot-stay-out-of 'eldoc))
(add-hook 'eglot-managed-mode-hook (lambda () (eglot-inlay-hints-mode -1)))
(setq flymake-mode 0)

;
;(custom-set-variables
; ;; custom-set-variables was added by Custom.
; ;; If you edit it by hand, you could mess it up, so be careful.
; ;; Your init file should contain only one such instance.
; ;; If there is more than one, they won't work right.
; '(org-safe-remote-resources
;   '("\\`https://fniessen\\.github\\.io/org-html-themes/org/theme-readtheorg\\.setup\\'"))
; '(package-selected-packages
;   '(tree-sitter tree-sitter-langs yaml rainbow-mode markdown markdown-mode git-timemachine expand-region avy multiple-cursors bind-key magit rg)))
;(custom-set-faces
; ;; custom-set-faces was added by Custom.
; ;; If you edit it by hand, you could mess it up, so be careful.
; ;; Your init file should contain only one such instance.
; ;; If there is more than one, they won't work right.
; '(eldoc-highlight-function-argument ((t nil))))
;
;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-safe-remote-resources
   '("\\`https://fniessen\\.github\\.io/org-html-themes/org/theme-readtheorg\\.setup\\'"))
 '(package-selected-packages
   '(rainbow-mode yaml git-timemachine rg magit multiple-cursors avy expand-region)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

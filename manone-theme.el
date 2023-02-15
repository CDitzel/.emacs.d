(deftheme manone)


(custom-theme-set-faces
 'manone
 '(default ((t (:background "black" :foreground "green"))))
 
 ;; Font lock faces
'(font-lock-builtin-face       ((t (:foreground "LightSteelBlue"))))
'(font-lock-constant-face      ((t (:foreground "green" :bold nil))))
'(font-lock-preprocessor-face  ((t (:foreground "green" :italic t))))
'(font-lock-keyword-face       ((t (:foreground "green" :bold t))))
'(font-lock-type-face          ((t (:foreground "green"))))
'(font-lock-variable-name-face ((t (:foreground "green")))) 
'(font-lock-function-name-face ((t (:foreground "green" :bold nil :height 1.0))))
'(isearch-lazy-highlight-face ((t (:background "blue" :foreground "black" :weight bold))))
'(mode-line ((t (:bold t :background "black" :foreground "green" :weight semi-bold :box (:line-width -1 :color "#606060")))))
'(mode-line-buffer-id ((t (:background "grey50" :foreground "Black" :bold t :weight bold :height 1.0))))
'(mode-line-emphasis ((t (:bold t :weight bold ))))
'(mode-line-highlight ((t (:box (:line-width 2 :color "grey35" :style released-button :height 0.9)))))
'(mode-line-inactive ((t (:bold t :weight semi-bold  :foreground "green" :box (:line-width -1 :color "#606060") :background "#101010"))))
'(minibuffer-prompt ((t (:foreground "green"))))
'(show-paren-match ((t (:background "red3"))))
'(org-level-1 ((t (:foreground "green" :weight bold))))
'(org-level-2 ((t (:foreground "green"))))
'(org-level-3 ((t (:foreground "green"))))
'(link ((t (:foreground "yellow" :underline t))))
'(org-link ((t (:foreground "yellow" :underline t))))
'(lazy-highlight ((t (:background "blue" :foreground "#888888" :bold t))))
'(completions-common-part ((t (:width normal :weight normal :slant normal :foreground "green"

									  
'(font-lock-string-face ((t (:foreground "red"))))
'(match ((t (:background "red"))))

 '(org-agenda-date ((t (:foreground "LightSkyBlue"))))
 '(org-agenda-date-weekend ((t (:bold t :foreground "LightSkyBlue" :weight bold))))
 '(org-agenda-restriction-lock ((t (:background "skyblue4"))))
 '(org-agenda-structure ((t (:foreground "LightSkyBlue"))))
 '(org-archived ((t (:foreground "grey70"))))
 '(org-code ((t (:foreground "grey70"))))
 '(org-column ((t (:background "grey30" :slant normal :weight normal :height 81))))
 '(org-column-title ((t (:bold t :background "grey30" :underline t :weight bold))))
 '(org-date ((t (:foreground "Cyan" :underline t))))
 '(org-done ((t (:bold t :foreground "PaleGreen" :weight bold))))
 '(org-drawer ((t (:foreground "LightSkyBlue"))))
 '(org-ellipsis ((t (:foreground "LightGoldenrod" :underline t))))
 '(org-formula ((t (:foreground "chocolate1"))))
 '(org-headline-done ((t (:foreground "LightSalmon"))))
 '(org-hide ((t (:foreground "black"))))
 '(org-latex-and-export-specials ((t (:foreground "burlywood"))))
 '(compilation-column-number ((t (:foreground "PaleGreen"))))
 '(compilation-error ((t (:bold t :weight bold :foreground "Brown1"))))
 '(compilation-info ((t (:bold t :foreground "chocolate1" :weight bold))))
 '(compilation-line-number ((t (:foreground "LightGoldenrod"))))
 '(compilation-message-face  ((t (:underline t))))
 '(compilation-warning ((t (:bold t :foreground "Orange" :weight bold))))
 '(compilation-warning-face ((t (:bold t :foreground "Orange" :weight bold))))
 
				:background "black" :height 1.0))))
 '(completions-first-difference ((t (:bold nil :weight bold))))
 '(cursor ((t (:background "#00ff33"))))
 '(custom-button-face ((t (:background "lightgrey" :foreground "black"
                                       :box '(:line-width 2 :style released-button)))))
 '(custom-button-pressed-face ((t (:background "lightgrey"
                                               :foreground "black"
                                               :box '(:line-width 2 :style pressed-button)))))
 '(custom-changed-face ((t (:foreground "wheat" :background "blue"))))
 '(custom-comment-face ((t (:background "dim gray"))))
 '(custom-comment-tag-face ((t (:foreground "gray80"))))
 '(custom-face-tag-face ((t (:bold t :weight bold :height 1.1))))
 '(custom-group-tag-face ((t (:bold t :foreground "light blue" :weight bold :height 1.1))))
 '(custom-group-tag-face-1 ((t (:bold t :foreground "pink" :weight bold :height 1.1))))
 '(custom-invalid-face ((t (:background "red" :foreground "yellow"))))
 '(custom-modified-face ((t (:background "blue" :foreground "white"))))
 '(custom-rogue-face ((t (:background "black" :foreground "pink"))))
 '(custom-saved-face ((t (:underline t))))
 '(custom-set-face ((t (:background "white" :foreground "blue"))))
 '(custom-state-face ((t (:foreground "lime green"))))
 '(custom-variable-button-face ((t (:bold t :underline t :weight bold
                                          :background "lightgrey"
                                          :foreground "black"
                                          :box '(:line-width 2 :style released-button)))))
 '(custom-variable-tag-face ((t (:bold t :foreground "light blue"
                                         :weight bold :height 1.2))))

 '(ediff-current-diff-face-A ((t (:foreground "firebrick" :background "pale green"))))
 '(ediff-current-diff-face-Ancestor ((t (:foreground "Black" :background "VioletRed"))))
 '(ediff-current-diff-face-B ((t (:foreground "DarkOrchid" :background "Yellow"))))
 '(ediff-current-diff-face-C ((t (:foreground "Navy" :background "Pink"))))
 '(ediff-even-diff-face-A ((t (:foreground "Black" :background "light grey"))))
 '(ediff-even-diff-face-Ancestor ((t (:foreground "White" :background "Grey"))))
 '(ediff-even-diff-face-B ((t (:foreground "White" :background "Grey"))))
 '(ediff-even-diff-face-C ((t (:foreground "Black" :background "light grey"))))
 '(ediff-fine-diff-face-A ((t (:foreground "Navy" :background "sky blue"))))
 '(ediff-fine-diff-face-Ancestor ((t (:foreground "Black" :background "Green"))))
 '(ediff-fine-diff-face-B ((t (:foreground "Black" :background "cyan"))))
 '(ediff-fine-diff-face-C ((t (:foreground "Black" :background "Turquoise"))))
 '(ediff-odd-diff-face-A ((t (:foreground "White" :background "Grey"))))
 '(ediff-odd-diff-face-Ancestor ((t (:foreground "Black" :background "light grey"))))
 '(ediff-odd-diff-face-B ((t (:foreground "Black" :background "light grey"))))
 '(ediff-odd-diff-face-C ((t (:foreground "White" :background "Grey"))))
 '(excerpt ((t (:italic t))))
 '(file-name-shadow ((t (:foreground "grey70"))))
 '(fixed ((t (:bold t))))
 '(flyspell-duplicate-face ((t (:foreground "IndianRed" :bold t :underline t))))
 '(flyspell-incorrect-face ((t (:foreground "Pink" :bold t :underline t))))
 '(fringe ((t (:background "grey30" :foreground "Wheat"))))
 '(header-line ((t (:box (:line-width -1 :color "grey20" :style released-button) :background "grey20" :foreground "grey90"  :height 0.9))))
 '(help-argument-name ((t (:italic t :slant italic))))
 '(highlight ((t (:background "gray10" :foreground "Old Lace"))))
 '(hl-line  ((t (:background "grey10" :foreground "Old Lace"))))
 '(gnus-mouse-face ((t (:background "darkseagreen2" :foreground "blue"))))
 '(erc-button-mouse-face ((t (:background "darkseagreen2" :foreground "blue"))))
 '(align-highlight-change-face  ((t (:background "darkseagreen2" :foreground "blue"))))
 '(goto-address-url-mouse-face ((t (:background "darkseagreen2" :foreground "blue"))))
 '(goto-address-url-mouse-face ((t (:background "darkseagreen2" :foreground "blue"))))
 '(ispell-highlight-face ((t (:background "darkseagreen2" :foreground "blue"))))
 '(ispell-highlight-face ((t (:background "darkseagreen2" :foreground "blue"))))
 '(widget-mouse-face  ((t (:background "darkseagreen2" :foreground "blue"))))
 '(highlight-beyond-fill-column-face ((t (:underline t))))
 '(highlight-changes ((t (:foreground nil :background "#382f2f"))))
 '(highlight-changes-delete ((t (:foreground nil :background "#916868"))))
 '(isearch ((t (:bold t :background "yellow" :foreground "black" :weight bold))))
 '(isearch-secondary ((t (:foreground "red3"))))
 '(italic ((t (:italic t))))
 '(link-visited ((t (:underline t :foreground "violet"))))
 '(makefile-space ((t (:background "hotpink"))))
 '(man-bold ((t (:bold t))))
 '(man-heading ((t (:bold t))))
 '(man-italic ((t (:foreground "yellow"))))
 '(man-xref ((t (:underline t))))
 '(mouse ((t (:background "OrangeRed"))))
 '(next-error ((t (:background "blue3"))))
 '(nobreak-space ((t (:foreground "cyan" :underline t))))
 '(paren-blink-off ((t (:foreground "black"))))
 '(paren-mismatch-face ((t (:bold t :background "white" :foreground "red"))))
 '(paren-no-match-face ((t (:bold t :background "white" :foreground "red"))))
 '(query-replace ((t (:foreground "brown4" :background "palevioletred2"))))
 '(region ((t (:background "blue"))))
 '(scroll-bar ((t (:background "grey75" :foreground "WhiteSmoke"))))
 '(secondary-selection ((t (:background "SkyBlue4"))))
 '(shadow ((t (:foreground "grey70"))))
 '(tool-bar ((t (:background "grey75" :foreground "black" :box (:line-width 1 :style released-button)))))
 '(tooltip ((t (:background "lightyellow" :foreground "black"))))
 '(trailing-whitespace ((t (:background "red1"))))
 '(underline ((t (:underline t))))
 '(vcursor ((t (:foreground "blue" :background "cyan" :underline t))))
 '(vertical-border ((t (:background "dim gray"))))
 )
(provide-theme 'manone)


;; recenter and highlight current line
(defvar gud-overlay
  (let* ((ov (make-overlay (point-min) (point-min))))
    (overlay-put ov 'face '(:background "white")) ;; colors for Leuven theme
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

;; https://ftp.gnu.org/old-gnu/Manuals/emacs-20.7/html_chapter/emacs_13.html
;; M-k Kill to end of sentence (kill-sentence).
;; Kill word backwards (backward-kill-word).
;; C-x DEL
;; Kill back to beginning of sentence (backward-kill-sentence).
;; C-y M-y paste and cycle
;; C-x C-o delete all blank lines below
;; Dont kill but switch buffer in the future
;; C-x TAB after highlighting region to indent
;; C-M-f,b,a,e,n,p etc. moves in larger chunks
;; C-u C-SPC back to saved mark
;; C-M-v scroll-other-window and C-M-S-v scroll-other-window-down
;; backard / forward paragraph (M-{ / M-}
;; C-M-a and C-M-e to move back and forward a function at a time.
;; C-u C-s mark word under points -> C-s to find further occurences, also in other windows. After some time C-s retriggers last search
;; Use M-h to mark (highlight) the current paragraph.
;; Pressing C-s or C-r for a second time before entering your search string will reuse the previous search string.
;; M-C-k und M-C-backspace to delete fwd/bwd up to brackets
;; C-l recentres the window while keeping the point on the same line
;; M-r moves the point without recentring the window.
;; C-s C-w [C-w ... ] to search for a word/expression under a cursor.
;; undo in marked region only
;; then M-s o calls occur (buffer local) (C-u to call with line ctx) and e goes into edit mode
;; C-M-k and M-k
;; M-e to edit failed isearch parts
;; M-s h r	Highlight regexp
;; M-s h u	Undo the highlight
;; C-x n n narrow region
;; C-x n w widen region
;; C-x C-j dired-jump
;; M-x (M-p) for cached commands
;; M-n		isearch-ring-advance
;; M-p		isearch-ring-retreat
;; C-M-... commands
;; C-M-h mark function
;; C-M-@ mark words or C-M-SPC
;; find-file then M-n for find-file-at-point, i.e. insert current file
;; M-; insert comment
;; C-c C-c comment




;; magit-display-buffer-function 'magit-display-buffer-same-window-except-diff-v1
;; magit-ediff-dwim-show-on-hunks t



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

;; (define-key map (kbd "M-t") 'duplicate-and-comment-current-line-or-region)




(setq-default mode-line-format
	      (quote
	       (#(" " 0 1
		  ())
		mode-line-modified
		"    "
		mode-line-buffer-identification
		"    "
		(line-number-mode "%l/")
		(:eval (number-to-string (count-lines (point-min) (point-max))))
		"                                                                                                  "
		(:eval (format-time-string "%H:%M"))
		)))


(setq-default mode-line-buffer-identification
              '(:eval
                (list (propertize "%b"
                       'face (if ;; NOPE (eq (selected-window) (get-buffer-window (current-buffer)))
                                 (eq (current-buffer) (get-buffer "some-buffer"))
                                 'mode-line-buffer-id
										;'some-other-face)
							   )
                       'help-echo "Buffer name mouse-1: Previous buffer\nmouse-3: Next buffer"
                       'mouse-face 'mode-line-highlight
                       'local-map mode-line-buffer-identification-keymap))))





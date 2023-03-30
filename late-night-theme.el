;;; late-night-theme.el --- late-night theme

;; Copyright (C) 2002 by Alex Schroeder
;; Copyright (C) 2013 by Syohei YOSHIDA

;; Author: Syohei YOSHIDA &lt;syohex@gmail.com&gt;
;; URL: https://github.com/emacs-jp/replace-colorthemes
;; Version: 0.01

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see &lt;http://www.gnu.org/licenses/&gt;.

;;; Commentary:
;;
;; Port of late-night theme from `color-themes'

;;; Code:

(deftheme late-night
  "late-night theme")

(custom-theme-set-faces
 'late-night

 '(default ((t (:background "black" :foreground "#666"))))
 ;'(cursor ((t (:background "#00a1c6"))))
 '(cursor ((t (:background "#00ff33"))))
 '(cursor ((t (:foregound "#888"))))
 ;'(border ((t (:foregound "#000"))))

'(font-lock-keyword-face       ((t (:foreground "LimeGreen" :bold t))))
 
 '(font-lock-builtin-face ((t (:bold t :foreground "#777"))))
 '(font-lock-comment-face       ((t (:italic t :slant oblique :foreground "#333"))))
 '(font-lock-constant-face ((t (:foreground "#777"))))
 '(font-lock-doc-string-face ((t (:foreground "#777"))))
 '(font-lock-doc-face ((t (:foreground "#777"))))
 '(font-lock-function-name-face ((t (:bold t :foreground "#777"))))
 '(font-lock-keyword-face ((t (:foreground "#777"))))
 '(font-lock-preprocessor-face ((t (:foreground "#777"))))
 '(font-lock-reference-face ((t (:foreground "#777"))))
 '(font-lock-string-face ((t (:foreground "#777"))))
 '(font-lock-type-face ((t (:bold t))))
 '(font-lock-variable-name-face ((t (:bold t :foreground "#888"))))
 '(font-lock-warning-face ((t (:bold t :foreground "#999"))))

 '(isearch ((t (:bold t :background "yellow" :foreground "black" :weight bold))))
 '(isearch-fail ((t (:background "red"))))
 '(isearch-lazy-highlight-face ((t (:background "blue" :foreground "black" :weight bold))))
 
 '(bold ((t (:bold t))))
 '(button ((t (:bold t))))
 '(custom-button-face ((t (:bold t :foreground "#999"))))
 '(fringe ((t (:background "#111" :foreground "#444"))))
 '(header-line ((t (:background "#333" :foreground "#000"))))
 '(highlight ((t (:background "gray10" :foreground "Old Lace"))))
 '(holiday-face ((t (:background "#000" :foreground "#777"))))
 
 '(italic ((t (:bold t))))
 '(menu ((t (:background "#111" :foreground "#444"))))
 ;;'(minibuffer-prompt ((t (:foreground "cyan" :weight bold))))
 '(minibuffer-prompt ((t (:foreground "#00a1c6" :weight bold))))
 '(completions-common-part ((t (:width normal :weight normal :slant normal :foreground "#00a1c6"))))
 '(modeline ((t (:background "#111" :foreground "#444"))))
 '(mode-line-inactive ((t (:background "grey30" :foreground "Black"
                                       :box '(:line-width 2 :color "grey30")
                                       :weight bold :height 1.0))))
 '(modeline-buffer-id ((t (:background "#000" :foreground "#555"))))
 '(modeline-mousable ((t (:background "#000" :foreground "#555"))))
 '(modeline-mousable-minor-mode ((t (:background "#000" :foreground "#555"))))
 '(region ((t (:background "dark cyan" :foreground "cyan"))))
 '(secondary-selection ((t (:background "Aquamarine" :foreground "SlateBlue"))))
 '(show-paren-mismatch-face ((t (:foreground "white" :background "red"))))
 '(tool-bar ((t (:background "#111" :foreground "#777"))))
 '(tooltip ((t (:background "#333" :foreground "#777"))))
 '(underline ((t (:bold t))))
 '(variable-pitch ((t (nil))))
 '(widget-button-face ((t (:bold t :foreground "#888"))))
 '(widget-field-face ((t (:bold t :foreground "#999"))))
 '(paren-blink-off ((t (:foreground "black"))))
 '(paren-mismatch-face ((t (:bold t :background "white" :foreground "red"))))
 '(paren-no-match-face ((t (:bold t :background "white" :foreground "red"))))
 '(show-paren-match ((t (:background "red"))))
 '(show-paren-match-face ((t (:background "red"))))

  '(diff-function-face ((t (:foreground "blue"))))
;'(ediff-current-diff-face-A ((t (:foreground "pink" :background "pale green"))))
 ;'(ediff-current-diff-face-Ancestor ((t (:foreground "Black" :background "VioletRed"))))
 ;'(ediff-current-diff-face-C ((t (:foreground "Navy" :background "Pink"))))
 ;'(ediff-even-diff-face-A ((t (:foreground "Black" :background "light grey"))))
 ;'(ediff-even-diff-face-Ancestor ((t (:foreground "White" :background "Grey"))))

 ;'(ediff-even-diff-face-C ((t (:foreground "Black" :background "light grey"))))
 ;'(ediff-fine-diff-face-A ((t (:foreground "Navy" :background "sky blue"))))
 ;'(ediff-fine-diff-face-Ancestor ((t (:foreground "Black" :background "Green"))))
 ;'(ediff-fine-diff-face-B ((t (:foreground "Black" :background "cyan"))))
 ;'(ediff-fine-diff-face-C ((t (:foreground "Black" :background "Turquoise"))))
 ;'(ediff-odd-diff-face-A ((t (:foreground "White" :background "Grey"))))
 ;'(ediff-odd-diff-face-Ancestor ((t (:foreground "Black" :background "light grey"))))
 ;'(ediff-odd-diff-face-C ((t (:foreground "White" :background "Grey"))))

  '(ediff-current-diff-A ((t (:foreground "White" :background "brown"))))
  '(ediff-current-diff-B ((t (:foreground "White" :background "DarkGreen"))))
  '(ediff-fine-diff-B ((t (:foreground "White" :background "DarkGreen"))))
  '(ediff-current-diff-C ((t (:foreground "White" :background "#00a1c6"))))
  '(ediff-fine-diff-Ancestor ((t (:foreground "White" :background "#00a1c6"))))


  
  '(ediff-even-diff-face-B ((t (:foreground "DarkGreen" :background "Grey"))))
  '(ediff-current-diff-face-B ((t (:foreground "DarkGreen" :background "Yellow"))))
  '(ediff-odd-diff-face-B ((t (:foreground "DarkGreen" :background "DarkGreen"))))

 )




;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'late-night)

;;; late-night-theme.el ends here




(defvar ml-selected-window nil)

(defun ml-record-selected-window ()
  (setq ml-selected-window (selected-window)))

(defun ml-update-all ()
  (force-mode-line-update t))

(add-hook 'post-command-hook 'ml-record-selected-window)

(add-hook 'buffer-list-update-hook 'ml-update-all)

(defvar ml-selected-window nil)

(defun ml-record-selected-window ()
  (setq ml-selected-window (selected-window)))

(defun ml-update-all ()
  (force-mode-line-update t))

(add-hook 'post-command-hook 'ml-record-selected-window)

(add-hook 'buffer-list-update-hook 'ml-update-all)



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
		(:eval   (if (eq ml-selected-window (selected-window))
        (format-time-string "%H:%M")
        ))
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





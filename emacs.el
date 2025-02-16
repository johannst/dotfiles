(setq custom-file "~/.emacs.d/emacs-custom.el")
(load-file custom-file)

;; -- utils ---------------------------------------------------------------------

(defun install-once (pkg)
  (unless (package-installed-p pkg)
    (package-install pkg)))

;; -- emacs ---------------------------------------------------------------------

;; disable menu bar
(menu-bar-mode 0)
;; disable tool bar
(tool-bar-mode 0)
;; disable scroll bar
(scroll-bar-mode 0)
;; windows focus follow mouse (>0 means sec delay before focus)
(setq mouse-autoselect-window 0)

;; disable indenting with TABs
(setq-default indent-tabs-mode nil)

;; line numbers
;(setq display-line-numbers-type 'relative)
;(display-line-numbers-mode 0)

;; place backup of all files in single directory
(setq backup-directory-alist '(("." . "~/.emacs.d/backup")))

;; always show trailing whitespace (no mode needed)
;; variable is buffer local, hence we overwrite the global default
(setq-default show-trailing-whitespace t)
;; whitespace style (when whitespace-mode is enabled)
(setq whitespace-style '(face trailing tabs lines tab-mark))

;; -- ibuffer -------------------------------------------------------------------

(global-set-key (kbd "C-x C-b") 'ibuffer)

;; -- isearch -------------------------------------------------------------------

;; show number of matches
(setq isearch-lazy-count t)

;; -- ansi-color ----------------------------------------------------------------

(require 'ansi-color)
(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)

;; -- oderless ------------------------------------------------------------------

(install-once 'orderless)
(require 'orderless)
(setq completion-styles '(orderless basic)
      completion-category-overrides '((file (styles basic partial-completion))))

;; -- evil ----------------------------------------------------------------------

(install-once 'evil)

;; need to be set before require-ing evil
(setq evil-undo-system 'undo-redo)

(require 'evil)
(evil-mode 1)

(evil-define-key '(normal motion) 'global (kbd "C-k") 'evil-scroll-up)
(evil-define-key '(normal motion) 'global (kbd "C-j") 'evil-scroll-down)

(evil-define-key 'motion compilation-mode-map "gr" 'recompile)
(evil-define-key 'motion compilation-mode-map "n" 'next-error-no-select)
(evil-define-key 'motion compilation-mode-map "p" 'previous-error-no-select)

(evil-define-key 'motion grep-mode-map "n" 'next-error-no-select)
(evil-define-key 'motion grep-mode-map "p" 'previous-error-no-select)

(evil-define-key 'normal xref--xref-buffer-mode-map (kbd "RET") 'xref-goto-xref)
(evil-define-key 'normal xref--xref-buffer-mode-map "n" 'xref-next-line)
(evil-define-key 'normal xref--xref-buffer-mode-map "p" 'xref-prev-line)

;; -- magit ---------------------------------------------------------------------

(install-once 'magit)
(require 'magit)

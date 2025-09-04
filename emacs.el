(setq custom-file "~/.emacs.d/emacs-custom.el")
(when (file-exists-p custom-file)
  (load-file custom-file))

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
;; column numbers (mode-line)
;(column-number-mode 1)

;; fill column
;(setq fill-column 80)
;(display-fill-column-indicator-mode 1)

;; place backup of all files in single directory
(setq backup-directory-alist '(("." . "~/.emacs.d/backup")))

;; always show trailing whitespace (no mode needed)
;; variable is buffer local, hence we overwrite the global default
(setq-default show-trailing-whitespace t)
;; whitespace style (when whitespace-mode is enabled)
(setq whitespace-style '(face trailing tabs lines tab-mark))

;; -- windowing -----------------------------------------------------------------

(setq split-height-threshold nil)

;; -- evil ----------------------------------------------------------------------

(install-once 'evil)

;; need to be set before loading evil
(setq evil-undo-system 'undo-redo)

(require 'evil)
(evil-mode 1)

(evil-define-key '(normal motion) 'global (kbd "C-k") 'evil-scroll-up)
(evil-define-key '(normal motion) 'global (kbd "C-j") 'evil-scroll-down)

;; -- evil - leader -------------------------------------------------------------

(evil-set-leader '(normal motion) (kbd "SPC"))

(evil-define-key '(normal motion) 'global (kbd "<leader>ff") 'find-file)
(evil-define-key '(normal motion) 'global (kbd "<leader>g") 'magit)
(evil-define-key '(normal motion) 'global (kbd "<leader>b") 'switch-to-buffer)
(evil-define-key nil 'global (kbd "<leader>mm") 'switch-to-minibuffer)

(defun switch-to-compile ()
  (interactive)
  (let ((compilation-window (get-buffer-window "*compilation*" t)))
    (if compilation-window
        (select-window compilation-window)
      (switch-to-buffer-other-window "*compilation*"))))

(evil-define-key '(normal motion) 'global (kbd "<leader>cc") 'compile)
(evil-define-key '(normal motion) 'global (kbd "<leader>cb") 'switch-to-compile)

(defun file-name-line-number ()
  (interactive)
  (kill-new (concat (buffer-file-name) ":" (number-to-string (line-number-at-pos)))))

(evil-define-key '(normal motion) 'global (kbd "<leader>l") 'file-name-line-number)

;; -- info ----------------------------------------------------------------------

(evil-define-key 'motion Info-mode-map (kbd "TAB") 'Info-next-reference)
(evil-define-key 'motion Info-mode-map (kbd "RET") 'Info-follow-nearest-node)
(evil-define-key 'motion Info-mode-map "n" 'Info-next)
(evil-define-key 'motion Info-mode-map "p" 'Info-prev)
(evil-define-key 'motion Info-mode-map "[" 'Info-backward-node)
(evil-define-key 'motion Info-mode-map "]" 'Info-forward-node)

;; -- which-key -----------------------------------------------------------------

(install-once 'which-key)
(require 'which-key)
(which-key-mode t)

;; -- ibuffer -------------------------------------------------------------------

(evil-define-key nil 'global (kbd "C-x C-b") 'ibuffer)
(add-hook 'ibuffer-mode-hook 'hl-line-mode)

;; -- dired ---------------------------------------------------------------------

;; remove space mapping when dired is loaded in favor of <leader> key
(with-eval-after-load 'dired
  (evil-define-key nil dired-mode-map (kbd "SPC") nil))

;; -- isearch -------------------------------------------------------------------

;; show number of matches
(setq isearch-lazy-count t)

;; -- grep ----------------------------------------------------------------------

(evil-define-key 'motion grep-mode-map "n" 'next-error-no-select)
(evil-define-key 'motion grep-mode-map "p" 'previous-error-no-select)

(evil-define-key 'motion grep-mode-map "D" (lambda ()
                                             (interactive)
                                             (read-only-mode -1)
                                             (call-interactively 'delete-matching-lines)))

;; -- compile -------------------------------------------------------------------

(setq compilation-scroll-output t)

(evil-define-key 'motion compilation-mode-map "gr" 'recompile)
(evil-define-key 'motion compilation-mode-map "n" 'next-error-no-select)
(evil-define-key 'motion compilation-mode-map "p" 'previous-error-no-select)

;; ansi-color
(add-hook 'compilation-filter-hook
          (lambda ()
            (require 'ansi-color)
            (ansi-color-compilation-filter)))

;; -- xref ----------------------------------------------------------------------

(evil-define-key 'normal xref--xref-buffer-mode-map (kbd "RET") 'xref-goto-xref)
(evil-define-key 'normal xref--xref-buffer-mode-map "n" 'xref-next-line)
(evil-define-key 'normal xref--xref-buffer-mode-map "p" 'xref-prev-line)

;; -- minibuffer completion -----------------------------------------------------

(evil-define-key nil completion-in-region-mode-map (kbd "C-p") 'minibuffer-previous-completion)
(evil-define-key nil completion-in-region-mode-map (kbd "C-n") 'minibuffer-next-completion)

(evil-define-key nil minibuffer-mode-map (kbd "C-p") 'minibuffer-previous-completion)
(evil-define-key nil minibuffer-mode-map (kbd "C-n") 'minibuffer-next-completion)

;; -- eglot ---------------------------------------------------------------------

;; overwrite default clangd cmdline
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '((c-mode c-ts-mode c++-mode c++-ts-mode) . ("clangd" "--completion-style=detailed" "--header-insertion=never"))))

;; -- magit ---------------------------------------------------------------------

(install-once 'magit)
(require 'magit)

;; -- project -------------------------------------------------------------------

(setq project-buffers-viewer 'project-list-buffers-ibuffer)

;; -- oderless ------------------------------------------------------------------

(install-once 'orderless)
(require 'orderless)
(setq completion-styles '(orderless basic)
      completion-category-overrides '((file (styles basic partial-completion))))

;; -- ediff ---------------------------------------------------------------------

;; split ediffs buffers side-by-side
(setq ediff-split-window-function 'split-window-horizontally)
;; open ediff control window in the same frame
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

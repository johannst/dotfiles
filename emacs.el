;; dotfiles -- emacs.johannst.el
;; author: johannst

(provide 'johannst)

;; fix 'bad request' on package-refresh-contents (should be fixed with emcas 26.3)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; ELPA & MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(package-initialize)

;; config
(custom-set-variables
 '(font-use-system-font t)
 '(package-selected-packages (quote (spacemacs-theme evil magit rust-mode cargo)))
 '(semantic-mode t)
 '(tool-bar-mode nil)
)

;; theme
(load-theme 'spacemacs-dark t)

;; rust foo
(add-hook 'rust-mode-hook 'cargo-minor-mode)


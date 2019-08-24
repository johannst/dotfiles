;; dotfiles -- emacs.johannst.el
;; author: johannst

(provide 'johannst)

;; config
(custom-set-variables
 '(font-use-system-font t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(tool-bar-mode nil)
 '(whitespace-style '(trailing tabs newline tab-mark newline-mark))
 )

;; fix 'bad request' on package-refresh-contents (should be fixed with emcas 26.3)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; ELPA & MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
(setq package-enable-at-startup nil)
(package-initialize)

;; bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

;; theme
(use-package spacemacs-theme
  :ensure t
  :defer t
  :init
  (load-theme 'spacemacs-dark t)
  )

;; evil
(use-package evil
  :ensure t
  :config
  (evil-mode t)
  )

;; org
(use-package org
  :config
  (setq org-log-done t)
  :bind
  (:map org-mode-map
        ("M-j" . org-metadown)
        ("M-h" . org-metaleft)
        ("M-l" . org-metaright)
        ("M-k" . org-metaup)
        )
  )

;; helm
(use-package helm
  :ensure t
  :config
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-z")  'helm-select-action)
  (helm-mode t)
  )

;; helm
(use-package helm-projectile
  :ensure t
  )

;; magit
(use-package magit
  :ensure t
  )

;; company
(use-package company
  :ensure t
  :config
  (setq company-tooltip-align-annotations t)
  )

;; rust-mode
(use-package rust-mode
  :ensure t
  :mode ("\\.rs\\'" . rust-mode)
  )

;; cargo
(use-package cargo
  :ensure t
  :after (rust-mode)
  :hook (rust-mode . cargo-minor-mode)
  )

;; racer
(use-package racer
  :ensure t
  :requires (company)
  :after (rust-mode)
  :hook (
         (rust-mode . racer-mode)
         (racer-mode . company-mode)
         (racer-mode . eldoc-mode)
         )
  :bind
  (:map rust-mode-map
        ("TAB" . company-indent-or-complete-common)
        )
  )

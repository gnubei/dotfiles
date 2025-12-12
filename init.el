;;;; Emacs configuration
;; Value of a variable is set using 'setq'.
;; Generally, variables use t/nil, while modes use 1/0

;;; General settings

(setq inhibit-startup-screen t
      initial-scratch-message nil
      ring-bell-function 'ignore
      backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backups"))))
(menu-bar-mode 0)
(tool-bar-mode 0)      ; gives error warning on a non-gui emacs
(scroll-bar-mode 0)    ; same
(column-number-mode)
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;; binding for comments
(global-set-key (kbd "C-\\") 'comment-or-uncomment-region)

;; y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; utf-8 is the preferred coding system
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

;; set custom font; heigth seems to be a 10s multiple of pt (?!)
;; does not seem to work with emacs-nox but only on emacs-gtk ?!
(set-face-attribute 'default nil
		    :family "Adwaita Mono"
		    :height 105)

;;; Package management
;; package.el is the default package manager of Emacs
(require 'package)    

;; Package repositories
;; add-to-list method
;;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;; setq variables method
(setq package-archives
      '(("gnu elpa" . "https://elpa.gnu.org/packages/")
	("melpa" . "https://melpa.org/packages/")
	("org" . "https://orgmode.org/elpa/")
	("melpa stable" . "https://stable.melpa.org/packages/")
	("nongnu" . "https://elpa.nongnu.org/nongnu/"))
      package-archive-priorities
      '(("gnu elpa" . 20)
	("melpa" . 15)
	("org" . 10)
	("melpa stable" . 5)
	("nongnu" . 0)))
(package-initialize)

;; use-package is a macro that is highly recommended for managing packages
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))

;; Optional: Automatically install all future packages by default
(setq use-package-always-ensure t
      use-package-expand-minimally t)

;; example configurations using use-package
(use-package magit
  :bind ("C-x g" . magit-status))

(use-package which-key
  :ensure t
  :config
  (which-key-mode))
;; which-key helps one find different keybindings easily. Whenever we
;; press a leader key, like C-x, a list of all the different keybindings
;; pops up.

;;(use-package markdown-mode
;;  :mode ("\\.md\\'" . markdown-mode)
;;  :hook (markdown-mode . auto-fill-mode)
;;  :custom-face (markdown-code-face ((t (:inherit org-block)))))

;; NOTE:
;; Here :mode, :hook, :custom-face are all sugar-coating for plain elisp
;; syntaxes.
;; (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
;; (add-hook 'markdown-mode-hook #'auto-fill-mode)
;; (set-face-attribute 'markdown-code-face nil :inherit 'org-block)


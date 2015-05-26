(add-to-list 'load-path "~/.emacs.d/package/")
(load "init-elpa.el")
(load "init-base.el")
(eval-when-compile
  (require 'use-package))
;; (require 'diminish)
(require 'bind-key)
(use-package jazz-theme
  ;;ample-theme
  :init (load-theme 'jazz t)
  ;;ample-flat
  :defer t
  :ensure t)
(use-package window-numbering
  :init (window-numbering-mode t)
  :defer t
  :ensure t)
(use-package undo-tree
  :init (global-undo-tree-mode 1)
  :bind
  (("C-/" . undo-tree-undo)
   ("C-x /" . undo-tree-redo)
   ;;("C-c l" . undo-tree-switch-branch)
   ("C-x u" . undo-tree-visualize))
  :ensure t)
(use-package ibuffer
  :defer t
  ;;:chords ((" 1". ibuffer))
  :bind (("C-x c-b". ibuffer)))
(use-package smartparens
  :init (smartparens-global-mode 1)
  :defer t
  :ensure t)
(use-package smex
  :commands smex
  :bind (("M-x" . smex))
  :ensure t)
(use-package helm
  :init (require 'helm-config)
  :defer t
  :ensure t)
(use-package yasnippet
  :init (yas-global-mode 1)
  :ensure t)
(use-package auto-complete
  :init (global-auto-complete-mode t)
  :defer t
  :config (progn
            (use-package auto-complete-config)
            ;; (after (:slime) (add-to-list 'ac-modes 'slime-repl-mode))
            ;; (after (:js2-mode) (add-to-list 'ac-modes 'js2-mode))
            ;; (after (:js-mode) (add-to-list 'ac-modes 'js-mode))
            ;; (after (:ruby-mode) (add-to-list 'ac-modes 'ruby-mode))
            (ac-config-default))
  ;; :config (
  ;; 		   (require 'auto-complete-config)
  ;; 		   progn
  ;; 			(use-package auto-complete-config))
  :ensure t)
(use-package emmet-mode
  :init (require 'emmet-mode)
  :config (progn
			(add-hook 'sgml-mode-hook 'emmet-mode)
			(add-hook 'html-mode-hook 'emmet-mode)
			(add-hook 'css-mode-hook 'emmet-mode)
			(add-hook 'web-mode-hook 'emmet-mode))
  :defer t
  :ensure t)
(use-package web-mode
  :ensure t)
;; (use-package chinese-pyim
;;   :init (require 'chinese-pyim)
;;   :config (progn (setq default-input-method "chinese-pyim")
;; 				 (setq pyim-use-tooltip t)
;; 				 (global-set-key (kbd "C-<SPC>") 'toggle-input-method)
;; 				 (global-set-key (kbd "C-;") 'pyim-toggle-full-width-punctuation)
;; 				 (custom-set-variables
;; 				  ;; custom-set-variables was added by Custom.
;; 				  ;; If you edit it by hand, you could mess it up, so be careful.
;; 				  ;; Your init file should contain only one such instance.
;; 				  ;; If there is more than one, they won't work right.
;; 				  '(pyim-dicts
;; 					(quote
;; 					 ((:name "name" :file "~/.emacs.d/pyim/dicts/name.pyim" :coding utf-8-unix)))))
;; 				 (custom-set-faces
;; 				  ;; custom-set-faces was added by Custom.
;; 				  ;; If you edit it by hand, you could mess it up, so be careful.
;; 				  ;; Your init file should contain only one such instance.
;; 				  ;; If there is more than one, they won't work right.
;; 				  )
;; 				 )
;;   :ensure t)

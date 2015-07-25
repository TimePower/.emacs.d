(add-to-list 'load-path "~/.emacs.d/package/")
(load "init-elpa.el")
(load "init-base.el")
(load "init-page.el")
(eval-when-compile
  (require 'use-package))
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
(use-package smartparens
  :init (smartparens-global-mode 1)
  :defer t
  :ensure t)
(use-package smex
  :commands smex
  :bind ("M-x" . smex)
  :ensure t)
(use-package helm
  :init (require 'helm-config)
  :config ()
  :bind ("C-x C-b" . helm-buffers-list)
  :defer t
  :ensure t)
(use-package yasnippet
  :init (yas-global-mode 1)
  :config (progn
			(add-to-list 'yas/root-directory "~/.emacs.d/snippets")
			(yas/initialize))
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
  :config (add-hook 'html-mode-hook 'web-mode)
  :ensure t)
(use-package buffer-move
  :bind (("C-s-p" . buf-move-up)
		 ("C-s-n" . buf-move-down)
		 ("C-s-b" . buf-move-left)
		 ("C-s-f" . buf-move-right))
  :ensure t)
(use-package js2-mode
  :mode ("\\.js$" . js2-mode)
  :ensure t)
(use-package tern
  :config (add-hook 'js2-mode 'term-mode)
  :ensure t)
(use-package emms
  :config (progn
			(require 'emms-setup)
			(emms-all)
			(emms-default-players))
  :ensure t)
(use-package ocodo-svg-modelines
  :ensure t)
(use-package youdao-dictionary
  :config (progn
			;; Enable Cache
			(setq url-automatic-caching t)
			;; Example Key binding
			(global-set-key (kbd "C-c y") 'youdao-dictionary-search-at-point))
  :ensure t)
(use-package rainbow-mode
  :defer t
  :ensure t)
(use-package openwith
  :config (progn
			(when (require 'openwith nil 'noerror)
			  (setq openwith-associations
					(list
					 (list (openwith-make-extension-regexp
							'("mpg" "mpeg" "mp3" "mp4"
							  "avi" "wmv" "wav" "mov" "flv"
							  "ogm" "ogg" "mkv"))
						   "vlc"
						   '(file))
					 (list (openwith-make-extension-regexp
							'("xbm" "pbm" "pgm" "ppm" "pnm"
							  "png" "gif" "bmp" "tif" "jpeg" "jpg"))
						   "eog"
						   '(file))
					 (list (openwith-make-extension-regexp
							'("pdf"))
						   "evince"
						   '(file))
					 (list (openwith-make-extension-regexp
							'("doc" "docx"))
						   "wps"
						   '(file))
					 ))
			  (openwith-mode 1)))
  :ensure t)

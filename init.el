(add-to-list 'load-path "~/.emacs.d/package/")
(load "init-elpa.el")
(load "init-base.el")
;;(load "init-page.el")
(eval-when-compile
  (require 'use-package))
(require 'bind-key)
(use-package ample-theme
  :init (progn (load-theme 'ample t t)
               (load-theme 'ample-flat t t)
               (load-theme 'ample-light t t)
               (enable-theme 'ample-light))
  ;; Jazz-theme
  ;; Ample-theme
  ;; Junio
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
  :init (progn
          (require 'helm-config)
          (helm-mode t))
  :config (progn
            (setq helm-M-x-fuzzy-match t
                  helm-split-window-in-side-p t
                  ;; open helm buffer inside current window, not occupy whole other window
                  helm-move-to-line-cycle-in-source t
                  ;; move to end or beginning of source when reaching top or bottom of source.
                  helm-ff-search-library-in-sexp t
                  ;; search for library in 'require' and 'declare-function' sexp.
                  helm-scroll-amount 8
                  ;; scroll 8 lines other window using M-<next>/M-<prior>
                  helm-ff-file-name-history-use-recentf t)
            ;; 提供更好的 Kill Ring
            (global-set-key (kbd "M-y") 'helm-show-kill-ring)
            ;; 提供更好的关键字搜索
            (global-set-key (kbd "C-s") 'helm-occur)
            ;; 提供 ido 备用, 可用 C-c / 搜索制定目录文件
            (global-set-key (kbd "C-c f") 'helm-find-files)
            (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action))
  :bind ("C-x C-b" . helm-buffers-list)
  :defer t
  :ensure t)
(use-package neotree
  :init (require 'neotree)
  :config (global-set-key [f6] 'neotree-toggle)
  :ensure t)
(use-package yasnippet
  :init (yas-global-mode 1)
  :config (progn
            (add-to-list 'yas/root-directory "~/.emacs.d/snippets")
            (yas/initialize))
  :ensure t)
(use-package auto-complete
  :config (progn
            ;; (after (:slime) (add-to-list 'ac-modes 'slime-repl-mode))
            (require 'auto-complete-config)
            (global-auto-complete-mode t)
            ;; 扩大候选词
            (setq ac-expand-on-auto-complete nil)
            ;; nil 关闭自动启动
            (setq ac-auto-start nil)
            ;; 激活 ac
            (ac-set-trigger-key "C-i")
            (setq ac-use-menu-map t)
            (setq ac-dwim nil)
            (define-key ac-mode-map (kbd "C-c i") 'auto-complete)
            (define-key ac-menu-map "\C-n" 'ac-next)
            (define-key ac-menu-map "\C-p" 'ac-previous)
            (dolist (mode '(magit-log-edit-mode
                            log-edit-mode org-mode text-mode haml-mode
                            sass-mode yaml-mode csv-mode espresso-mode haskell-mode
                            html-mode web-mode sh-mode smarty-mode clojure-mode
                            lisp-mode textile-mode markdown-mode tuareg-mode
                            js2-mode css-mode less-css-mode))
              (add-to-list 'ac-modes mode))
            (ac-config-default)
            (provide 'init-auto-complete))
  :ensure t)
(use-package tern
  :config (add-hook 'js2-mode-hook (lambda () (tern-mode t)))
  :ensure t)
(use-package company
  :init (global-company-mode t)
  :config (progn
            (add-hook 'after-init-hook 'global-company-mode)
            ;; bigger popup window
            (setq company-tooltip-limit 20)
            ;; align annotations to the right tooltip border
            (setq company-tooltip-align-annotations 't)
            ;; decrease delay before autocompletion popup shows
            (setq company-idle-delay .3)
            ;; start autocompletion only after typing
            (setq company-begin-commands '(self-insert-command))
            ;; Force complete file names on "C-c /" key
            (global-set-key (kbd "C-c /") 'company-files))
  :ensure t)
(use-package company-web
  :config (progn
            (add-hook 'web-mode-hook (lambda ()
                                       (set (make-local-variable 'company-backends) '(company-web-html))
                                       (company-mode t))))
  :ensure t)
(use-package company-tern
  :config (progn
            (add-to-list 'company-backends 'company-tern)
            (setq company-tern-meta-as-single-line t)
            (setq company-tooltip-align-annotations t)
            (global-set-key (kbd "C-<tab>") 'company-complete-common))
  :ensure t)
(use-package emmet-mode
  :init (require 'emmet-mode)
  :config (progn
            (add-hook 'html-mode-hook 'emmet-mode)
            (add-hook 'sgml-mode-hook 'emmet-mode)
            (add-hook 'css-mode-hook 'emmet-mode)
            (add-hook 'web-mode-hook 'emmet-mode))
  :defer t
  :ensure t)
(use-package web-mode
  :config (progn
            (add-hook 'html-mode-hook 'web-mode)
            (setq web-mode-enable-current-element-highlight t)
            (setq web-mode-enable-current-column-highlight t)
            (setq web-mode-enable-css-colorization t))
:ensure t)
(use-package buffer-move
  :bind (("C-s-p" . buf-move-up)
         ("C-s-n" . buf-move-down)
         ("C-s-b" . buf-move-left)
         ("C-s-f" . buf-move-right))
  :ensure t)
(use-package expand-region
  :config (progn
            (require 'expand-region)
            (global-set-key (kbd "C-=") 'er/expand-region))
  :ensure t)
(use-package js2-mode
  :mode ("\\.js\\'" . js2-mode)
  :config (progn
            (add-hook 'js-mode-hook 'js2-minor-mode)
            (add-hook 'js-mode-hook 'highlight-indentation-mode)
            (add-hook 'js-mode-hook 'highlight-indentation-current-column-mode)
            (add-hook 'js-mode-hook 'highlight-parentheses-mode))
  :ensure t)
(use-package ac-js2
  :config (progn
            (setq ac-js2-evaluate-calls t)
            (add-hook 'js2-mode-hook 'ac-js2-mode))
  :ensure t)
(use-package racket-mode
  :config (progn
            (add-hook 'racket-mode-hook
                      (lambda ()
                        (define-key racket-mode-map (kbd "C-c r") 'racket-send-region)))
            (add-hook 'racket-mode-hook 'highlight-parentheses-mode))
  :ensure t)
(use-package go-mode
  :init (require 'go-mode-autoloads)
  :ensure t)
(use-package flycheck
  ;; :config (global-flycheck-mode)
  :ensure t)
(use-package emms
  :config (progn
            (require 'emms-setup)
            (emms-all)
            (emms-default-players)
            (global-set-key (kbd "C-c e c") 'emms-pause)
            (global-set-key (kbd "C-c e p") 'emms-previous)
            (global-set-key (kbd "C-c e n") 'emms-next))
  :ensure t)
(use-package emms-player-mpv
  :config (progn
            ;; mpv 作为 emms 后端
            (require 'emms-player-mpv)
            (add-to-list 'emms-player-list 'emms-player-mpv))
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
                           "audacious"
                           '(file))
                     (list (openwith-make-extension-regexp
                            '("xbm" "pbm" "pgm" "ppm" "pnm"
                              "png" "bmp" "tif" "jpeg" "jpg"))
                           "gpicview"
                           '(file))
                     (list (openwith-make-extension-regexp
                            '("pdf"))
                           "zathura"
                           '(file))
                     (list (openwith-make-extension-regexp
                            '("doc" "docx"))
                           "wps"
                           '(file))
                     ))
              (openwith-mode 1)))
  :ensure t)
(use-package ace-jump-mode
  :config (progn
            (autoload
              'ace-jump-mode
              "ace-jump-mode"
              "Emacs quick move minor mode"
              t)
            ;; you can select the key you prefer to
            (define-key global-map (kbd "C-c SPC") 'ace-jump-char-mode))
  :ensure t)
(use-package multiple-cursors
  :init (require 'multiple-cursors)
  :config (progn
            (global-set-key (kbd "C->") 'mc/mark-next-like-this)
            (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
            (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this))
  :ensure t)
(use-package nyan-mode
  :init (nyan-mode t)
  :ensure t)
(use-package org-bullets
  :init (require 'org-bullets)
  :config (progn
            (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

            ;;             (setq org-todo-keywords '((sequence &amp;amp;quot;? TODO(t)&amp;amp;quot; &amp;amp;quot;|&amp;amp;quot; &amp;amp;quot;? DONE(d)&amp;amp;quot;)
            ;; (sequence &amp;amp;quot;|&amp;amp;quot; &amp;amp;quot;? WAITING(w)&amp;amp;quot;)
            ;; (sequence &amp;amp;quot;|&amp;amp;quot; &amp;amp;quot;? CANCELED(c)&amp;amp;quot;)))

            )
  :ensure t)
(use-package highlight-indentation
  :init (require 'highlight-indentation)
  :config(progn
           (set-face-background 'highlight-indentation-face "#959595")
           (set-face-background 'highlight-indentation-current-column-face "#CDBFBF"))
  :ensure t)
(use-package highlight-parentheses
  :init (require 'highlight-parentheses)
  :config (progn
            (add-hook 'emacs-lisp-mode-hook 'highlight-parentheses-mode))
  :ensure t)
(use-package magit
  :init (require 'magit)
  :config(progn
           (with-eval-after-load 'info
             (info-initialize)
             (add-to-list 'Info-directory-list
                          "~/.emacs.d/site-lisp/magit/Documentation/")))
  :ensure t)

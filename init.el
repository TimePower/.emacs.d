
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/package/")
(load "init-elpa.el")
(load "init-base.el")
;; (load "init-page.el")
(eval-when-compile
  (require 'use-package))
(require 'diminish)
(require 'bind-key)
;; 需要单独配置 org-page
(load "init-orgpage.el")
(use-package dracula-theme
  :init (load-theme 'dracula t)
  ;; Dracula-theme
  ;; Jazz-theme
  ;; Ample-theme
  ;; Junio
  :ensure t)
(use-package window-numbering
  :init (window-numbering-mode t)
  ;; :defer t
  :ensure t)
(use-package undo-tree
  :diminish undo-tree-mode
  :init (global-undo-tree-mode 1)
  :bind
  (("C-/" . undo-tree-undo)
   ("C-x /" . undo-tree-redo)
   ;;("C-c l" . undo-tree-switch-branch)
   ("C-x u" . undo-tree-visualize))
  :ensure t)
(use-package smartparens
  :init (smartparens-global-mode 1)
  ;; :defer t
  :ensure t)
(use-package smex
  :commands smex
  :bind ("M-x" . smex)
  :ensure t)
(use-package helm
  :diminish helm-mode
  :init (progn
          (require 'helm-config)
          ;; Fix ad-handle-definition: 'tramp-read-passwd' got redefined
          ;; https://github.com/emacs-helm/helm/issues/1498
          (let ((ad-redefinition-action 'accept))
            (helm-mode 1)))
  :config (progn
            (helm-autoresize-mode 1)
            (setq helm-M-x-fuzzy-match t
                  helm-split-window-in-side-p t
                  ;; open helm buffer inside current window, not occupy whole other window
                  helm-move-to-line-cycle-in-source t
                  ;; move to end or beginning of source when reaching top or bottom of source.
                  helm-ff-search-library-in-sexp t
                  ;; search for library in `require' and `declare-function' sexp.
                  helm-scroll-amount 8
                  ;; scroll 8 lines other window using M-<next>/M-<prior>
                  helm-ff-file-name-history-use-recentf t
                  helm-autoresize-max-height 25
                  helm-autoresize-min-height 25)
            ;; 提供更好的 Kill Ring
            (global-set-key (kbd "M-y") 'helm-show-kill-ring)
            ;; 提供更好的关键字搜索
            ;; (global-set-key (kbd "C-s") 'helm-occur)
            ;; 提供 ido 备用, 可用 C-c / 搜索制定目录文件
            (global-set-key (kbd "C-c f") 'helm-find-files)
            ;;(global-set-key (kbd "C-c h") 'helm-command-prefix)
            ;; (global-set-key (kbd "C-M-x") 'helm-M-x)
            ;; rebind tab to run persistent action
            (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action))
  :bind (("C-x C-b" . helm-buffers-list)
         ("C-M-x" . helm-M-x))
  ;; :defer t
  :ensure t)
(use-package swiper-helm
  :ensure t)
(use-package swiper
  :diminish ivy-mode
  :config (progn
            (ivy-mode 1)
            (setq ivy-use-virtual-buffers t)
            (global-set-key "\C-s" 'swiper))
  :ensure t)
(use-package avy
  :config (progn
            (global-set-key (kbd "C-'") 'avy-goto-char)
            (global-set-key (kbd "C-c '") 'avy-goto-line)
            (global-set-key (kbd "C-c s") 'avy-goto-word-1))
  :ensure t)
(use-package ace-jump-mode
  :diminish ace-jump-mode
  :config (progn
            (autoload
              'ace-jump-mode
              "ace-jump-mode"
              "Emacs quick move minor mode"
              t)
            ;; you can select the key you prefer to
            ;;(define-key global-map (kbd "C-c SPC") 'ace-jump-mode
            (define-key global-map (kbd "C-c SPC") 'ace-jump-char-mode))
  :ensure t)
(use-package neotree
  :init (require 'neotree)
  :config (global-set-key [f6] 'neotree-toggle)
  :ensure t)
(use-package projectile
  :diminish projectile-mode
  :config (progn
            (projectile-global-mode)
            (add-hook 'js2-mode-hook 'projectile-mode)
            (add-hook 'web-mode-hook 'projectile-mode)
            (add-hook 'css-mode-hook 'projectile-mode)
            (add-hook 'c-mode-hook 'projectile-mode)
            (setq projectile-enable-caching t)
            (setq projectile-globally-ignored-directories '("node_modules")))
  :ensure t)
(use-package helm-projectile
  :ensure t)
(use-package yasnippet
  ;; :defer t
  :diminish yas-global-mode
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
            (dolist (mode '(magit-log-edit-mode cperl-mode perl-mode
                                                log-edit-mode org-mode text-mode haml-mode conf-mode
                                                sass-mode yaml-mode csv-mode espresso-mode haskell-mode
                                                html-mode web-mode sh-mode smarty-mode clojure-mode
                                                lisp-mode textile-mode markdown-mode tuareg-mode
                                                js2-mode css-mode less-css-mode))
              (add-to-list 'ac-modes mode))
            (ac-config-default)
            (provide 'init-auto-complete))
  :ensure t)
;; (use-package angular-snippets
;;   :init (require 'angular-snippets)
;;   :ensure t)
;; (use-package angular-mode
;;   :config (progn
;;             (add-to-list 'ac-dictionary-directories "~/.emacs.d/snippets/ac-dict")
;;             (add-to-list 'ac-modes 'angular-html-mode)
;;             (add-to-list 'ac-modes 'angular-mode))
;;  :ensure t)
(use-package tern
  :config (add-hook 'js2-mode-hook (lambda () (tern-mode t)))
  :ensure t)
(use-package company
  :diminish company-mode
  :init (global-company-mode t)
  :config (progn
            (add-hook 'after-init-hook 'global-company-mode)
            (add-hook 'c-mode-hook 'company-mode)
            (add-to-list 'company-backends 'company-capf)
            ;; Fix Completion of org-mode
            (defun my-org-mode-hook ()
              (add-hook 'completion-at-point-functions 'pcomplete-completions-at-point nil t))
            (add-hook 'org-mode-hook #'my-org-mode-hook)
            ;; Company-Semantic Is Original Semantic Completion Of Company-Mode
            ;; So Diable It, Use Company-Clang.
            (setq company-backends (delete 'company-semantic company-backends))
            ;; bigger popup window
            (setq company-tooltip-limit 20)
            ;; align annotations to the right tooltip border
            (setq company-tooltip-align-annotations 't)
            ;; decrease delay before autocompletion popup shows
            (setq company-idle-delay .3)
            ;; start autocompletion only after typing
            (setq company-begin-commands '(self-insert-command))
            ;; Force complete file names on "C-c /" key
            (global-set-key (kbd "C-c /") 'company-files)
            (global-set-key (kbd "C-<tab>") 'company-complete-common)
            ;; 防止按键冲突备用
            (global-set-key (kbd "C-|") 'company-complete)
            )
  :ensure t)
(use-package company-c-headers
  :config (add-to-list 'company-backends 'company-c-headers)
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
            (setq company-tooltip-align-annotations t))
  :ensure t)
(use-package emmet-mode
  :diminish emmet-mode
  :init (require 'emmet-mode)
  :config (progn
            (add-hook 'html-mode-hook 'emmet-mode)
            (add-hook 'sgml-mode-hook 'emmet-mode)
            (add-hook 'css-mode-hook 'emmet-mode)
            (add-hook 'web-mode-hook 'emmet-mode))
  ;; :defer t
  :ensure t)
(use-package web-mode
  :config (progn
            (add-hook 'html-mode-hook 'web-mode)
            (setq web-mode-enable-current-element-highlight t)
            (setq web-mode-enable-current-column-highlight t)
            (setq web-mode-enable-css-colorization t)
            ;; (setq web-mode-ac-sources-alist
            ;;       '(("css" . (ac-source-css-property))
            ;; ("html" . (ac-source-html-tag
            ;;            ac-source-html-attr
            ;;            ac-source-html-attrv))
            ;;)
            )
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
            (setq tab-always-indent 'complete)
            (defun my-racket-mode-hook ()
              (set (make-local-variable 'company-backends)
                   '((company-capf company-dabbrev-code))))
            (add-hook 'racket-mode-hook 'my-racket-mode-hook)
            (add-hook 'racket-mode-hook 'highlight-parentheses-mode))
  :ensure t)
(use-package geiser
  :ensure t)
(use-package tuareg
  :mode ("\\.ml\\'" . tuareg-mode)
  :ensure t)
;; (use-package go-mode
;;   :init (require 'go-mode-autoloads)
;;   :ensure t)
(use-package cperl-mode
  :mode ("\\.pl\\'" . cperl-mode)
  )
(use-package plsense
  :config (progn
            (require 'plsense)
            ;; Key binding
            (setq plsense-popup-help-key "C-:")
            ;; (setq plsense-display-help-buffer-key "M-:")
            ;; (setq plsense-jump-to-definition-key "C->")
            (add-hook 'cperl-mode-hook 'plsense-setup-current-buffer)
            ;; Make config suit for you. About the config item, eval the following sexp.
            ;; (customize-group "plsense")

            ;; Do setting recommemded configuration
            (plsense-config-default))
  :ensure t)
(use-package flycheck
  ;; :config (global-flycheck-mode)
  :ensure t)
(use-package cmake-mode
  :mode ("CMakeLists\\.txt\\'" . cmake-mode)
  :ensure t)
(use-package emms
  ;; :defer t
  :config (progn
            (require 'emms-setup)
            (emms-all)
            (emms-default-players)
            (emms-standard)
            (setq emms-repeat-playlist t)
            (setq emms-player-list '(emms-player-mplayer))
            (setq emms-source-file-directory "~/Music/Heavy Metal/")
            (global-set-key (kbd "C-c e c") 'emms-pause)
            (global-set-key (kbd "C-c e p") 'emms-previous)
            (global-set-key (kbd "C-c e n") 'emms-next))
  :ensure t)
(use-package emms-player-mpv
  ;; :defer t
  :config (progn
            ;; mpv 作为 emms 后端
            (require 'emms-player-mpv)
            (add-to-list 'emms-player-list 'emms-player-mpv))
  :ensure t)
(use-package emms-mode-line-cycle
  ;; :defer t
  :config (progn
            (emms-mode-line 1)
            (emms-playing-time 1)

            ;; `emms-mode-line-cycle' can be used with emms-mode-line-icon.
            (require 'emms-mode-line-icon)
            (custom-set-variables '(emms-mode-line-cycle-use-icon-p t))

            (emms-mode-line-cycle 1))
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
  :diminish rainbow-mode
  :config (progn
            (add-hook 'css-mode-hook 'rainbow-mode))
  ;; :defer t
  :ensure t)
(use-package openwith
  :config (progn
            (when (require 'openwith nil 'noerror)
              (setq openwith-associations
                    (list
                     ;; (list (openwith-make-extension-regexp
                     ;;        '("mpg" "mpeg" "mp3" "mp4"
                     ;;          "avi" "wmv" "wav" "mov" "flv"
                     ;;          "ogm" "ogg" "mkv"))
                     ;;       "audacious"
                     ;;       '(file))
                     ;; (list (openwith-make-extension-regexp
                     ;;        '("xbm" "pbm" "pgm" "ppm" "pnm"
                     ;;          "png" "bmp" "tif" "jpeg" "jpg"))
                     ;;       "gpicview"
                     ;;       '(file))
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
(use-package multiple-cursors
  :init (require 'multiple-cursors)
  :config (progn
            (global-set-key (kbd "C->") 'mc/mark-next-like-this)
            (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
            (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this))
  :ensure t)
;; 貌似不支持 nyan
;; (use-package main-line
;;   :init (require 'main-line)
;;   :config (setq main-line-separator-style 'zigzag)
;;   :ensure t)
(use-package powerline
  :config (progn
            (require 'powerline)
            (powerline-default-theme))
  :ensure t)
(use-package nyan-mode
  :init (nyan-mode t)
  :config (progn
            (setq nyan-bar-length 48)
            (setq nyan-cat-face-number 4))
  :ensure t)
(use-package org-bullets
  :init (require 'org-bullets)
  :config (progn
            (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
            ;; (add-hook 'org-mode-hook 'refill-mode)
            ;; (setq org-todo-keywords '((sequence &amp;amp;quot;? TODO(t)&amp;amp;quot; &amp;amp;quot;|&amp;amp;quot; &amp;amp;quot;? DONE(d)&amp;amp;quot;)
            ;; (sequence &amp;amp;quot;|&amp;amp;quot; &amp;amp;quot;? WAITING(w)&amp;amp;quot;)
            ;; (sequence &amp;amp;quot;|&amp;amp;quot; &amp;amp;quot;? CANCELED(c)&amp;amp;quot;)))
            )
  :ensure t)
(use-package highlight-indentation
  :diminish highlight-indentation-mode
  :diminish highlight-indentation-current-column-mode
  :init (require 'highlight-indentation)
  :config(progn
           (set-face-background 'highlight-indentation-face "#959595")
           (set-face-background 'highlight-indentation-current-column-face "#CDBFBF"))
  :ensure t)
(use-package highlight-parentheses
  :diminish highlight-parentheses-mode
  :init (require 'highlight-parentheses)
  :config (progn
            (add-hook 'emacs-lisp-mode-hook 'highlight-parentheses-mode)
            (add-hook 'scheme-mode-hook 'highlight-parentheses-mode)
            (add-hook 'cperl-mode-hook 'highlight-parentheses-mode)
            (add-hook 'c-mode-hook 'highlight-parentheses-mode))
  :ensure t)
(use-package vi-tilde-fringe
  :init (global-vi-tilde-fringe-mode t)
  :ensure t)
;; (use-package magit
;;   :init (require 'magit)
;;   :config(progn
;;            (with-eval-after-load 'info
;;              (info-initialize)
;;              (add-to-list 'Info-directory-list
;;                           "~/.emacs.d/site-lisp/magit/Documentation/"))
;;            (setq magit-completing-read-function 'ivy-completing-read))
;;   :ensure t)
(use-package symon
  :config (progn
            (require 'symon)
            (symon-mode 0))
  :ensure t)
;; (use-package weibo
;;   :config (progn
;;             (require 'weibo)
;;             (setq weibo-consumer-key "2645755358"
;;                   weibo-consumer-secret "bb543651eedc797f8fdc5f273d569dc3"
;;                   ))
;;   :ensure t)
(use-package esup
  :ensure t)
(use-package pangu-spacing
  :config (progn
            (require 'pangu-spacing)
            (global-pangu-spacing-mode 1)
            (setq pangu-spacing-real-insert-separtor t))
  :ensure t)
;; (use-package diminish
;;   :ensure t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(emms-mode-line-cycle-use-icon-p t)
 '(magit-push-arguments nil)
 '(package-selected-packages
   (quote
    (geiser 0blayout chess pangu-spacing company-c-headers youdao-dictionary yasnippet window-numbering weibo web-mode vi-tilde-fringe undo-tree tuareg symon swiper-helm spaceline smex smartparens rainbow-mode racket-mode plsense perl-completion org-page org-bullets openwith ocodo-svg-modelines nyan-mode neotree multiple-cursors magit highlight-parentheses highlight-indentation helm-projectile helm-emms go-mode flycheck expand-region esup emms-player-mpv emms-mode-line-cycle emmet-mode dracula-theme diminish company-web company-tern cmake-mode buffer-move avy angular-mode ample-theme ace-jump-mode ac-js2))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

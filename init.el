(add-to-list 'load-path "~/.emacs.d/package/")
(load "init-elpa.el")
(load "init-base.el")
(use-package window-numbering
  :init (window-numbering-mode t)
  :defer t
  :ensure t)
(use-package undo-tree
  :init (global-undo-tree-mode 1)
  :bind
  (("C-/" . undo-tree-undo)
   ("C-x /" . undo-tree-redo)
  ;;        ("C-c l" . undo-tree-switch-branch)
   ("C-x u" . undo-tree-visualize))
  :ensure t)
(use-package ample-theme
  :init (load-theme 'ample-flat t)
  :defer t
  :ensure t)
(use-package ibuffer
  :defer t
  ;;:chords ((" 1". ibuffer))
  :bind (("C-x c-b". ibuffer)))
(use-package smartparens
  :init (smartparens-global-mode 1)
  :defer t
  :ensure t)

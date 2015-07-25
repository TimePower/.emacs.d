;;ido
(require 'ido)
(ido-mode t)
(setq ido-save-directory-list-file "~/.emacs.d/.ido.last")
(setq ido-enable-flex-matching t)
(setq ido-use-filename-at-point 'guess)
(setq ido-show-dot-for-dired t)
(setq ido-default-buffer-method 'selected-window)

;;设置有用的个人信息,这在很多地方有用。
(setq user-full-name "timepower")
(setq user-mail-address "timepower@live.it")

;;去掉Emacs和gnus启动时的引导界面
(setq inhibit-startup-message t)
(setq gnus-inhibit-startup-message t)

;; 标题栏显示文件路径
(setq frame-title-format
      '("%S" (buffer-file-name "%f"
							   (dired-directory dired-directory "%b"))))

;;*scratch* buffer
(setq initial-major-mode 'org-mode)
(setq initial-scratch-message "Hello Emacs ^_^")

;; 去掉工具栏
(tool-bar-mode -1)

;;去掉菜单栏
(menu-bar-mode -1)

;; 去掉滚动栏
(scroll-bar-mode -1)

;; 显示列号
(global-linum-mode t)

;; Highlight Line
(global-hl-line-mode)

;;显示括号匹配
(show-paren-mode t)
;;(setq show-paren-style 'parentheses)

;; 默认显示 80列就换行
(setq default-fill-column 80)

;;显示时间，格式如下
(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)

;;光标靠近鼠标指针时，让鼠标指针自动让开，别挡住视线。很好玩阿，这个功能
(mouse-avoidance-mode 'animate)

;;高亮显示选中文本
(transient-mark-mode t)

(set-frame-font "Monaco 11" nil t)

;;Chinese Font
(set-fontset-font "fontset-default" 'han '("冬青黑体简体中文"))
(setq face-font-rescale-alist '(("冬青黑体简体中文" . 1.2) ("Microsoft Yahei" . 1.2)))

(global-font-lock-mode t);语法高亮

(auto-image-file-mode t);打开图片显示功能

(fset 'yes-or-no-p 'y-or-n-p);以 y/n代表 yes/no

;; 按下C-x k立即关闭掉当前的buffer  
(global-set-key (kbd "C-x k") 'kill-this-buffer)  

;; 回车缩进
(global-set-key "\C-m" 'newline-and-indent)

;;Eshell
(global-set-key [f9] 'eshell)

;; Ansi-term
(global-set-key [f8] 'ansi-term)
(add-hook 'term-mode-hook (lambda()
                (yas-minor-mode -1)))

;; 设置默认tab宽度
(setq tab-width 4
      indent-tabs-mode t
      c-basic-offset 4)
(setq default-tab-width 4)

;;(loop for x downfrom 40 to 1 do
;;    (setq tab-stop-list (cons (* x 4) tab-stop-list)))

;;M-n/p 移动本文
;;功能如下
;;(global-set-key (kbd "M-n") 'scroll-up-line)
;;(global-set-key (kbd "M-p") 'scroll-down-line)
(defun hold-line-scroll-up()
  "Scroll the page with the cursor in the same line"
  (interactive)
  (let ((next-screen-context-lines
		 (count-lines
		  (window-start) (window-end))))
    (scroll-up)))

(defun hold-line-scroll-down()
  "Scroll the page with the cursor in the same line"
  (interactive)
  (let ((next-screen-context-lines
		 (count-lines
		  (window-start) (window-end))))
    (scroll-down)))
(global-set-key (kbd "M-n") 'hold-line-scroll-up)
(global-set-key (kbd "M-p") 'hold-line-scroll-down)

;;"Add a line next current like IDEA"
(defun newline-next-current()
  (interactive)
  (prog1 (end-of-line)
	(newline-and-indent)))
(global-set-key (kbd "C-<return>") 'newline-next-current)

;; newline-table实现IDEA的回车自动对齐功能
(defun newline-table()
  (interactive)
  (prog1 (newline-and-indent)
	(newline-and-indent)
	(previous-line)
	(indent-for-tab-command)))
(global-set-key [(meta return)] 'newline-table)

;;格式化整个文件函数
(defun indent-whole ()
  (interactive)
  (indent-region (point-min) (point-max))
  (message "format successfully"))
(global-set-key [f7] 'indent-whole)

;;滚动页面时比较舒服，不要整页的滚动
;; (setq scroll-step 1
;;       scroll-margin 3
;;       scroll-conservatively 10000)

;;代码折叠 C-c TAB
(defun aj-toggle-fold ()
  "Toggle fold all lines larger than indentation on current line"
  (interactive)
  (let ((col 1))
    (save-excursion
      (back-to-indentation)
      (setq col (+ 1 (current-column)))
      (set-selective-display
       (if selective-display nil (or col 1))))))
(global-set-key (kbd "C-c TAB") 'aj-toggle-fold)

;;ido
;; (require 'ido)
;; (ido-mode t)
;; (setq ido-save-directory-list-file "~/.emacs.d/.ido.last")
;; (setq ido-enable-flex-matching t)
;; (setq ido-use-filename-at-point 'guess)
;; (setq ido-show-dot-for-dired t)
;; (setq ido-default-buffer-method 'selected-window)
;; 
(require 'tramp)
(setq tramp-default-method "ssh")

;;设置有用的个人信息,这在很多地方有用。
(setq user-full-name "xTpx")
(setq user-mail-address "timepower@live.it")

;;去掉 Emacs 和 gnus 启动时的引导界面
(setq inhibit-startup-message t)
(setq gnus-inhibit-startup-message t)

;; 标题栏显示文件路径
(setq frame-title-format
      '("%S" (buffer-file-name "%f"
							   (dired-directory dired-directory "%b"))))

;; Debug
;;(setq debug-on-error t)

;;*scratch* buffer
(setq initial-major-mode 'text-mode)
(setq initial-scratch-message "Hello Emacs ^_^")

;; 去掉工具栏
(tool-bar-mode -1)

;;去掉菜单栏
(menu-bar-mode -1)

;; 去掉滚动栏
(scroll-bar-mode -1)

;; 显示列号
;; (global-linum-mode t)
(global-nlinum-mode t)


;; Highlight Line
(global-hl-line-mode)

;; 显示括号匹配
(show-paren-mode t)
;;(setq show-paren-style 'parentheses)

;; 默认显示 80 列就换行
(setq default-fill-column 80)
;; (setq refill-mode t)

;; 显示时间，格式如下
;; (display-time-mode 1)
;; (setq display-time-24hr-format t)
;; (setq display-time-day-and-date t)

;;光标靠近鼠标指针时，让鼠标指针自动让开，别挡住视线。很好玩阿，这个功能
(mouse-avoidance-mode 'animate)

;; scroll-margin 5 靠近屏幕边沿 3 行时开始滚动
(setq scroll-margin 5
      scroll-conservatively 10000)

;; 高亮显示选中文本
(transient-mark-mode t)

(set-frame-font "Ubuntu Mono 12" nil t)

;; Chinese Font
(set-fontset-font "fontset-default" 'han '("冬青黑体简体中文"))
(setq face-font-rescale-alist '(("冬青黑体简体中文" . 1.0) ("Microsoft Yahei" . 1.0)))
;; 
(global-font-lock-mode t);语法高亮

(auto-image-file-mode t);打开图片显示功能

(fset 'yes-or-no-p 'y-or-n-p);以 y/n 代表 yes/no

;; 按下 C-x k 立即关闭掉当前的 buffer  
(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; 回车缩进
(global-set-key "\C-m" 'newline-and-indent)

;; Open Eshell
(global-set-key [f9] 'eshell)
;; Eshell Clear
(defun eshell/clear ()
  "Clear the eshell buffer."
  (let ((inhibit-read-only t))
    (erase-buffer)
    (eshell-send-input)))

;; Ansi-term
(global-set-key [f8] 'ansi-term)
(add-hook 'term-mode-hook (lambda()
							(yas-minor-mode -1)))
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
;; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; EWW Bookmarks List
(global-set-key (kbd "C-c b") 'eww-list-bookmarks)

;; 设置默认 tab 宽度
(setq-default indent-tabs-mode nil)
(setq default-tab-width 4)
(setq tab-width 4) ; or any other preferred value
(defvaralias 'c-basic-offset 'tab-width)
(defvaralias 'cperl-indent-level 'tab-width)

;;(loop for x downfrom 40 to 1 do
;;    (setq tab-stop-list (cons (* x 4) tab-stop-list)))

;;M-n/p 移动本文
;; (global-set-key (kbd "M-n") 'scroll-up-line)
;; (global-set-key (kbd "M-p") 'scroll-down-line)
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
;; (global-set-key (kbd "M-n") 'hold-line-scroll-up)
;; (global-set-key (kbd "M-p") 'hold-line-scroll-down)

;; Add a line next current like IDEA"
(defun newline-next-current()
  (interactive)
  (prog1 (end-of-line)
	(newline-and-indent)))
(global-set-key (kbd "C-<return>") 'newline-next-current)

;; newline-table 实现 IDEA 的回车自动对齐功能
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

;; move line up
(defun move-line-up ()
  (interactive)
  (transpose-lines 1)
  (previous-line 2))
(global-set-key (kbd "C-c p") 'move-line-up)
;; move line down
(defun move-line-down ()
  (interactive)
  (next-line 1)
  (transpose-lines 1)
  (previous-line 1))
(global-set-key (kbd "C-c n") 'move-line-down)
;; Diable backup file
(setq make-backup-files nil)

;; ORG-MODE
;; 自定义 org-to-html 转换格式, C-h v org-html-postamble{format}.
(setq org-html-postamble t)
(setq org-html-postamble-format
      '(("en" "<p class=\"author\">Author: %a </p>\n<p class=\"date\">Date: %T</p>\n<p class=\"creator\">%c</p>\n<p class=\"validation\">%v</p>")))
;; (defcustom org-html-postamble-format
;;   '(("en" "<p class=\"author\">Author: %a (%e)</p>
;; <p class=\"date\">Last updated: %d</p>
;; <p class=\"creator\">%c</p>")))

;; (setq org-html-postamble-format
;;       '(("en" "<p class=\"author\">Author: %e</p>
;; <p class=\"date\">Last Updated: %d</p>
;; <p class=\"postamble\"> Created by %c </p>")))

;; (defadvice org-html-paragraph (before org-html-paragraph-advice
;;                                       (paragraph contents info) activate)
;;   "Join consecutive Chinese lines into a single long line without
;; unwanted space when exporting org-mode to html."
;;   (let* ((origin-contents (ad-get-arg 1))
;;          (fix-regexp "[[:multibyte:]]")
;;          (fixed-contents
;;           (replace-regexp-in-string
;;            (concat
;;             "\\(" fix-regexp "\\) *\n *\\(" fix-regexp "\\)") "\\1\\2" origin-contents)))

;;     (ad-set-arg 1 fixed-contents)))

;; 去除 Org 导出的 HTML 中的多余的空格
(defadvice org-html-paragraph (before org-html-paragraph-advice
                                      (paragraph contents info) activate)
  "Join consecutive Chinese lines into a single long line without
unwanted space when exporting org-mode to html."
  (let* ((origin-contents (ad-get-arg 1))
         (fix-regexp "[[:multibyte:]]")
         (fixed-contents
          (replace-regexp-in-string
           (concat
            "\\(" fix-regexp "\\) *\n *\\(" fix-regexp "\\)") "\\1\\2" origin-contents)))

    (ad-set-arg 1 fixed-contents)))

(defun gtd ()
  (interactive)
  (find-file "~/Dropbox/org-mode/todo.org"))

;; Steam Get Keys
;; (defun all-urls-in-buffer ()
;;   (interactive)
;;   (pop-to-buffer (s-match-strings-all "ab." "abXabY") "test" "test"))

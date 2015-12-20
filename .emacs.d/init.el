(require 'package)
(add-to-list 'package-archives'("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)


(add-to-list 'load-path "~/ドキュメント/dotfiles/.emacs.d/elisp/")


;;auto-complete
(require 'auto-complete-config)
(ac-config-default)

;;markdown
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.markdown" . markdown-mode) auto-mode-alist))

;;rust
(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

;;haskell
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;;startup
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
;;menu bar
(menu-bar-mode 0)
;;scroll
(setq scroll-conservatively 1)
;;backup file
(setq auto-save-default nil)
(setq make-backup-files nil)
;;indent & tab
(setq-default c-basic-offset 8
	      tab-width 8
	      indent-tabs-mode t)
;;()
(show-paren-mode t)

;;hiline
(defface hlline-face
  '((((class color)
      (background dark))
     (:background "color-238"))
    (((class color)
      (background light))
     (:background "#828282"))
    (t
     ()))
  "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
(global-hl-line-mode)

;;tab
(setq-default indent-tabs-mode nil)
;;powerline
(defun git-branch-mode-line ()
  (let* ((branch (replace-regexp-in-string
                  "[\r\n]+\\'" ""
                  (shell-command-to-string "git symbolic-ref -q HEAD")))
         (mode-line-str (if (string-match "^refs/heads/" branch)
                          (format "  %s " (substring branch 11)) "")))
    (propertize mode-line-str 'face 'mode-line-4-fg)))

(line-number-mode t)
(column-number-mode t)
(setq-default mode-line-format '(
  (:propertize " %m "           face mode-line-1-fg)
  (:propertize ""              face mode-line-1-fg)
  (:propertize minor-mode-alist face mode-line-1-fg)
  (:propertize " "              face mode-line-1-fg)
  (:propertize ""              face mode-line-1-bg)
  (:propertize " %b "           face mode-line-3-fg)
  (:propertize ""              face mode-line-3-bg)
  (:eval (git-branch-mode-line))
  (:propertize " %+  %Z "      face mode-line-4-fg)
  (:propertize ""              face mode-line-4-bg)
  (:propertize " %p "           face mode-line-2-fg)
  (:propertize ""              face mode-line-5-bg)
  (:propertize "  "            face mode-line-5-fg)
  (:propertize "%l"             face mode-line-6-fg)
  (:propertize ":%c"            face mode-line-5-fg)))

(set-face-attribute 'mode-line nil
  :foreground "color-238" :background "color-234" :box nil)
(set-face-attribute 'mode-line-inactive nil
  :foreground "color-238" :background "color-234" :box nil)
(defun make/set-face (face-name fg-color bg-color weight)
  (make-face face-name)
  (set-face-attribute face-name nil
    :foreground fg-color :background bg-color :box nil :weight weight))
(make/set-face 'mode-line-1-fg "color-238" "color-248" 'normal)
(make/set-face 'mode-line-1-bg "color-248" "color-238" 'normal)
(make/set-face 'mode-line-2-fg "color-238" "color-248" 'normal)
(make/set-face 'mode-line-3-fg "color-248" "color-238" 'normal)
(make/set-face 'mode-line-3-bg "color-238" "color-248" 'normal)
(make/set-face 'mode-line-4-fg "color-238" "color-248" 'normal)
(make/set-face 'mode-line-4-bg "color-248" "color-248" 'normal)
(make/set-face 'mode-line-5-fg "color-248" "color-234" 'normal)
(make/set-face 'mode-line-5-bg "color-248" "color-234" 'normal)
(make/set-face 'mode-line-6-fg "color-248" "color-234" 'normal)

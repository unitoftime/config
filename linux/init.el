;; ----------------- Graphical ----------------------

;; turn off the tool bar

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; ----------------- Environment --------------------
;; load emacs 24's package system. Add MELPA repository.
;(setq package-enable-at-startup nil)
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
   '("melpa" . "http://melpa.milkbox.net/packages/")
   t))

(setq ring-bell-function 'ignore)

(tool-bar-mode -1)
;; turn off help screen
(setq inhibit-startup-screen t)
;;turn on line numbers
(global-linum-mode t)

;; whitespace-mode stuff
(require 'whitespace)
(setq whitespace-line-column 100)
(setq whitespace-style '(face trailing tabs lines-tail))
;;(setq whitespace-style '(face lines-tail))
(setq whitespace-line "font-lock-warning-face")
(global-whitespace-mode t)

;; ------------------ Bindings ----------------------

;; re-bind buffer-list to buffer-menu
;(global-set-key "\C-x\C-b" 'ibuffer)

;; make it easy to change between buffers
(global-set-key "\M-[" 'previous-multiframe-window)
(global-set-key "\M-]" 'next-multiframe-window)

(define-key global-map (kbd "C-j") 'ace-jump-mode)

;;Disable backups and autosaves
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Org mode
(setq org-log-done 'time)

;; display a list of recent files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 16)
;(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; God Mode
(require 'god-mode)
(global-set-key (kbd "M-i") 'god-mode-all)
(define-key god-local-mode-map (kbd "i") 'god-mode-all)

; Exempt buffers
(setq god-exempt-major-modes nil)
(setq god-exempt-predicates nil)

; Cursor change
(defun my-update-cursor ()
  (setq cursor-type (if (or god-local-mode buffer-read-only)
                        'hollow
                      'box)))

(add-hook 'god-mode-enabled-hook 'my-update-cursor)
(add-hook 'god-mode-disabled-hook 'my-update-cursor)

;; Helm Mode Bindings
;(helm-mode 1)
(global-set-key "\C-x\ \C-r" 'helm-recentf)
;(global-set-key "\C-x\C-b" 'helm-locate)
(global-set-key "\C-x\C-b" 'helm-mini)

;; Magit bindings
(global-set-key "\C-x\ g" 'magit-status)

;; Dumb Jump Bindings
(global-set-key "\M-." 'dumb-jump-go)
(global-set-key "\M-," 'dumb-jump-back)

;; Recompile binding
(global-set-key "\C-c\ m" 'recompile)
(setq compilation-auto-jump-to-first-error nil)
(setq compilation-scroll-output 1) ;;Follow-mode

;; Buffer timer
(defun work-timer ()
  (interactive)
  (add-to-list 'load-path "~/.emacs.d/buffer-timer/")
  (load "buffer-timer.el")
  (require 'buffer-timer)

  (setq buffer-timer-regexp-master-list
        '(
          ("idle" .
           (("generic" .      "^\\*idle\\*")
            ("generic2" .     "^\\*idle-2\\*")
            ("minibuf" .      "^ \\*Minibuf-.*")))
          ("work" .
           (("FallenOrb" .
             (("code" .       "/src/gitlab.com/fallen/.*\\(go\\)$")
              ("generic" .    "/src/gitlab.com/fallen/")))
            )
           )))
  )

;; Aliases
(defalias 'rs 'replace-string)

;; default to use only spaces
(setq-default indent-tabs-mode nil)

;; avoid accidental closing
(defun ask-before-closing ()
  "Ask whether or not to close, and then close if y was pressed"
  (interactive)
  (if (y-or-n-p (format "Are you sure you want to exit Emacs? "))
      (if (< emacs-major-version 22)
          (save-buffers-kill-terminal)
        (save-buffers-kill-emacs))
    (message "Canceled exit")))

;(when window-system
(global-set-key (kbd "C-x C-c") 'ask-before-closing);)

;; omit uninteresting files from dired
(require 'dired-x)
(setq-default dired-omit-files-p t)
(setq dired-omit-files
      (concat dired-omit-files "\\|^\\..+$"))

(put 'erase-buffer 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (tango-dark)))
 '(package-selected-packages
   (quote
    (ace-jump-mode dumb-jump helm haskell-mode magit go-mode)))
 '(tool-bar-mode nil))

;;indents as 2 spaces
(setq default-tab-width 2)
(add-hook 'go-mode-hook
          (lambda ()
            (setq indent-tabs-mode 1)
            (setq tab-width 2)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-to-list 'same-window-buffer-names "*compilation*")

(add-to-list 'auto-mode-alist '("\\.cppm\\'" . c++-mode))


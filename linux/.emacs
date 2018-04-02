;; ----------------- Graphical ----------------------

;; turn off the tool bar

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(tool-bar-mode -1)
;; turn off help screen
(setq inhibit-startup-screen t)
;;turn on line numbers
(global-linum-mode t)

;;indents as 2 spaces
(setq default-tab-width 2)

;; whitespace-mode stuff
(require 'whitespace)
;(setq whitespace-style '(face trailing tabs lines-tail))
(setq whitespace-style '(face lines-tail))
(setq whitespace-line "font-lock-warning-face")
(global-whitespace-mode t)

;; ------------------ Bindings ----------------------

;; re-bind buffer-list to buffer-menu
(global-set-key "\C-x\C-b" 'ibuffer)

;; make it easy to change between buffers
(global-set-key "\M-[" 'previous-multiframe-window)
(global-set-key "\M-]" 'next-multiframe-window)

;; ----------------- Environment --------------------
;; load emacs 24's package system. Add MELPA repository.
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
   '("melpa" . "http://melpa.milkbox.net/packages/")
   t))

;;Disable backups and autosaves
(setq make-backup-files nil)
(setq auto-save-default nil)

;; display a list of recent files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 16)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

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
 '(custom-enabled-themes (quote (misterioso)))
 '(package-selected-packages (quote (go-mode)))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Noto Mono" :foundry "GOOG" :slant normal :weight normal :height 113 :width normal)))))

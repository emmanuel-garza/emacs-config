;; Window
(add-to-list 'default-frame-alist '(height . 24))
(add-to-list 'default-frame-alist '(width . 80))

;; Problem installing treemacs
;; (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

;; This is if there's problem compiling packages
;; Try to avoid it since then the packages don't have to be signed
;; (setq package-check-signature 'nil)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)


;; Path to look for plug-ins
(add-to-list 'load-path "~/.emacs.d/lisp")

;; MELPA packages
(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))


;; To make tramp mode faster
(setq tramp-verbose 2)

(setq vc-ignore-dir-regexp
                (format "\\(%s\\)\\|\\(%s\\)"
                        vc-ignore-dir-regexp
                        tramp-file-name-regexp))


;; Latex
;;(add-to-list 'auto-mode-alist '("\\.tex\\'" . plain-TeX-mode))
;;(setq TeX-global-PDF-mode t)
;;(setq tex-run-command "pdflatex")


;; Spellcheck to text mode ----------;;

;; (require 'langtool)
;; (setq langtool-language-tool-jar "/snap/bin/languagetool"
;;       langtool-mother-tongue "en"
;;       langtool-disabled-rules '("WHITESPACE_RULE"
;;                                 "EN_UNPAIRED_BRACKETS"
;;                                 "COMMA_PARENTHESIS_WHITESPACE"
;;                                 "EN_QUOTES"))

;; Use hunspell instead of aspell?
;; (when (executable-find "hunspell")
;;   (setq-default ispell-program-name "hunspell")
;;   (setq ispell-really-hunspell t))


(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))
(dolist (hook '(change-log-mode-hook log-edit-mode-hook))
  (add-hook hook (lambda () (flyspell-mode -1))))

;; Run a scan at the begining
;; (add-hook 'text-mode-hook #'flyspell-mode)
;; (add-hook 'flyspell-mode-hook #'flyspell-local-vars)
;; (defun flyspell-local-vars ()
;;   (add-hook 'hack-local-variables-hook #'flyspell-buffer))

;; To avoid slowdown
(setq flyspell-issue-message-flag nil)

;;-----------------------------------




(add-to-list 'auto-mode-alist '("\\.common\\'" . makefile-gmake-mode))

;; For LAtex-----------------------
;; Only change sectioning colour
(setq font-latex-fontify-sectioning 'color)
;; super-/sub-script on baseline
(setq font-latex-script-display (quote (nil)))
;; Do not change super-/sub-script font
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ubuntu Mono" :foundry "unknown" :slant normal :weight normal :height 113 :width normal))))
 '(font-latex-sectioning-2-face ((t (:foreground "yellow"))))
 '(font-latex-sectioning-3-face ((t (:foreground "yellow"))))
 '(font-latex-sedate-face ((t (:foreground "red"))))
 '(font-latex-subscript-face ((t nil)) t)
 '(font-latex-superscript-face ((t nil)) t)
 '(font-lock-comment-face ((t (:foreground "dark orange"))))
 '(hl-line ((t (:background "gray13")))))
;; Exclude bold/italic from keywords
(setq font-latex-deactivated-keyword-classes
      '("italic-command" "bold-command" "italic-declaration" "bold-declaration"))
;;;-------------------------------

;; For remote files?
(setq tramp-mode t)

(defun revert-all-file-buffers ()
  "Refresh all open file buffers without confirmation.
Buffers in modified (not yet saved) state in emacs will not be reverted. They
will be reverted though if they were modified outside emacs.
Buffers visiting files which do not exist any more or are no longer readable
will be killed."
  (interactive)
  (dolist (buf (buffer-list))
    (let ((filename (buffer-file-name buf)))
      ;; Revert only buffers containing files, which are not modified;
      ;; do not try to revert non-file buffers like *Messages*.
      (when (and filename
                 (not (buffer-modified-p buf)))
        (if (file-readable-p filename)
            ;; If the file exists and is readable, revert the buffer.
            (with-current-buffer buf
              (revert-buffer :ignore-auto :noconfirm :preserve-modes))
          ;; Otherwise, kill the buffer.
          (let (kill-buffer-query-functions) ; No query done when killing buffer
            (kill-buffer buf)
            (message "Killed non-existing/unreadable file buffer: %s" filename))))))
  (message "Finished reverting buffers containing unmodified files."))

;; prevent silly initial splash screen
(setq inhibit-splash-screen t)

;; Highlight mode
(global-hl-line-mode +1)
(set-face-background 'hl-line "#f2f2f2")
(set-face-foreground 'highlight nil)
(set-face-foreground 'hl-line nil)

;; Parameter files
(add-to-list 'auto-mode-alist '("\\.prm\\'" . f90-mode))

;; In search ignore line breaks
(setq isearch-lax-whitespace t)
(setq isearch-regexp-lax-whitespace t)
(setq search-whitespace-regexp "[ \t\r\n]+")





;; Comments
(global-set-key (kbd "C-c c") 'comment-region)
(global-set-key (kbd "C-c u") 'uncomment-region)


;; Neotree
;;(add-to-list 'load-path "/home/emmanuel/Software/neotree")
;;(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
;;(setq neo-smart-open t)

;; Move between windows
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-x <right>") 'windmove-right)

;; remove backup files
(setq make-backup-files nil)

;; Changes from John's .el
(require 'fill-column-indicator)
;; (setq fci-rule-width 1)
;; (setq fci-rule-column 80)
;; (setq fci-rule-color "yellow")
 (setq-default fill-column 80)
(add-hook 'after-change-major-mode-hook 'fci-mode)
(add-hook 'fci-mode-hook 'toggle-truncate-lines)


;; (set 'global-visual-line-mode t)

;;(add-hook 'f90-mode-hook 'fci-mode)
;; (define-globalized-minor-mode my-global-fci-mode fci-mode turn-on-fci-mode)
;; (my-global-fci-mode 1)


;; (setq-default
;;  whitespace-line-column 80
;;  whitespace-style       '(face lines-tail))
;; (add-hook 'f90-mode-hook #'whitespace-mode)


;; (setq-default truncate-lines 0)


;; This was slowing stuff in the terminal
;; (define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
;; (global-fci-mode 1)


;; Enable Ruler mode
;; (add-hook 'window-configuration-change-hook (lambda () (ruler-mode 1)))

;; Enable mouse support
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] '(lambda ()
                              (interactive)
                              (scroll-down 1)))
  (global-set-key [mouse-5] '(lambda ()
                              (interactive)
                              (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t)

  ;; Use line numbers
  (defun linum-format-func (line)
    (let ((w (length (number-to-string (count-lines (point-min) (point-max))))))
      (propertize (format (format "%%%dd " w) line) 'face 'linum)))
  (setq linum-format 'linum-format-func)
  (global-linum-mode 1)
)

;; Linum
(global-linum-mode 1)


;; MATLAB Mode ===========================================================
(autoload 'matlab-mode "matlab.el" "Enter Matlab mode." t)
(setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))
(autoload 'matlab-shell "matlab" "Interactive Matlab mode." t)

;; User Level customizations (You need not use them all):
;; (setq matlab-indent-function t); if you want function bodies indented
(setq matlab-verify-on-save-flag nil) ; turn off auto-verify on save
(defun my-matlab-mode-hook ()
  (setq fill-column 80)); where auto-fill should wrap
(add-hook 'matlab-mode-hook 'my-matlab-mode-hook)
(defun my-matlab-shell-mode-hook ()
  '())
(add-hook 'matlab-shell-mode-hook 'my-matlab-shell-mode-hook)

;; Indenting 
(defcustom matlab-arg1-max-indent-length 15
  "*The maximum length to indent when indenting past arg1.
If arg1 is exceptionally long, then only this number of characters
will be indented beyond the open paren starting the parameter list.")


;; Indents
;; (defcustom matlab-maximum-indents '(;; = is a convenience. Don't go too far
;; 				    (?= . (  . 4))
;; 				    ;; Fns should provide hard limits
;; 				    (?\( . 50)
;; 				    ;; Matrix/Cell arrays
;; 				    (?\[ . 20)
;; 				    (?\{ . 20))
;;   "Alist of maximum indentations when lining up code.
;; Each element is of the form (CHAR . INDENT) where char is a character
;; the indent engine is using, and INDENT is the maximum indentation
;; allowed.  Indent could be of the form (MAXIMUM . INDENT), where
;; MAXIMUM is the maximum allowed calculated indent, and INDENT is the
;; amount to use if MAXIMUM is reached.")


;; syntax table -> Used for indents that ain't too crazy
(defvar matlab-mode-syntax-table
  (let ((st (make-syntax-table (standard-syntax-table))))
    (modify-syntax-entry ?_  "_" st)
    (modify-syntax-entry ?%  "<" st)
    (modify-syntax-entry ?\n ">" st)
    (modify-syntax-entry ?\\ "." st)
    (modify-syntax-entry ?\t " " st)
    (modify-syntax-entry ?+  "." st)
    (modify-syntax-entry ?-  "." st)
    (modify-syntax-entry ?*  "." st)
    (modify-syntax-entry ?'  "." st)
    (modify-syntax-entry ?/  "." st)
    (modify-syntax-entry ?=  "." st)
    (modify-syntax-entry ?<  "." st)
    (modify-syntax-entry ?>  "." st)
    (modify-syntax-entry ?&  "." st)
    (modify-syntax-entry ?|  "." st)
    ;;(modify-syntax-entry ?=  "." st)
    ;;(modify-syntax-entry ?\(  "." st) 
    ;;(modify-syntax-entry ?\{  "." st)
    ;;(modify-syntax-entry ?\[  "." st)
    st)
  "The syntax table used in `matlab-mode' buffers.")


;; To kill dired buffers
(defun kill-dired-buffers ()
	 (interactive)
	 (mapc (lambda (buffer) 
           (when (eq 'dired-mode (buffer-local-value 'major-mode buffer)) 
             (kill-buffer buffer))) 
         (buffer-list)))

(put 'upcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (tango-dark)))
 '(custom-safe-themes
   (quote
    ("93a0885d5f46d2aeac12bf6be1754faa7d5e28b27926b8aa812840fe7d0b7983" "6b289bab28a7e511f9c54496be647dc60f5bd8f9917c9495978762b99d8c96a0" "a3fa4abaf08cc169b61dea8f6df1bbe4123ec1d2afeb01c17e11fdc31fc66379" "356e5cbe0874b444263f3e1f9fffd4ae4c82c1b07fe085ba26e2a6d332db34dd" default)))
 '(package-selected-packages
   (quote
    (langtool highlight-indentation all-the-icons-ivy treemacs-magit treemacs-icons-dired treemacs-projectile treemacs-evil treemacs use-package solaire-mode hydra pfuture ace-window ht f dash doom-themes auctex cuda-mode)))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil))









;; (load "centaur-tabs")
(require 'centaur-tabs)
(centaur-tabs-mode t)
(global-set-key (kbd "C-<prior>")  'centaur-tabs-backward)
(global-set-key (kbd "C-<next>") 'centaur-tabs-forward)


(add-to-list 'load-path "~/.emacs.d/lisp/treemacs/")
;; (require 'treemacs)

(use-package treemacs
  :ensure t
  :defer t
  :init
  (with-eval-after-load 'winum
    (define-key winum-keymap (kbd "M-0") #'treemacs-select-window))
  :config
  (progn
    (setq treemacs-collapse-dirs                 (if (treemacs--find-python3) 3 0)
          treemacs-deferred-git-apply-delay      0.5
          treemacs-display-in-side-window        t
          treemacs-eldoc-display                 t
          treemacs-file-event-delay              5000
          treemacs-file-follow-delay             0.2
          treemacs-follow-after-init             t
          treemacs-git-command-pipe              ""
          treemacs-goto-tag-strategy             'refetch-index
          treemacs-indentation                   2
          treemacs-indentation-string            " "
          treemacs-is-never-other-window         nil
          treemacs-max-git-entries               5000
          treemacs-missing-project-action        'ask
          treemacs-no-png-images                 nil
          treemacs-no-delete-other-windows       t
          treemacs-project-follow-cleanup        nil
          treemacs-persist-file                  (expand-file-name ".cache/treemacs-persist" user-emacs-directory)
          treemacs-position                      'left
          treemacs-recenter-distance             0.1
          treemacs-recenter-after-file-follow    nil
          treemacs-recenter-after-tag-follow     nil
          treemacs-recenter-after-project-jump   'always
          treemacs-recenter-after-project-expand 'on-distance
          treemacs-show-cursor                   nil
          treemacs-show-hidden-files             t
          treemacs-silent-filewatch              nil
          treemacs-silent-refresh                nil
          treemacs-sorting                       'alphabetic-desc
          treemacs-space-between-root-nodes      t
          treemacs-tag-follow-cleanup            t
          treemacs-tag-follow-delay              1.5
          treemacs-width                         35)

    ;; The default width and height of the icons is 22 pixels. If you are
    ;; using a Hi-DPI display, uncomment this to double the icon size.
    (treemacs-resize-icons 20)


        
    (treemacs-follow-mode t)
    ;; (treemacs-filewatch-mode t)
    (treemacs-fringe-indicator-mode t)
    (pcase (cons (not (null (executable-find "git")))
                 (not (null (treemacs--find-python3))))
      (`(t . t)
       (treemacs-git-mode 'deferred))
      (`(t . _)
       (treemacs-git-mode 'simple))))
  :bind
  (:map global-map
        ("M-0"       . treemacs-select-window)
        ("C-x t 1"   . treemacs-delete-other-windows)
        ("C-x t t"   . treemacs)
        ("C-x t B"   . treemacs-bookmark)
        ("C-x t C-t" . treemacs-find-file)
        ("C-x t M-t" . treemacs-find-tag)))

(use-package treemacs-evil
  :after treemacs evil
  :ensure t)

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

(use-package treemacs-icons-dired
  :after treemacs dired
  :ensure t
  :config (treemacs-icons-dired-mode))

(use-package treemacs-magit
  :after treemacs magit
  :ensure t)





;; (use-package solaire-mode
;;     :hook (((change-major-mode after-revert ediff-prepare-buffer) . turn-on-solaire-mode)
;;            (minibuffer-setup . solaire-mode-in-minibuffer))
;;     :config
;;     (solaire-global-mode)
;;     (solaire-mode-swap-bg))




(require 'doom-themes)

;; Global settings (defaults)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled

;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
;; may have their own settings.
(load-theme 'doom-one t)

;; Enable flashing mode-line on errors
(doom-themes-visual-bell-config)

;; Enable custom neotree theme (all-the-icons must be installed!)
;; (doom-themes-neotree-config)
;; or for treemacs users
;; (doom-themes-treemacs-config)

;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)


;; Set my theme
(load-theme 'doom-tomorrow-night)



;; Show column number
(setq column-number-mode t)

;; Disable the Menu Bar
(menu-bar-mode -1 )

;; Start treemacs at the begining
;;(treemacs)

;; Otherwise sometimes emacs slows down while refreshing
(setq treemacs-filewatch-mode 'nil)


;; (add-to-list 'default-frame-alist '(height . 45))
;; (add-to-list 'default-frame-alist '(width . 150))


;; For highlight-indentation
(use-package highlight-indentation
  :init
  (progn
    (defun set-hl-indent-color ()
      (set-face-background 'highlight-indentation-face "#530168"))
    (add-hook 'python-mode-hook 'highlight-indentation-mode)
    (add-hook 'python-mode-hook 'set-hl-indent-color)))

(set-face-background 'highlight-indentation-face "#530168")
(set-face-background 'highlight-indentation-current-column-face "#79AF92")
(global-set-key (kbd "C-h C-l") 'highlight-indentation-mode)


;; So that the text doesn't keep showing
;;(set-default 'truncate-lines 0)

;;(setq-default truncate-lines 0)


;; To search for repeated words
(defun the-the ()
       "Search forward for for a duplicated word."
       (interactive)
       (message "Searching for for duplicated words ...")
       (push-mark)
       ;; This regexp is not perfect
       ;; but is fairly good over all:
       (if (re-search-forward
            "\\b\\([^@ \n\t]+\\)[ \n\t]+\\1\\b" nil 'move)
           (message "Found duplicated word.")
         (message "End of buffer")))
     
     ;; Bind 'the-the' to  C-c \
     (global-set-key "\C-c\\" 'the-the)



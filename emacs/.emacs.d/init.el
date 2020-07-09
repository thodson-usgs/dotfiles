; who am i
(setq user-full-name "Timothy Hodson"
      user-mail-address "thodson@usgs.gov")

;(setenv "LC_CTYPE" "UTF-8")

(cond ((string-equal system-type "windows-nt")
          (setq org-directory "c:/Users/thodson/AppData/Roaming/org/")
       )
      (t
          (setq org-directory "~/org/"))
      )

(setq gc-cons-threshold 50000000)
(setq large-file-warning-threshold 100000000)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(setq package-enable-at-startup nil)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))


;; visual setup
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)
(blink-cursor-mode -1)

;(global-hl-line-mode +1)
;(line-number-mode +1)
;(global-display-line-numbers-mode 1)
(column-number-mode t)
(size-indication-mode t)

; disable startup screen
(setq inhibit-startup-screen t)

; better scrolling
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

;; input
(xterm-mouse-mode -1)

;; backups
; put backup files in the temporary file directory
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


;; Ease of life
(fset 'yes-or-no-p 'y-or-n-p)

; tabs are 4 spaces
(setq-default tab-width 4
              indent-tabs-mode nil)

; clean up whitespaces
(add-hook 'before-save-hook 'whitespace-cleanup)

; reload file if it changes
(global-auto-revert-mode)

; set theme
(use-package all-the-icons
  :if window-system
  :ensure t)

(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t)
  (doom-themes-visual-bell-config))

(use-package smart-mode-line-powerline-theme
  :ensure t)

(use-package smart-mode-line
  :ensure t
  :config
  (setq sml/theme 'powerline)
  (add-hook 'after-init-hook 'sml/setup))
; load org-mode config

(use-package evil
  :ensure t)
(evil-mode 1)

(use-package undo-tree
  :ensure t
  :config
  (setq undo-tree-visualizer-timestamps t))

(global-undo-tree-mode)

;; Autocomplete and syntax checking
(use-package yasnippet
  :ensure t
  :commands (yas-minor-mode) ; autoload `yasnippet' when `yas-minor-mode' is called
                                        ; using any means: via a hook or by user
                                        ; Feel free to add more commands to this
                                        ; list to suit your needs.
  :init ; stuff to do before requiring the package
  (progn
    (add-hook 'prog-mode-hook #'yas-minor-mode)) ;load yas when entering any programming mode
  :config ; stuff to do after requiring the package
  (progn
    (yas-reload-all)))

(use-package yasnippet-snippets
  :ensure t)

(use-package company
  :ensure t
  :diminish company-mode
  :config
  (add-hook 'after-init-hook #'global-company-mode)
  (define-key company-active-map (kbd "M-h") 'company-show-doc-buffer)
  ; use tab to complete instead of return
  (define-key company-active-map [return] nil)
  (define-key company-active-map [tab] 'company-complete-common)
  (define-key company-active-map (kbd "TAB") 'company-complete-common)
  (define-key company-active-map (kbd "M-TAB") 'company-complete-selection)
  ; misc
  (setq company-selection-wrap-around t
        company-tooltip-align-annotations t
        company-idle-delay 0.36
        company-minimum-prefix-length 2
        company-tooltip-limit 10)
  )


(use-package flycheck
  :ensure t
  :diminish flycheck-mode
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

;; project setup
(use-package magit
  :ensure t
  :bind (("C-M-g" . magit-status)))

(use-package helm
  :ensure t
  :defer 2
  :bind
  ("M-x" . helm-M-x)
  ("C-x C-f" . helm-find-files)
  ("M-y" . helm-show-kill-ring)
  ("C-x b" . helm-mini)
  :config
  (require 'helm-config)
  (helm-mode 1)
  (setq helm-split-window-inside-p t)
  (setq helm-move-to-line-cycle-in-source nil) ; t
  (setq helm-autoresize-max-height 0)
  (setq helm-autoresize-min-height 20)
  (helm-autoresize-mode 1)
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
  (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
)

(use-package projectile
  :ensure t
  :diminish projectile-mode
  :bind
  (("C-c p f" . helm-projectile-find-file)
   ("C-c p p" . helm-projectile-switch-project)
   ("C-c p s" . projectile-save-project-buffers))
  :config
  (projectile-mode +1)
)

;; git gutter
(use-package git-gutter+
  :ensure t
  :init (global-git-gutter+-mode)
  :config (progn
            (define-key git-gutter+-mode-map (kbd "C-x n") 'git-gutter+-next-hunk)
            (define-key git-gutter+-mode-map (kbd "C-x p") 'git-gutter+-previous-hunk)
            (define-key git-gutter+-mode-map (kbd "C-x v =") 'git-gutter+-show-hunk)
            (define-key git-gutter+-mode-map (kbd "C-x r") 'git-gutter+-revert-hunks)
            (define-key git-gutter+-mode-map (kbd "C-x t") 'git-gutter+-stage-hunks)
            (define-key git-gutter+-mode-map (kbd "C-x c") 'git-gutter+-commit)
            (define-key git-gutter+-mode-map (kbd "C-x C") 'git-gutter+-stage-and-commit)
            (define-key git-gutter+-mode-map (kbd "C-x C-y") 'git-gutter+-stage-and-commit-whole-buffer)
            (define-key git-gutter+-mode-map (kbd "C-x U") 'git-gutter+-unstage-whole-buffer))
  :diminish (git-gutter+-mode . "gg"))
;; Org
;(use-package dot-org
;  :commands my-org-startup
;  :bind* (("M-C"   . jump-to-org-agenda)
;          ("M-m"   . org-smart-capture)
;          ("M-M"   . org-inline-note)
;          ("C-c a" . org-agenda)
;          ("C-c c" . org-capture)
;          ("C-c S" . org-store-link)
;          ("C-c l" . org-insert-link))
;  :config
;  (unless alternate-emacs
;    (run-with-idle-timer 300 t 'jump-to-org-agenda)
;    (my-org-startup))
;  (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
                                        ;  )
(require 'org)
(require 'org-agenda)
;(require 'org-contacts)
(require 'org-bullets)

(add-hook 'org-mode-hook 'org-bullets-mode)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
;(org-agenda-list) ; start in org agenda

(setq org-refile-targets '((org-agenda-files :maxlevel . 3)))
(setq org-refile-use-outline-path t) ;show full hierarchy during refile
(setq org-agenda-files (list "~/org"
                             "~/projects"))

; disable bell function
(setq ring-bell-function 'ignore)

(setq org-startup-indented t)
(transient-mark-mode 1)
(add-hook 'org-mode-hook 'turn-on-auto-fill)


(setq org-todo-keywords
          '((sequence "TODO(t@/@)" "INPROGRESS(i@/@)" "WAITING(w@/@)"
              "VERIFY(v@)" "SOMEDAY(s@/@)" "HOLD(h@/@)" "|"
              "DONE(d@/@)" "DELEGATED(D@/@)" "CANCELED(c@/@)" "NOTDONE(n@/@)")))

(custom-set-variables
 '(org-babel-load-languages (quote ((emacs-lisp . t) (R . t))))
 '(org-confirm-babel-evaluate nil))

(use-package org
  :ensure org-plus-contrib
  ;; Org-mode configuration
  )

(use-package org-contacts
  :ensure nil
  :after org
  )

(use-package org-capture
  :ensure nil
  :after org
  :preface
  (defvar my/org-contacts-template "* %(org-contacts-template-name)
:PROPERTIES:
:ADDRESS: %^{289 Cleveland St. Brooklyn, 11206 NY, USA}
:BIRTHDAY: %^{yyyy-mm-dd}
:EMAIL: %(org-contacts-template-email)
:NOTE: %^{NOTE}
:END:" "Template for org-contacts.")
  :custom
  (org-capture-templates
   `(("c" "Contact" entry (file+headline "~/org/contacts.org" "Friends"),
      my/org-contacts-template
      :empty-lines 1))
   )
)


(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

;; Writing
(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package latex-preview-pane
  :ensure t)

(use-package academic-phrases
  :ensure t)

(use-package biblio
  :ensure t)

(use-package helm-bibtex
  :ensure t
  :config
  (setq helm-bibtex-bibliography "~/org/ref/papers.bib" ;; where your references are stored
        helm-bibtex-library-path "~/org/ref/lib/" ;; where your pdfs etc are stored
        helm-bibtex-notes-path "~/org/ref/papers.org" ;; where your notes are stored
        bibtex-completion-bibliography "~/org/ref/papers.bib" ;; writing completion
        bibtex-completion-notes-path "~/org/ref/papers.org"
        bibtex-completion-library-path "~/org/ref/lib")

        ;bibtex-completion-library-path '("/path1/to/pdfs" "/path2/to/pdfs"))
  (setq bibtex-completion-pdf-symbol "⌘")
  (setq bibtex-completion-notes-symbol "✎")
  ;(setq bibtex-completion-pdf-field "File") ;; use with Jabref
)


;; Reading
(use-package pdf-tools
  :ensure t
  :config
  (pdf-tools-install)
  (setq linum-mode -1)
  (setq-default pdf-view-display-size 'fit-height)
  (setq pdf-annot-activate-created-annotations t)
  (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward)
)

; for some reason this line must be outside use-package tried init and config
(add-hook 'pdf-view-mode-hook (lambda() (linum-mode -1)))

(use-package interleave
  :ensure t)

(use-package org-ref
  :ensure t
  :config
  (setq org-ref-notes-directory "~/org/ref"
        org-ref-bibliography-notes "~/org/ref/papers.org"
        org-ref-default-bibliography '("~/org/ref/papers.bib")
        org-ref-pdf-directory "~/org/ref/lib/")
  )

;; Programming
(use-package ess
  :ensure t
  :config
  (setq ess-style 'RStudio)
  ;(setq ess-indent-with-fancy-comments nil)
)

(use-package elpy
  :ensure t
  :defer t
  :init
  (setq elpy-rpc-virtualenv-path 'current)
  (advice-add 'python-mode :before 'elpy-enable)
  ;; For elpy
  (setq elpy-rpc-python-command "python3")
  ;; For interactive shell
  (setq python-shell-interpreter "ipython3")
 )

(use-package company-jedi
  :ensure t)

(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))

(add-hook 'python-mode-hook 'my/python-mode-hook)


;; Only do this once:
(when nil
  (use-package all-the-icons)
  (all-the-icons-install-fonts 'install-without-asking))

;; neotree --sidebar for project file navigation
(use-package neotree
  :ensure t
  :config
  (global-set-key "\C-x\ d" 'neotree-toggle)
  (setq neo-window-fixed-size nil))

(setq neo-theme 'icons)
;(neotree-refresh)

;; Open it up upon startup.
(neotree-toggle)

;; misc
(global-linum-mode 1) ; display line numbers in margin.
;(setq linum-format "%d")
;(global-visual-line-mode 1) ; 1 for on, 0 for off.


;; start daemon
(require 'server)
(if (not (server-running-p)) (server-start))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" default)))
 '(helm-completion-style (quote emacs))
 '(org-capture-templates
   (quote
    (("c" "Contact" entry
      (file+headline "~/org/contacts.org" "Friends")
      "* %(org-contacts-template-name)
:PROPERTIES:
:ADDRESS: %^{289 Cleveland St. Brooklyn, 11206 NY, USA}
:BIRTHDAY: %^{yyyy-mm-dd}
:EMAIL: %(org-contacts-template-email)
:NOTE: %^{NOTE}
:END:" :empty-lines 1))))
 '(package-selected-packages
   (quote
    (org-ref interleave pdf-tools biblio org-plus-contrib latex-preview-pane markdown-mode academic-phrases company-jedi yasnippet-snippets use-package smart-mode-line-powerline-theme projectile org-bullets neotree magit helm git-gutter+ flycheck evil-org elpy doom-themes all-the-icons))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 )

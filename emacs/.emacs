
;;disable splash screen and startup message
(setq inhibit-startup-message t) 
(setq initial-scratch-message nil)


(menu-bar-mode -1) ;;disable menu bar
(toggle-scroll-bar -1)
(tool-bar-mode -1)    

(defun nolinum ()
  (global-linum-mode 0)
)

(setenv "LC_CTYPE" "UTF-8")

;;enable syntax highlighting
(global-font-lock-mode t)
(transient-mark-mode 1)


(set-keyboard-coding-system nil)
;(setq mac-option-modifier `meta)

(setq scroll-step           1
         scroll-conservatively 10000)

;;
;; Package Archives
;;
(require 'package)
(package-initialize)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

;(package-refresh-contents)


;; Auto install usefull packages
(defun install-if-needed (package)
  (unless (package-installed-p package)
    (package-install package)))



(setq org-return-follows-link t)

(add-hook 'org-mode-hook 'flyspell-mode)
(add-hook 'org-mode-hook 'xterm-mouse-mode)
(add-hook 'org-mode-hook 'nolinum)
;;;
;;; Org Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(add-to-list 'load-path (expand-file-name "~/git/org-mode/lisp"))
;(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))
;(add-to-list 'load-path "~/.emacs.d/org-7.9.2/lisp")
;(require 'org-install)
;(require 'org)
;(load "~/.emacs.d/ess-12.09-1/lisp/ess-site")
;(require 'ess-site)
(setq org-directory "~/org")

;; Startup settings
(setq org-startup-indented t)
(transient-mark-mode 1)

;; Auto fill
(add-hook 'org-mode-hook 'turn-on-auto-fill)
(setq-default fill-column 80)

;; Standard key bindings
(global-font-lock-mode 1)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-cc" 'org-capture)

;; MobileOrg
;(setq org-mobile-directory (concat org-directory "/mobile"))
(setq org-mobile-directory "~/share/Dropbox/mobileorg")
(setq org-mobile-inbox-for-pull (concat org-directory "/index.org"))
;; Babel setup
;;
;; need to fix!!!!
;;
; Some initial langauges we want org-babel to support
;(org-babel-do-load-languages
; 'org-babel-load-languages
; '(
;   (sh . t)
;   (python . t)
;   (R . t)
;   (ruby . t)
;   (ditaa . t)
;   (dot . t)
;   (octave . t)
;   (sqlite . t)
;   (perl . t)
;   ))

;;
;; Capture setup
;(setq org-default-notes-file (concat org-directory "/notes.org"))
(setq org-capture-templates
      '(("t" "todo" entry (file+headline (concat org-directory "/todo.org") "tasks")
             "* TODO %?\n  %i\n")
	("T" "linked-todo" entry (file+headline (concat org-directory "/todo.org") "tasks")
             "* TODO %?\n  %i\n  %a")
        ("n" "note" entry (file+datetree (concat org-directory "/notes.org"))
             "* %?\nEntered on %U\n  %i\n")
        ("N" "linked-note" entry (file+datetree (concat org-diretory "/notes.org"))
             "* %?\nEntered on %U\n  %i\n  %a")))
;;
;; Org Tags

(setq org-tag-alist '(("@work"  . ?w) 
		      ("@home"  . ?h)
		      ;("@computer" . ?c)
		      ("Paul" . ?p)
		      ("Ross"   . ?r)
		      ("Becky"  . ?b)
		      ("code" . ?c)
		      ("water_quality" . ?q)
		      ))
;;
;; Refile setup
; Targets include this file and any file contributing to the agenda - up to 9 levels 
;(setq org-refile-targets (quote ((nil :maxlevel . 9)
;                                 (org-agenda-files :maxlevel . 9))))
(setq org-refile-targets '((org-agenda-files :maxlevel . 3)))
; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)

; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; Use IDO for both buffer and file completion and ido-everywhere to t
(setq org-completion-use-ido t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode (quote both))

;;;; Refile settings
; Exclude DONE state tasks from refile targets
(defun bh/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(setq org-refile-target-verify-function 'bh/verify-refile-target)

;; Tasks setup
; @note; !timestamp; enter/leave; leave triggered iff entered state doesn't log. 
(setq org-todo-keywords  
          '((sequence "TODO(t@/@)" "INPROGRESS(i@/@)" "WAITING(w@/@)" 
		      "VERIFY(v@)" "SOMEDAY(s@/@)" "HOLD(h@/@)" "|" 
		      "DONE(d@/@)" "DELEGATED(D@/@)" "CANCELED(c@/@)" "NOTDONE(n@/@)")))


;; Agenda setup
;;
(setq org-agenda-files (list "~/org" 
			     "~/org/projects"))

;; Mobile Org
;;
;; Set to the location of your Org files on your local system
(setq org-directory "~/org")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/org/flagged.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")

;;;
;;; RSS mode setup
;;;

;;;
;;; ESS setup
;;;
(setq ess-eval-visibly-p nil) ;;turn of echoing inside R


;;;
;;; Mouse support
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
)
;; disable bell function
(setq ring-bell-function 'ignore)

;;
;; Chords
;;

;;
;; MISC
;;
(global-linum-mode 1) ; display line numbers in margin.
(setq linum-format "%d") 
(global-visual-line-mode 1) ; 1 for on, 0 for off.
;(global-hl-line-mode 1) ; turn on highlighting current line
;(set-face-background 'hl-line "#3e4446")
;(set-face-background 'hl-line "#550")

(custom-set-variables
;; custom-set-variables was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
)
(custom-set-faces
;; custom-set-faces was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
'(default ((t (:family "Monaco" :foundry "unknown" :slant normal :weight normal :height 140 :width normal)))))

;;(setq url-proxy-services '(("no_proxy" . "192.168.122.*")
;;                           ("http" . "192.168.122.20:3128")))

;;marmalde package server
(require 'package)
(add-to-list 'package-archives
'("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

;;customized key here
(global-set-key "\C-xf" 'find-file-in-project)
(global-set-key "\C-z" 'undo)

(require 'project-mode)
(project-load-all)
(project-mode 1)

;;theme setting
(setq default-frame-alist (append default-frame-alist
                                  '((foreground-color . "White")
                                    (background-color . "Black")
                                    (cursor-color . "SkyBlue")
)))

;;emms
(setq exec-path (append exec-path '("/opt/local/bin")))
(add-to-list 'load-path "/Users/maxj/dev/sources/gnu/emms/lisp")
(require 'emms-setup)
(require 'emms-player-mplayer)
(emms-standard)
(emms-default-players)

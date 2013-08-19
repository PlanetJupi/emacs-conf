(setq exec-path (append exec-path '("/usr/local/bin")))
(add-to-list 'load-path "/Users/maxj/dev/tools/emacs-w3m-merge")
(require 'w3m)
(defun w3m-browse-url-other-window (url &optional newwin)
  (let ((w3m-pop-up-windows t))
    (if (one-window-p) (split-window))
    (other-window 1)
    (w3m-browse-url url newwin)))



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
'(default ((t (:family "Monaco" :foundry "unknown" :slant normal :weight normal :height 120 :width normal)))))

;;(setq url-proxy-services '(("no_proxy" . "192.168.122.*")
;;                           ("http" . "192.168.122.20:3128")))
(setq default-tab-width 4)
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
                                  '((foreground-color . "Gray")
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
(define-emms-simple-player mplayer '(file url)
      (regexp-opt '(".ogg" ".mp3" ".wav" ".mpg" ".mpeg" ".wmv" ".wma"
                    ".mov" ".avi" ".divx" ".ogm" ".asf" ".mkv" "http://" "mms://"
                    ".rm" ".rmvb" ".mp4" ".flac" ".vob" ".m4a" ".flv" ".ogv" ".pls"))
      "mplayer" "-slave" "-quiet" "-really-quiet" "-fullscreen")

(require 'emms-score)
(emms-score 1)
;; autodetect musci files id3 tags encodeing
(require 'emms-i18n)
;; auto-save and import last playlist
(require 'emms-history)

;; my customizable playlist format
(defun bigclean-emms-info-track-description (track)
  "Return a description of the current track."
  (let ((artist (emms-track-get track 'info-artist))
        (title (emms-track-get track 'info-title))
        (album (emms-track-get track 'info-album))
        (ptime (emms-track-get track 'info-playing-time)))
    (if title 
        (format 
         "%-35s %-40s %-35s %5s:%-5s"
         (if artist artist "")
         (if title title "")
         (if album album "")
         (/ ptime 60)
         (% ptime 60)))))
(setq emms-track-description-function
      'bigclean-emms-info-track-description)

;; format current track,only display title in mode line
(defun bigclean-emms-mode-line-playlist-current ()
  "Return a description of the current track."
  (let* ((track (emms-playlist-current-selected-track))
         (type (emms-track-type track))
         (title (emms-track-get track 'info-title)))
    (format "[ %s ]"
            (cond ((and title)
                   title)))))
(setq emms-mode-line-mode-line-function
      'bigclean-emms-mode-line-playlist-current)

;; global key-map
;; all global keys prefix is C-c e
;; compatible with emms-playlist mode keybindings
;; you can view emms-playlist-mode.el to get details about 
;; emms-playlist mode keys map
;;(global-set-key (kbd "C-c e s") 'emms-stop)
;;(global-set-key (kbd "C-c e P") 'emms-pause)
;;(global-set-key (kbd "C-c e n") 'emms-next)
;;(global-set-key (kbd "C-c e p") 'emms-previous)
;;(global-set-key (kbd "C-c e f") 'emms-show)
;;(global-set-key (kbd "C-c e >") 'emms-seek-forward)
;;(global-set-key (kbd "C-c e <") 'emms-seek-backward)

;; these keys maps were derivations of above keybindings
;;(global-set-key (kbd "C-c e S") 'emms-start)
;;(global-set-key (kbd "C-c e g") 'emms-playlist-mode-go)
;;(global-set-key (kbd "C-c e t") 'emms-play-directory-tree)
;;(global-set-key (kbd "C-c e h") 'emms-shuffle)
;;(global-set-key (kbd "C-c e e") 'emms-play-file)
;;(global-set-key (kbd "C-c e l") 'emms-play-playlist)
;;(global-set-key (kbd "C-c e r") 'emms-toggle-repeat-track)
;;(global-set-key (kbd "C-c e R") 'emms-toggle-repeat-playlist)
;;(global-set-key (kbd "C-c e u") 'emms-score-up-playing)
;;(global-set-key (kbd "C-c e d") 'emms-score-down-playing)
;;(global-set-key (kbd "C-c e o") 'emms-score-show-playing)

;;(global-set-key (kbd "C-c e o") 'emms-score-show-playing)

;; coding settings
(setq emms-info-mp3info-coding-system 'gbk
      emms-cache-file-coding-system 'utf-8
      ;; emms-i18n-default-coding-system '(utf-8 . utf-8)
      )


;;fullscreen

;;(add-to-list 'load-path "/Users/maxj/dev/sources/github/maxframe.el")
;;(require 'maxframe)
;;(setq mf-max-width 1440)  ;; Pixel width of main monitor.
;;(add-hook 'window-setup-hook 'maximize-frame t)



(defun baidu-dictionary (word)
  (w3m-browse-url-other-window (format
                   "http://dict.baidu.com/s?wd=%s"
                   (url-hexify-string word))))

(defun baidu-dictionary-word (word)
  (interactive (list (let* ( (default-entry (thing-at-point 'word))
                             (input (read-string (format "Baidu Dictionary(%s): "
                                                         (if (string= default-entry "")
                                                             ""
                                                           (format " (default `%s')" default-entry))))) )
                      (if (string= input "")
                          (if (string= default-entry "")
                              (error "No arg given")
                            default-entry)
                        input))))
  (baidu-dictionary word))

(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))

(remove-hook 'prog-mode-hook 'esk-turn-on-hl-line-mode)

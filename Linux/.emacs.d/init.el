;; .emacs

;; ■ load-path
(add-to-list 'load-path "~/.emacs.d/site-lisp")

;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)

;; enable visual feedback on selections
;(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

;; default to unified diffs
(setq diff-switches "-u")

;; always end a file with a newline
;(setq require-final-newline 'query)

;;; uncomment for CJK utf-8 support for non-Asian users
;; (require 'un-define)


;; ■ 起動時の画面はいらない
(setq inhibit-startup-message t)

;; ■ 対応する括弧をハイライトさせる
(show-paren-mode t)

;; ■ C-hの有効化 (前削除)
(global-set-key "\C-h" 'delete-backward-char)


;; ■ ツールバーを消す
(tool-bar-mode -1)


;; ■ matlab-mode の設定
(autoload 'matlab-mode "matlab" "Enter Matlab mode." t)
(setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))
(autoload 'matlab-shell "matlab" "Interactive Matlab mode." t)


;; ■ ビープ音を消す
(setq visible-bell t)


;; ■ エラー時の画面のフラッシュを抑制
(setq ring-bell-function 'ignore)


;; ■ バックアップファイルの作成をしない
(setq-default make-backup-files nil)


;; ■ タブ幅変更
(setq-default tab-width 4)

;; ---------------------------------------------------------------------
;;==========================================================
;; ■ yaml-mode の設定 (yaml-mode.el)
;;==========================================================
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))


;; ■ タブブラウザの設定
;; scratch buffer 以外をまとめてタブに表示する
;; グループ化せずに*scratch*以外のタブを表示
(require 'cl)
(when (require 'tabbar nil t)
  (setq tabbar-buffer-groups-function
	(lambda (b) (list "All Buffers")))
  (setq tabbar-buffer-list-function
	(lambda ()
	  (remove-if
	   (lambda(buffer)
	     (find (aref (buffer-name buffer) 0) " *"))
	   (buffer-list))))
  (tabbar-mode))

;; 左に表示されるボタンを無効化
(setq tabbar-home-button-enabled "")
(setq tabbar-scroll-left-button-enabled "")
(setq tabbar-scroll-right-button-enabled "")
(setq tabbar-scroll-left-button-disabled "")
(setq tabbar-scroll-right-button-disabled "")

;; 色設定
(set-face-attribute
 'tabbar-default-face nil
 :background "gray90")			;バー自体の色
(set-face-attribute			;非アクティブなタブ
 'tabbar-unselected-face nil
 :background "gray90"
 :foreground "black"
 :box nil)
(set-face-attribute			;アクティブなタブ
 'tabbar-selected-face nil
 :background "black"
 :foreground "white"
 :box nil)

;; 幅設定
(set-face-attribute
 'tabbar-separator-face nil
 :height 0.7)

;; Firefoxライクなキーバインドに
(global-set-key [(control tab)]       'tabbar-forward)
(global-set-key [(control shift tab)] 'tabbar-backward)


;; ---------------------------------------------------------------------


;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-

;; === 基本設定 ====================================================================
;; load-path
(add-to-list 'load-path "~/.emacs.d/site-lisp")
;; 起動時の画面はいらない
(setq inhibit-startup-message t)
;; ホームディレクトリを初期ディレクトリにする
(cd "~")
;; ツールバーを消す
(tool-bar-mode -1)
;; ビープ音を消す
(setq visible-bell t)
;; エラー時の画面のフラッシュを抑制
(setq ring-bell-function 'ignore)
;; バックアップファイルの作成をしない
(setq-default make-backup-files nil)
;; 検索 (grep-find)
(setq grep-find-command "find . ! -name '*~' -type f -print0 | xargs -0 lgrep -n -Os -Ia ") ; 出力 sjis, 入力 auto
;; 対応する括弧をハイライトさせる
(show-paren-mode t)
;; タブ幅変更
(setq-default tab-width 4)
;; C-hの有効化 (前削除)
(global-set-key "\C-h" 'delete-backward-char)
;; タブの動作変更
;;(add-hook 'text-mode-hook (lambda () (setq indent-line-function 'tab-to-tab-stop)))
;; tsvファイルをtext-modeで開く設定
(setq auto-mode-alist (cons '("\\.tsv\\'" . text-mode) auto-mode-alist))
;; Emacsの起動時のフレームサイズの設定
;;(setq default-frame-alist (append (list '(width . 80) '(height . 30) ) default-frame-alist))

;; 日本語環境
(set-language-environment "Japanese")
;;  Fontの設定 (MigMix 1M Fontの設定)
(set-face-attribute 'fixed-pitch    nil :family "MigMix 1M") ;; 固定等幅フォント
(set-face-attribute 'variable-pitch nil :family "MigMix 1M") ;; 可変幅フォント
(add-to-list 'default-frame-alist '(font . "MigMix 1M-10.5"))
;; 文字コード
(set-selection-coding-system 'utf-16le-dos) ; クリップボード文字化け対策
;; インプットメソッド
(setq default-input-method "W32-IME")
(w32-ime-initialize)
(setq-default w32-ime-mode-line-state-indicator "[--]")
(setq mw32-ime-mode-line-state-indicator "[--]")
(setq w32-ime-mode-line-state-indicator-list
      '("[--]" "[あ]" "[--]"))
(add-hook 'input-method-activate-hook
		  (lambda () (set-cursor-color "firebrick")))
(add-hook 'input-method-inactivate-hook
		  (lambda () (set-cursor-color "orange")))


;; === 拡張設定 ====================================================================
;;==========================================================
;; matlab-mode の設定 (matlab.el)
;;==========================================================
(autoload 'matlab-mode "matlab" "Enter Matlab mode." t)
(setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))
(autoload 'matlab-shell "matlab" "Interactive Matlab mode." t)


;;==========================================================
;; bat-mode の設定 (bat-mode.el)
;;==========================================================
(setq auto-mode-alist 
	  (append 
	   (list (cons "\\.[bB][aA][tT]$" 'bat-mode))
	   ;; For DOS init files
	   (list (cons "CONFIG\\."   'bat-mode))
	   (list (cons "AUTOEXEC\\." 'bat-mode))
	   auto-mode-alist))

(autoload 'bat-mode "bat-mode"
  "DOS and Windows BAT files" t)


;;==========================================================
;; タブブラウザの設定 (tabbar.el)
;;==========================================================
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


;;==========================================================
;; web-modeの設定 (web-mode.el)
;;==========================================================
(require 'web-mode)

;; emacs 23以下の互換
(when (< emacs-major-version 24)
  (defalias 'prog-mode 'fundamental-mode))

(defun web-mode-hook ()
  "Hooks for Web mode."
  ;; 変更日時の自動修正
  (setq time-stamp-line-limit -200)
  (if (not (memq 'time-stamp write-file-hooks))
      (setq write-file-hooks
            (cons 'time-stamp write-file-hooks)))
  (setq time-stamp-format " %3a %3b %02d %02H:%02M:%02S %:y %Z")
  (setq time-stamp-start "Last modified:")
  (setq time-stamp-end "$")
  ;; web-modeの設定
  (setq web-mode-markup-indent-offset 2) ;; html indent
  (setq web-mode-css-indent-offset 2)    ;; css indent
  (setq web-mode-code-indent-offset 2)   ;; script indent(js,php,etc..)
  ;; htmlの内容をインデント
  ;; TEXTAREA等の中身をインデントすると副作用が起こったりするので
  ;; デフォルトではインデントしない
  ;;(setq web-mode-indent-style 2)
  ;; コメントのスタイル
  ;;   1:htmlのコメントスタイル(default)
  ;;   2:テンプレートエンジンのコメントスタイル
  ;;      (Ex. {# django comment #},{* smarty comment *},{{-- blade comment --}})
  (setq web-mode-comment-style 2)
  ;; color:#ff0000;等とした場合に指定した色をbgに表示しない
  ;;(setq web-mode-disable-css-colorization t)
  ;; 終了タグの自動補完をしない
  (setq web-mode-disable-auto-pairing t)
  ;;css,js,php,etc..の範囲をbg色で表示
  (setq web-mode-enable-block-faces t)
  (custom-set-faces
   '(web-mode-server-face
	 ((t (:background "grey"))))               ; template Blockの背景色
   '(web-mode-css-face
	 ((t (:background "grey18"))))             ; CSS Blockの背景色
   '(web-mode-javascript-face
	 ((t (:background "grey36"))))             ; javascript Blockの背景色
   )
  (setq web-mode-enable-heredoc-fontification t)
  )
(add-hook 'web-mode-hook 'web-mode-hook)

;; 色の設定
(custom-set-faces
 '(web-mode-doctype-face
   ((t (:foreground "#82AE46"))))              ; doctype
 '(web-mode-html-tag-face
   ((t (:foreground "#0000FF"))))              ; 要素名
 '(web-mode-html-attr-name-face
   ((t (:foreground "#c8644b"))))              ; 属性名など
 '(web-mode-html-attr-value-face
   ((t (:foreground "#008000"))))              ; 属性値
 '(web-mode-comment-face
   ((t (:foreground "#D9333F"))))              ; コメント
 '(web-mode-server-comment-face
   ((t (:foreground "#D9333F"))))              ; コメント
 '(web-mode-css-rule-face
   ((t (:foreground "#A0D8EF"))))              ; cssのタグ
 '(web-mode-css-pseudo-class-face
   ((t (:foreground "#FF7F00"))))              ; css 疑似クラス
 '(web-mode-css-at-rule-face
   ((t (:foreground "#FF7F00"))))              ; cssのタグ
 )

(setq auto-mode-alist
      (append '(
                ("\\.\\(html\\|xhtml\\|shtml\\|tpl\\)\\'" . web-mode)
                ("\\.php\\'" . web-mode)
                )
              auto-mode-alist))


;;==========================================================
;; emmet-modeの設定 (emmet-mode.el)
;;==========================================================
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; マークアップ言語全部で使う
(add-hook 'css-mode-hook  'emmet-mode) ;; css-modeで使う
(add-hook 'web-mode-hook  'emmet-mode) ;; web-modeで使う
(add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 2))) ;; indent はスペース2個
(eval-after-load "emmet-mode"
  '(define-key emmet-mode-keymap (kbd "C-j") nil)) ;; C-j は newline のままにしておく
(keyboard-translate ?\C-i ?\H-i) ;;C-i と Tabの被りを回避
(define-key emmet-mode-keymap (kbd "H-i") 'emmet-expand-line) ;; C-i で展開

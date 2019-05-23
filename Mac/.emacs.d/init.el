
;; load-path
(add-to-list 'load-path "~/.emacs.d/site-lisp")

;; ホームディレクトリを初期ディレクトリにする
(cd "~")

;; スクロールの設定
(defun scroll-down-with-lines ()
  "" (interactive) (scroll-down 1))
(defun scroll-up-with-lines ()
  "" (interactive) (scroll-up 1))
(global-set-key [wheel-up] 'scroll-down-with-lines)
(global-set-key [wheel-down] 'scroll-up-with-lines)
(global-set-key [double-wheel-up] 'scroll-down-with-lines)
(global-set-key [double-wheel-down] 'scroll-up-with-lines)
(global-set-key [triple-wheel-up] 'scroll-down-with-lines)
(global-set-key [triple-wheel-down] 'scroll-up-with-lines)


;; C-hの有効化 (前削除)
(global-set-key "\C-h" 'delete-backward-char)

;; Command-Key and Option-Key
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

;; ¥の代わりにバックスラッシュを入力する
(define-key global-map [?¥] [?\\])

;; 起動時の画面はいらない
(setq inhibit-startup-message t)

;; 対応する括弧をハイライトさせる
(show-paren-mode t)

;; 空ビープ音の割り当て
(setq ring-bell-function 'ignore)
(custom-set-variables)
(custom-set-faces)

;; ツールバーを消す
(tool-bar-mode -1)

;; タブブラウザの設定
;; - scratch buffer 以外をまとめてタブに表示する
;; - グループ化せずに*scratch*以外のタブを表示
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
 :background "gray90")		;バー自体の色
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


;; タブ幅変更
(setq-default tab-width 4)

;; バックアップファイルの作成をしない
(setq-default make-backup-files nil)

;; ■ Fontの設定
;; ◇ Rictyフォントの設定
;(set-face-attribute 'default nil
;					:family "Ricty" ;; font
;					:height 140)  ;; font size

;; Cocoa Emacs へのドラッグアンドドロップで, 
;; ファイルの内容の貼り付けを無効にする.
(define-key global-map [ns-drag-file] 'ns-find-file)


;; Cocoa Emacs へのドラッグアンドドロップで, 
;; 新規ウィンドウを開かないようにする.
(setq ns-pop-up-frames nil)


;; matlab-mode の設定
(autoload 'matlab-mode "matlab" "Enter Matlab mode." t)
(setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))
(autoload 'matlab-shell "matlab" "Interactive Matlab mode." t)


;; フォントフェイスの設定
;; - 種類ごとの色
(add-hook 'font-lock-mode-hook
		  '(lambda ()
			 (set-face-foreground 'font-lock-builtin-face "Orchid")
			 (set-face-foreground 'font-lock-comment-delimiter-face "Firebrick")  
			 (set-face-foreground 'font-lock-comment-face "Firebrick")  ; コメント
			 (set-face-foreground 'font-lock-constant-face "CadetBlue")
			 (set-face-foreground 'font-lock-doc-face "RosyBrown") 
			 (set-face-foreground 'font-lock-function-name-face "Blue1")
			 
										;   (set-face-foreground 'font-lock-keyword-face "Purple")
			 (set-face-foreground 'font-lock-keyword-face "9900cc")
			 
										;    (set-face-foreground 'font-lock-negation-char-face "")
			 (set-face-foreground 'font-lock-preprocessor-face "Orchid")
			 (set-face-foreground 'font-lock-string-face "RosyBrown") ; 文字列
			 (set-face-foreground 'font-lock-type-face "ForestGreen")
			 (set-face-foreground 'font-lock-variable-name-face "DarkGoldenrod")
			 (set-face-foreground 'font-lock-warning-face "Red1")
			 )
		  )



;; web-modeの設定
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
	 ((t (:background "grey"))))                  ; template Blockの背景色
   '(web-mode-css-face
	 ((t (:background "grey18"))))                ; CSS Blockの背景色
   '(web-mode-javascript-face
	 ((t (:background "grey36"))))                ; javascript Blockの背景色
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
                ("\\.php\\'" . php-mode)
                )
              auto-mode-alist))


;; emmet-modeの設定
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; マークアップ言語全部で使う
(add-hook 'css-mode-hook  'emmet-mode) ;; css-modeで使う
(add-hook 'web-mode-hook  'emmet-mode) ;; web-modeで使う
(add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 2))) ;; indent はスペース2個
(eval-after-load "emmet-mode"
  '(define-key emmet-mode-keymap (kbd "C-j") nil)) ;; C-j は newline のままにしておく
(keyboard-translate ?\C-i ?\H-i) ;;C-i と Tabの被りを回避
(define-key emmet-mode-keymap (kbd "H-i") 'emmet-expand-line) ;; C-i で展開

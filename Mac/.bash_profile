
# ■ javacの文字化け対策
alias javac="javac -J-Dfile.encoding=utf-8"
alias java="java -Dfile.encoding=utf-8"

# ■ emacsの設定
alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs"
alias sudoemacs="sudo /Applications/Emacs.app/Contents/MacOS/Emacs"

# ■ 環境変数EDITOR(テキストエディタ)の設定
export HOMEBREW_EDITOR="/usr/bin/emacs"


# ■ コマンド履歴の共有設定
function share_history {
 history -a
 history -c
 history -r
}
PROMPT_COMMAND='share_history'
shopt -u histappend

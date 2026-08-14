#!/bin/bash
set -euo pipefail

# このスクリプト自身の場所を dotfiles ディレクトリとする
DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# link <dotfiles内の相対パス> <リンク先>
# リンク先の親ディレクトリを作り、既存のリンクは張り替える（冪等）
link() {
    local src="$DOTFILES/$1"
    local dst="$2"
    if [ ! -e "$src" ]; then
        echo "skip (missing source): $src" >&2
        return
    fi
    mkdir -p "$(dirname "$dst")"
    ln -sfn "$src" "$dst"
    echo "link: $dst -> $src"
}

link .zshrc            ~/.zshrc
link .zshenv           ~/.zshenv
link .vimrc            ~/.vimrc
link .vim              ~/.vim
link .gitconfig        ~/.gitconfig
link .gitignore_global ~/.gitignore_global
link .tmux.conf        ~/.tmux.conf
link herdr_config.toml ~/.config/herdr/config.toml
link ghostty/config    ~/.config/ghostty/config

case "$(uname)" in
    Darwin)
        link .zshrc.osx                  ~/.zshrc.osx
        link .gnupg/mac-gpg-agent.conf   ~/.gnupg/gpg-agent.conf
        chmod 700 ~/.gnupg
        link .hammerspoon/init.lua       ~/.hammerspoon/init.lua
        ;;
    Linux)
        link .zshrc.ubuntu ~/.zshrc.ubuntu
        ;;
esac

# テンプレートは初回のみコピー（既存の .zshrc.local は上書きしない）
if [ ! -e ~/.zshrc.local ]; then
    cp "$DOTFILES/.zshrc.local.template" ~/.zshrc.local
    echo "copy: ~/.zshrc.local (from template)"
fi

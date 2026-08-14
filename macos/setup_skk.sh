#!/bin/bash
set -eu
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

mkdir -p "$SCRIPT_DIR/dict_work"
cd "$SCRIPT_DIR/dict_work"
curl -O https://skk-dev.github.io/dict/SKK-JISYO.L.gz
curl -O https://raw.githubusercontent.com/ymrl/SKK-JISYO.emoji-ja/master/SKK-JISYO.emoji-ja.utf8
curl -O https://raw.githubusercontent.com/uasi/skk-emoji-jisyo/refs/heads/master/SKK-JISYO.emoji.utf8
cp ./* ~/Library/Containers/net.mtgto.inputmethod.macSKK/Data/Documents/Dictionaries
# skkeleton (vim) は gzip 辞書を読めないため展開版も置く
gzip -dc SKK-JISYO.L.gz > ~/Library/Containers/net.mtgto.inputmethod.macSKK/Data/Documents/Dictionaries/SKK-JISYO.L

cd "$SCRIPT_DIR/../yaskkserv2"
cargo build --release
mkdir -p ~/.yaskkserv2/bin
mv ./target/release/yaskkserv2 ~/.yaskkserv2/bin
mv ./target/release/yaskkserv2_make_dictionary ~/.yaskkserv2/bin

# LaunchAgent を配置（ユーザー名がマシンごとに異なるため、テンプレートから $HOME を埋めて生成する）
mkdir -p ~/Library/LaunchAgents
sed "s|__HOME__|$HOME|g" "$SCRIPT_DIR/yaskkserv2.plist.template" > ~/Library/LaunchAgents/yaskkserv2.plist
launchctl bootout "gui/$(id -u)/yaskkserv2" 2>/dev/null || true
launchctl bootstrap "gui/$(id -u)" ~/Library/LaunchAgents/yaskkserv2.plist

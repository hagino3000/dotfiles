#!/bin/bash
mkdir -p dict_work
cd ./dict_work
curl -O https://skk-dev.github.io/dict/SKK-JISYO.L.gz
curl -O https://raw.githubusercontent.com/ymrl/SKK-JISYO.emoji-ja/master/SKK-JISYO.emoji-ja.utf8
curl -O https://raw.githubusercontent.com/uasi/skk-emoji-jisyo/refs/heads/master/SKK-JISYO.emoji.utf8
cp ./* ~/Library/Containers/net.mtgto.inputmethod.macSKK/Data/Documents/Dictionaries

cd ~/dev/dotfiles/yaskkserv2
cargo build --release;
mkdir -p ~/.yaskkserv2/bin
mv ~/dev/dotfiles/yaskkserv2/target/release/yaskkserv2 ~/.yaskkserv2/bin
mv ~/dev/dotfiles/yaskkserv2/target/release/yaskkserv2_make_dictionary ~/.yaskkserv2/bin

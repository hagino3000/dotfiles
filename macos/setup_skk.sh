#!/bin/bash
cd ./dictionaries
curl -O https://skk-dev.github.io/dict/SKK-JISYO.L.gz
curl -O https://raw.githubusercontent.com/ymrl/SKK-JISYO.emoji-ja/master/SKK-JISYO.emoji-ja.utf8
curl -O https://raw.githubusercontent.com/uasi/skk-emoji-jisyo/refs/heads/master/SKK-JISYO.emoji.utf8
cp ./* ~/Library/Containers/net.mtgto.inputmethod.macSKK/Data/Documents/Dictionaries

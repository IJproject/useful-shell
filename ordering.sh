#!/bin/sh

echo "「"$1"」のファイル名を整理します。"

# # 対象のディレクトリ
TARGET_DIR=$1
# ディレクトリの指定方法を調整可能
# TARGET_DIR="path/to/dir/"$1

# # カウンターの初期化
counter=1

# ファイルを先頭の数値に基づいてソートし、ループ処理
find "$TARGET_DIR" -type f -name "*-*" | sort -t '-' -k1,1n | while read filename; do

    # 新しいファイル名を生成（ファイル名の先頭にある数字をカウンターで置き換え）
    base=$(basename "$filename")
    newname=$(echo "$base" | sed -E "s|^[0-9]+[^-]*-(.*)|$counter-\1|")

    # フルパスの新しいファイル名を生成
    newpath=$(dirname "$filename")/"$newname"
    
    # ファイルをリネーム
    mv "$filename" "$newpath"
    
    # カウンターをインクリメント
    counter=$((counter + 1))
done

echo "ファイル名を整理が完了しました。"

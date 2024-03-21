#!/bin/sh

# 检查是否提供了输入文件
if [ -z "$1" ]; then
    echo "Usage: $0 <input_file>"
    exit 1
fi

# 输入文件
input_file="$1"

# 使用 awk 一次性处理整个文件
awk '
BEGIN { FS = " "; OFS = "\t\t"}
/^#/ { print; next }
{ print $2, $1 }' "$input_file" > "$input_file".tmp && mv "$input_file".tmp "$input_file"

echo "处理完成。"

#!/bin/bash

set -e

echo "--- Current Directory Content ---"
ls -R public/docs | head -n 20 # 打印前20行看看结构对不对

echo "--- Starting Flattening ---"

find public/docs -name "index.html" | while read -r index_file; do
    dir=$(dirname "$index_file")
    parent_dir=$(dirname "$dir")
    base_name=$(basename "$dir")

    if [ "$base_name" == "public" ] || [ "$base_name" == "docs" ]; then
        continue
    fi

    grandparent_dir=$(basename "$parent_dir")
    if [ "$grandparent_dir" == "docs" ]; then
        continue
    fi

    mv "$index_file" "${parent_dir}/${base_name}.html"
    rmdir "$dir" 2>/dev/null
done

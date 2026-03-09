#!/bin/bash

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

    mv -f "$index_file" "${parent_dir}/${base_name}.html"
    rmdir "$dir" 2>/dev/null || true
done

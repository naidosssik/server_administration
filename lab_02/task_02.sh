#!/bin/bash

answer_form() {
    local size=$1
    local units=(B K M G T P)
    local i=0
    while (( size > 1024 && i < ${#units[@]} - 1 )); do
        size=$((size / 1024))
        ((i++))
    done
    echo "${size}${units[i]}"
}

dir_size() {
    local dir=$1 
    if [ ! -d "$dir" ]; then
        echo "Директория '$dir' не существует"
        echo 0
        return
    fi

    local total_size=0
    while IFS= read -r -d '' file; do
        size=$(stat -f %z "$file")
        total_size=$((total_size + size))
    done < <(find "$dir" -type f -print0)

    echo $total_size
}

print_sizes() {
    local base_dir=$1
    local size=$(dir_size "$base_dir")
    if [ "$size" -eq 0 ] && [ ! -d "$base_dir" ]; then
        return
    fi
    echo "$base_dir: $(answer_form $size)"

    while IFS= read -r -d '' subdir; do
        print_sizes "$subdir"
    done < <(find "$base_dir" -mindepth 1 -maxdepth 1 -type d -print0)
}

if [ -z "$1" ]; then
    echo "Не указан путь к директории"
else
    print_sizes "$1"
fi


#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Неверное число аргументов. Укажите только путь к директории"
    exit 1
fi

dir="$1"

if [ ! -d "$dir" ]; then
    echo "Директория '$dir' не существует или недоступна"
    exit 1
fi

find "$dir" -maxdepth 1 -type f | while IFS= read -r filepath; do
    filename=$(basename "$filepath")
    if [[ "$filename" == *.* && "$filename" != .* ]]; then
        ext="${filename##*.}"
    else
        ext="no_extension"
    fi

    dir_fin="$dir/$ext"
    if [ ! -d "$dir_fin" ]; then
        mkdir -p "$dir_fin"
    fi

    mv "$filepath" "$dir_fin/"
done

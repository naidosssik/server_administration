#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Неверое число аргументов"
    read -p "Введите путь к директории: " DIR
    read -p "Введите расширение файла, в котором будет выполняться поиск: " EXT
    read -p "Введите число N (N - топ слов): " NWORD
else
    DIR="$1"
    EXT="$2"
    NWORD="$3"
fi

if [ ! -d "$DIR" ]; then
    echo "Директория '$DIR' не существует или недоступна"
    exit 1
fi

if ! [[ "$NWORD" =~ ^[1-9][0-9]*$ ]]; then
    echo "N должно быть положительным целым числом"
    exit 1
fi

temp_file=$(mktemp)

find "$DIR" -type f -name "*.$EXT" -exec cat {} + | tr '[:upper:]' '[:lower:]' > "$temp_file"

words_count=$(cat "$temp_file" | tr -cs '[:alpha:]' '\n' | sort | uniq -c | sort -nr)

rm "$temp_file"

echo "$words_count" | head -n "$NWORD" | awk '{printf "%s: %s\n", $2, $1}'

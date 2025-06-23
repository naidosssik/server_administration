#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Неверное число аргументов"
    read -p "Введите путь к директории для резервного копирования: " DIR_INI
    read -p "Введите путь к директории для сохранения архива: " DIR_FIN
else
    DIR_INI="$1"
    DIR_FIN="$2"
fi

if [ ! -d "$DIR_INI" ]; then
    echo "Директория '$DIR_INI' не существует или недоступна"
    exit 1
fi

if [ ! -d "$DIR_FIN" ]; then
    echo "Директория '$DIR_FIN' не существует или недоступна"
    exit 1
fi

DATE=backup_$(date +%F).tar.gz
mkdir -p "$DIR_FIN"
tar -czf "$DIR_FIN/$DATE" "$DIR_INI"

if [ "$?" -eq 0 ]; then
    echo "Архив создан: $DIR_FIN/$DATE"
    
else 
    echo "Ошибка при создании архива"
fi

find "$DIR_FIN" -name "backup_*.tar.gz" -mtime +7 -delete

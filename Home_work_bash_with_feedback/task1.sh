#!/bin/bash

TARGET_FILE=$1

echo "--- Список файлов и их типы ---"
file *

echo -e "\n--- Проверка файла $TARGET_FILE ---"
if [ -z "$TARGET_FILE" ]; then
    echo "Аргумент не передан."
elif [ -e "$TARGET_FILE" ]; then
    echo "Файл '$TARGET_FILE' существует."
else
    echo "Файл '$TARGET_FILE' не найден."
fi

echo -e "\n--- Права доступа ---"
for item in *; do
    perms=$(stat -c "%A" "$item")
    echo "Объект: $item | Права: $perms"
done
#!/bin/bash
SOURCE_DIR=$1
BACKUP_DIR="./backups"
LOG_FILE="./backup.log"
DATE=$(date +%Y-%m-%d)

mkdir -p "$BACKUP_DIR"
count=0

for file in "$SOURCE_DIR"/*; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        cp "$file" "$BACKUP_DIR/${filename}_$DATE"
        echo "Скопирован: $filename" >> "$LOG_FILE"
        ((count++))
    fi
done

echo "Резервное копирование завершено. Файлов: $count. Лог: $LOG_FILE"
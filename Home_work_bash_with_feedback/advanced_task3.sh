#!/bin/bash
DIR="/path/to/target"
LOG="/var/log/sort.log"

mkdir -p "$DIR/Images" "$DIR/Documents"

for f in "$DIR"/*; do
    case "$f" in
        *.jpg|*.png|*.gif) mv "$f" "$DIR/Images/" && echo "$(date): $f -> Images" >> "$LOG" ;;
        *.txt|*.pdf|*.docx) mv "$f" "$DIR/Documents/" && echo "$(date): $f -> Documents" >> "$LOG" ;;
    esac
done
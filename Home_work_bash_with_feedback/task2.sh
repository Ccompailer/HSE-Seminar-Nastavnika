#!/bin/bash
echo "Текущий PATH: $PATH"
if [ -n "$1" ]; then
    export PATH="$PATH:$1"
    echo "Новый PATH (в текущей сессии): $PATH"
else
    echo "Директория для добавления не указана."
fi
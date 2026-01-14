#!/bin/bash
read -p "Введите число: " num

if [ "$num" -gt 0 ]; then
    echo "Число положительное."
    i=1
    while [ $i -le "$num" ]; do
        echo "Счет: $i"
        ((i++))
    done
elif [ "$num" -lt 0 ]; then
    echo "Число отрицательное."
else
    echo "Это ноль."
fi
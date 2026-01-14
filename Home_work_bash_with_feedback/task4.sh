#!/bin/bash

say_hello() {
    echo "Hello, $1"
}

sum_numbers() {
    local result=$(( $1 + $2 ))
    echo $result
}

say_hello "User"
echo "Сумма 5 и 10 равна: $(sum_numbers 5 10)"
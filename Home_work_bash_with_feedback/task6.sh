#!/bin/bash

cat input.txt 2>/dev/null || echo "Файл input.txt не найден"

wc -l < input.txt > output.txt 2>/dev/null

ls non_existent_file.txt 2> error.log
#!/bin/bash
MEM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}' | cut -d. -f1)

echo "--- Статистика ---"
echo "CPU Load: $(uptime | awk '{print $10}')"
echo "Disk Usage: $(df -h / | tail -1 | awk '{print $5}')"

if [ "$MEM_USAGE" -gt 80 ]; then
    echo "ВНИМАНИЕ: Память > 80% ($MEM_USAGE%)"
    echo "Топ процессов по памяти:"
    ps aux --sort=-%mem | head -n 5
fi
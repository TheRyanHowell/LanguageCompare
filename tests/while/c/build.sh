#!/bin/bash
START=$(date +%s.%N)
gcc -o "while" while.c
END=$(date +%s.%N)
echo "$END - $START" | bc > buildtime.txt

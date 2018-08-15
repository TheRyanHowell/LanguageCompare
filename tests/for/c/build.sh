#!/bin/bash
START=$(date +%s.%N)
gcc -o "for" for.c
END=$(date +%s.%N)
echo "$END - $START" | bc > buildtime.txt

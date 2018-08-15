#!/bin/bash
START=$(date +%s.%N)
g++ -o "while" while.cpp
END=$(date +%s.%N)
echo "$END - $START" | bc > buildtime.txt

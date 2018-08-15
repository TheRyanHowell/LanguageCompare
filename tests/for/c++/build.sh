#!/bin/bash
START=$(date +%s.%N)
g++ -o "for" for.cpp
END=$(date +%s.%N)
echo "$END - $START" | bc > buildtime.txt

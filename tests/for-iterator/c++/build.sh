#!/bin/bash
START=$(date +%s.%N)
g++ -o "for-iterator" for-iterator.cpp
END=$(date +%s.%N)
echo "$END - $START" | bc > buildtime.txt

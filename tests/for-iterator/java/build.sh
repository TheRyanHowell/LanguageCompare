#!/bin/bash
START=$(date +%s.%N)
javac ForIterator.java
END=$(date +%s.%N)
echo "$END - $START" | bc > buildtime.txt

#!/bin/bash
START=$(date +%s.%N)
javac For.java
END=$(date +%s.%N)
echo "$END - $START" | bc > buildtime.txt

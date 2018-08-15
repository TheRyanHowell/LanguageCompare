#!/bin/bash
START=$(date +%s.%N)
javac While.java
END=$(date +%s.%N)
echo "$END - $START" | bc > buildtime.txt

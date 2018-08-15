#!/bin/bash
START=$(date +%s.%N)
perl ./while.pl 1> stdout.txt 2> stderr.txt
END=$(date +%s.%N)
echo "$END - $START" | bc > runtime.txt

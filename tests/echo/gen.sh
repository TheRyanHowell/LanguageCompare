#!/bin/bash
for i in {1..1000}
do
    RAND_STRING=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
    echo "$RAND_STRING" >> dataset.txt
done

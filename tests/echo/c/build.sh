#!/bin/bash
touch echo.c
cat > echo.c <<- EOF
#include <stdio.h>
int main ()
{
EOF

while STR='' read -r line || [[ -n "$line" ]]; do
    echo "  printf(\"$line\");" >> echo.c
done < "../dataset.txt"

cat >> echo.c <<- EOF
  return 0;
}
EOF

START=$(date +%s.%N)
gcc -o "echo" echo.c
END=$(date +%s.%N)
echo "$END - $START" | bc > buildtime.txt

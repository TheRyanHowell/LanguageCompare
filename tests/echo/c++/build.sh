#!/bin/bash
touch echo.cpp
cat > echo.cpp <<- EOF
#include <iostream>
using namespace std;
int main ()
{
EOF

while STR='' read -r line || [[ -n "$line" ]]; do
    echo "  cout << \"$line\";" >> echo.cpp
done < "../dataset.txt"

cat >> echo.cpp <<- EOF
  return 0;
}
EOF

START=$(date +%s.%N)
g++ -o "echo" echo.cpp
END=$(date +%s.%N)
echo "$END - $START" | bc > buildtime.txt

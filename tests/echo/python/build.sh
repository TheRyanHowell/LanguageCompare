#!/bin/bash
touch echo.py
chmod +x echo.py
cat > echo.py <<- EOF
#!/usr/bin/env python3
EOF

while STR='' read -r line || [[ -n "$line" ]]; do
    echo "print(\"$line\", end='')" >> echo.py
done < "../dataset.txt"

#!/bin/bash
touch echo.js
cat > echo.js <<- EOF
#!/usr/bin/env node
'use strict';
EOF

while STR='' read -r line || [[ -n "$line" ]]; do
    echo "process.stdout.write(\"$line\");" >> echo.js
done < "../dataset.txt"

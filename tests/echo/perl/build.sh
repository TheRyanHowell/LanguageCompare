#!/bin/bash
touch echo.pl
cat > echo.pl <<- EOF
#!/usr/bin/perl
use strict;
use warnings;
EOF

while STR='' read -r line || [[ -n "$line" ]]; do
    echo "print \"$line\";" >> echo.pl
done < "../dataset.txt"

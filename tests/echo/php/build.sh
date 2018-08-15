#!/bin/bash
touch echo.php
echo "<?php" > echo.php
while STR='' read -r line || [[ -n "$line" ]]; do
    echo "echo '$line';" >> echo.php
done < "../dataset.txt"

#!/bin/bash
touch Echo.java
chmod +x Echo.java
cat > Echo.java <<- EOF
public class Echo {
    public static void main(String[] args) {
EOF

while STR='' read -r line || [[ -n "$line" ]]; do
    echo "        System.out.println(\"$line\");" >> Echo.java
done < "../dataset.txt"

cat >> Echo.java <<- EOF
    }
}
EOF

START=$(date +%s.%N)
javac Echo.java
END=$(date +%s.%N)
echo "$END - $START" | bc > buildtime.txt

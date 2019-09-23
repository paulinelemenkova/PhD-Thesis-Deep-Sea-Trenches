#!/bin/sh
# Unix prog: awk, mktemp, rm
# AWK script to reshape initial long table.
# Purpose: remove unnecessary rows, only select necessary columns, reshape columns => rows
# Initial table: 12726 rows 5 columns; Output table:  201  rows  11 columns.
# cd /Users/pauline/Documents/Octave
# pwd
# Unix: mktemp make tempfile
TMPFILE0=$(mktemp)
TMPFILE1=$(mktemp)
TMPFILE2=$(mktemp)
TMPFILE3=$(mktemp)
TMPFILE4=$(mktemp)
TMPFILE5=$(mktemp)
TMPFILE6=$(mktemp)
TMPFILE7=$(mktemp)
TMPFILE8=$(mktemp)
TMPFILE9=$(mktemp)
TMPFILE10=$(mktemp)
# awk: reshaped initial GMT table of 62 profiles (select two necessary columns; FS as space).
awk 'BEGIN{FS=" "; OFS=" "} {print $3, $5}' table2.txt > $TMPFILE0
# select only profile 1, save as table as 'table_10pr' with X and Y (location and depths):
awk '/profile -L0-00/,/profile -L0-01/' $TMPFILE0 > table_10p.csv
# awk: only take Y column (field 5) from the initial table (depths for all profiles, 12726 rows)
awk '{print $5}' table2.txt > $TMPFILE1
# awk: select profile i from the Y column (print section of file between two regex).
# i: 1, 7, 14, 21, 28, 35, 42, 49, 56, 62.
awk '/-L0-07/,/-L0-08/' $TMPFILE1 > table_p07.csv
awk '/-L0-14/,/-L0-15/' $TMPFILE1 > table_p14.csv
awk '/-L0-21/,/-L0-22/' $TMPFILE1 > table_p21.csv
awk '/-L0-28/,/-L0-29/' $TMPFILE1 > table_p28.csv
awk '/-L0-35/,/-L0-36/' $TMPFILE1 > table_p35.csv
awk '/-L0-42/,/-L0-43/' $TMPFILE1 > table_p42.csv
awk '/-L0-49/,/-L0-50/' $TMPFILE1 > table_p49.csv
awk '/-L0-56/,/-L0-57/' $TMPFILE1 > table_p56.csv
awk '/-L0-62/,EOF' $TMPFILE1 > table_p62.csv
# awk: add single Y column of the profile i to the table 'table_10p.csv'; save output to 'table_10KKT.csv' (here: Kuril-Kamchatka Trench)
awk '{print $0}' < table_p07.csv | tee check.csv | paste table_10p.csv - > $TMPFILE2
awk '{print $0}' < table_p14.csv | paste $TMPFILE2 - > $TMPFILE3
awk '{print $0}' < table_p21.csv | paste $TMPFILE3 - > $TMPFILE4
awk '{print $0}' < table_p28.csv | paste $TMPFILE4 - > $TMPFILE5
awk '{print $0}' < table_p35.csv | paste $TMPFILE5 - > $TMPFILE6
awk '{print $0}' < table_p42.csv | paste $TMPFILE6 - > $TMPFILE7
awk '{print $0}' < table_p49.csv | paste $TMPFILE7 - > $TMPFILE8
awk '{print $0}' < table_p56.csv | paste $TMPFILE8 - > $TMPFILE9
awk '{print $0}' < table_p62.csv | paste $TMPFILE9 - > $TMPFILE10
# awk: delete header and tail (print only lines which do NOT match regex)
awk '!/-L0-/' $TMPFILE10 > table_10KKT.csv
# remove auxiliary files
rm -f table_p07.csv table_p14.csv table_p21.csv table_p28.csv table_p35.csv table_p42.csv table_p49.csv table_p56.csv table_p62.csv check.csv
rm -f $TMPFILE0 $TMPFILE1 $TMPFILE2 $TMPFILE3 $TMPFILE4 $TMPFILE5 $TMPFILE6 $TMPFILE7 $TMPFILE8 $TMPFILE9 $TMPFILE10
# count number of lines
awk 'END{print NR}' table2.txt
# ans: 12726
awk 'END{print NR}' table_10KKT.csv
# ans: 201
# RESULT: table reshaped. Initial: 12726 rows 5 columns; Output:  201  rows  11 columns.
# Column 1: cross-section line 400 km long (-200:200 km). Columns 2-11: profiles

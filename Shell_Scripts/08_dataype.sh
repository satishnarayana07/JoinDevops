#!/bin/bash
NUM1=100
NUM2=satishnarayana

SUM=$((NUM1 + NUM2))
echo "The SUM is: $SUM"

#ARRAYS
FRUITS=("Apple" "Banana" "pomogranate")
echo "Fruits are: ${FRUITS[@]}"
echo "The first fruit is: ${FRUITS[0]}"
echo "The Second Fruit is: ${FRUITS[1]}"
echo "The Third Fruit is : ${FRUITS[2]}"


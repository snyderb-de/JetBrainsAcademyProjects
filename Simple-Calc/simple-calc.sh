#!/bin/bash

# Start with message "Enter an arithmetic operation:"
echo "Enter an arithmetic operation:"

# Read two numbers and one operator on one line from standard input
read num1 operator num2

# Check if the numbers are integers. Numbers can be positive or negative or zeros.

function is_int() {
    [[ $1 =~ ^-?[0-9]+$ ]]
}

# Check is the operator is correct. Operator can be multiplication, division, addition or subtraction. and print test results.

if is_int "$num1" && is_int "$num2" && [[ "$operator" =~ ^[+*/-]$ ]]; then
    # echo "Operation check passed!"
    # Perform the operation and echo only the result.
    echo $(($num1 $operator $num2))

else
    echo "Operation check failed!"
fi

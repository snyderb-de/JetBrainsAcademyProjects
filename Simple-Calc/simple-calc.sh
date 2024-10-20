#!/bin/bash

# Start with the welcome message and the initial prompt, log them to the file
echo "Welcome to the basic calculator!" | tee operation_history.txt
echo "Enter an arithmetic operation or type 'quit' to quit:" | tee -a operation_history.txt

while true; do
    # Read the entire input as a single argument
    read input

    # Check if the input is 'quit'
    if [[ "$input" == "quit" ]]; then
        echo "$input" >> operation_history.txt
        echo "Goodbye!" | tee -a operation_history.txt
        exit 0
    fi

    # Extract numbers and operator using regex (single input argument)
    if [[ "$input" =~ ^[[:space:]]*([+-]?[0-9]+([.][0-9]+)?)\ *([+\*/^-])\ *([+-]?[0-9]+([.][0-9]+)?)[[:space:]]*$ ]]; then
        num1="${BASH_REMATCH[1]}"
        operator="${BASH_REMATCH[3]}"
        num2="${BASH_REMATCH[4]}"

        # Use bc to calculate the result for valid inputs
        if [[ "$operator" == "^" ]]; then
            # Handle exponentiation using bc
            result=$(echo "$num1 ^ $num2" | bc -l)
        else
            # Use bc to calculate the result for other operators (+, -, *, /)
            result=$(echo "scale=2; $num1 $operator $num2" | bc -l)
        fi

        # Log the valid operation and result to operation_history.txt
        echo "$input" >> operation_history.txt
        echo "$result" >> operation_history.txt

        # Print only the result to the terminal
        echo "$result"
    else
        # Log the invalid operation and error message
        echo "$input" >> operation_history.txt
        echo "Operation check failed!" | tee -a operation_history.txt
    fi

    # Prompt for the next input and log it to the file
    echo "Enter an arithmetic operation or type 'quit' to quit:" | tee -a operation_history.txt
done

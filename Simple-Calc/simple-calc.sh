#!/bin/bash

# Start with welcome message
echo "Welcome to the basic calculator!" | tee -a operation_history.txt
echo "Enter an arithmetic operation or type 'quit' to quit:" | tee -a operation_history.txt

while true; do
    # Read an arithmetic operation from standard input
    read -r input

    # Check if the input is 'quit'
    if [[ "$input" == "quit" ]]; then
        echo "$input" >> operation_history.txt
        echo "Goodbye!" | tee -a operation_history.txt
        exit 0
    fi

    # Extract numbers and operator using regex
    if [[ "$input" =~ ^([+-]?[0-9]+([.][0-9]+)?)\ *([+\*/^-])\ *([+-]?[0-9]+([.][0-9]+)?)$ ]]; then
        num1="${BASH_REMATCH[1]}"
        operator="${BASH_REMATCH[3]}"
        num2="${BASH_REMATCH[4]}"

        # Function to check if the input is a valid number (integer or float, positive or negative)
        function is_number() {
            [[ $1 =~ ^-?[0-9]+([.][0-9]+)?$ ]]
        }

        # Check if both inputs are valid numbers and the operator is correct (+, -, *, /, ^)
        if is_number "$num1" && is_number "$num2" && [[ "$operator" =~ ^[+\*/^-]$ ]]; then
            if [[ "$operator" == "^" ]]; then
                # Handle exponentiation using bc
                result=$(echo "$num1 ^ $num2" | bc -l)
            else
                # Use bc to calculate the result for other operators (+, -, *, /)
                result=$(echo "scale=2; $num1 $operator $num2" | bc -l)
            fi

            # Log the operation and result to operation_history.txt
            echo "$input" >> operation_history.txt
            echo "$result" >> operation_history.txt

            # Print only the result to terminal
            echo "$result"
        else
            echo "Operation check failed!"
        fi
    else
        echo "Operation check failed!"
    fi

    # Prompt for the next input and log it to the file
    echo "Enter an arithmetic operation or type 'quit' to quit:" | tee -a operation_history.txt
done

#!/bin/bash

# Print the welcome message
echo "Hello $USER!"

# Function to print the main menu
print_menu() {
    echo "------------------------------"
    echo "| Hyper Commander            |"
    echo "| 0: Exit                    |"
    echo "| 1: OS info                 |"
    echo "| 2: User info               |"
    echo "| 3: File and Dir operations |"
    echo "| 4: Find Executables        |"
    echo "------------------------------"
}

# Function to print the file menu
print_file_menu() {
    echo "---------------------------------------------------"
    echo "| 0 Main menu | 'up' To parent | 'name' To select |"
    echo "---------------------------------------------------"
}

# Function to list files and directories
list_files_and_directories() {
    echo "The list of files and directories:"
    arr=(*)  # Use globbing to get the list of files and directories
    for item in "${arr[@]}"; do
        if [[ -f "$item" ]]; then
            echo "F $item"
        elif [[ -d "$item" ]]; then
            echo "D $item"
        fi
    done
}

while true; do
    print_menu
    read -p "> " option

    case $option in
        0)
            echo "Farewell!"
            break
            ;;
        1)
            echo "Operating System: $(uname -s)"
            echo "Node Name: $(uname -n)"
            ;;
        2)
            echo "User Info: $(whoami)"
            ;;
        3)
            while true; do
                list_files_and_directories
                print_file_menu
                read -p "> " file_option

                if [[ "$file_option" == "0" ]]; then
                    break
                elif [[ "$file_option" == "up" ]]; then
                    echo "Not implemented!"
                else
                    found=false
                    for item in "${arr[@]}"; do
                        if [[ "$file_option" == "$item" ]]; then
                            echo "Not implemented!"
                            found=true
                            break
                        fi
                    done

                    if [[ "$found" == false ]]; then
                        echo "Invalid input!"
                    fi
                fi
            done
            ;;
        4)
            echo "Not implemented!"
            ;;
        *)
            echo "Invalid option!"
            ;;
    esac
done
